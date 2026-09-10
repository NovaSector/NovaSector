from __future__ import annotations

import gc
import hashlib
import io
import json
import math
import os
import random
import subprocess
import threading
import time
import warnings
import wave
from pathlib import Path
from typing import Any

# torchao fires UserWarnings (AffineQuantizedTensor / PlainLayout deprecation)
# on every quantized-tensor op, i.e. every inference. Cosmetic only. The
# PYTHONWARNINGS env var can't target this because it end-anchors the module
# name; a real filter matched against the submodule prefix does the job.
warnings.filterwarnings("ignore", category=UserWarning, module=r"torchao\..*")

TORCH_THREADS = os.getenv("POCKETTTS_TORCH_THREADS", "").strip()
if TORCH_THREADS:
    os.environ.setdefault("OMP_NUM_THREADS", TORCH_THREADS)
    os.environ.setdefault("MKL_NUM_THREADS", TORCH_THREADS)
    os.environ.setdefault("OPENBLAS_NUM_THREADS", TORCH_THREADS)

print("[tts-pocket] Starting process and importing dependencies.", flush=True)

import numpy as np
from flask import Flask, abort, jsonify, make_response, request, send_file
from pocket_tts import TTSModel
from pydub import AudioSegment

if TORCH_THREADS:
    try:
        import torch

        torch.set_num_threads(int(TORCH_THREADS))
        torch.set_num_interop_threads(max(1, min(2, int(TORCH_THREADS))))
    except Exception as error:
        print(f"[tts-pocket] Failed to set torch thread count: {error}", flush=True)

print("[tts-pocket] Dependencies imported.", flush=True)

from voice_catalog import VoiceDefinition, load_catalog, resolve_source


BASE_DIR = Path(__file__).resolve().parent
VOICE_CONFIG_PATH = Path(os.getenv("POCKETTTS_VOICE_CONFIG", BASE_DIR / "voices.json")).resolve()
CACHE_DIR = Path(os.getenv("POCKETTTS_CACHE_DIR", BASE_DIR / "cache")).resolve()

# Permanent (no TTL) cache keyed on exact voice+text match,
SYNTH_CACHE_DIR = Path(os.getenv("POCKETTTS_SYNTH_CACHE_DIR", CACHE_DIR / "synth")).resolve()
SYNTH_CACHE_VARIANTS = int(os.getenv("POCKETTTS_SYNTH_CACHE_VARIANTS", "5"))

AUTHORIZATION_TOKEN = os.getenv("TTS_AUTHORIZATION_TOKEN") or os.getenv("POCKETTTS_AUTHORIZATION_TOKEN") or ""
if not AUTHORIZATION_TOKEN:
    raise SystemExit(
        "[tts-pocket] FATAL: no auth token configured - set TTS_AUTHORIZATION_TOKEN "
        "(or POCKETTTS_AUTHORIZATION_TOKEN) before starting."
    )
HOST = os.getenv("POCKETTTS_HOST", "0.0.0.0")
PORT = int(os.getenv("POCKETTTS_PORT", "5002"))
WAITRESS_THREADS = int(os.getenv("POCKETTTS_THREADS", "2"))

MODEL_LANGUAGE = os.getenv("POCKETTTS_LANGUAGE", "english")
MODEL_CONFIG = os.getenv("POCKETTTS_MODEL_CONFIG", "").strip() or None
MODEL_TEMPERATURE = float(os.getenv("POCKETTTS_TEMPERATURE", "0.7"))
MODEL_LSD_DECODE_STEPS = int(os.getenv("POCKETTTS_LSD_DECODE_STEPS", "1"))
MODEL_EOS_THRESHOLD = float(os.getenv("POCKETTTS_EOS_THRESHOLD", "-4.0"))
MODEL_NOISE_CLAMP = os.getenv("POCKETTTS_NOISE_CLAMP", "").strip()
MODEL_QUANTIZE = os.getenv("POCKETTTS_QUANTIZE", "0").strip().lower() in {"1", "true", "yes", "on"}

MAX_TEXT_CHARS = int(os.getenv("POCKETTTS_MAX_TEXT_CHARS", "300"))
OGG_BITRATE = os.getenv("POCKETTTS_OGG_BITRATE", "64k")
ENABLE_PITCH = os.getenv("POCKETTTS_ENABLE_PITCH", "0").strip().lower() in {"1", "true", "yes", "on"}
PRELOAD_MODEL = os.getenv("POCKETTTS_PRELOAD_MODEL", "0").strip().lower() in {"1", "true", "yes", "on"}
PRELOAD_VOICES = os.getenv("POCKETTTS_PRELOAD_VOICES", "0").strip().lower() in {"1", "true", "yes", "on"}
BACKGROUND_WARMUP = os.getenv("POCKETTTS_BACKGROUND_WARMUP", "1").strip().lower() in {"1", "true", "yes", "on"}
WARMUP_VOICES = os.getenv("POCKETTTS_WARMUP_VOICES", "").strip()
LOG_TIMINGS = os.getenv("POCKETTTS_LOG_TIMINGS", "1").strip().lower() in {"1", "true", "yes", "on"}

BLIP_SAMPLE_RATE = 24_000


SFX_DIR = Path(os.getenv("POCKETTTS_SFX_DIR", BASE_DIR / "sfx")).resolve()
RADIO_START_FILES = ["on1.wav", "on2.wav"]
RADIO_END_FILES = ["off1.wav", "off2.wav", "off3.wav", "off4.wav"]
RADIO_STATIC_FILE = "diffstatic.wav"
SYNTH_IMPULSE_FILE = "SynthImpulse.wav"
ROOM_IMPULSE_FILE = "RoomImpulse.wav"
# tg mixes the static in at `static * 0.2`; 0.2 linear is ~-14 dB.
RADIO_STATIC_GAIN_DB = -14.0

# Radio-gibberish "corruption burst" approximation (see request_is_radio_gibberish).
GIBBERISH_MIN_BURSTS = 2
GIBBERISH_MAX_BURSTS = 4
GIBBERISH_BURST_MIN_FRACTION = 0.05
GIBBERISH_BURST_MAX_FRACTION = 0.12
GIBBERISH_DUCK_DB = -18.0
GIBBERISH_STATIC_GAIN_DB = -6.0


RADIO_VOICE_FILTERS = ["highpass=f=300", "lowpass=f=3000", "asoftclip=type=tanh"]


SILICON_COMPLEX_TAIL = (
    "aresample=44100 [re_1]; [re_1] apad=pad_dur=2 [in_1]; [in_1] asplit=2 [in_1_1] [in_1_2]; "
    "[in_1_1] [1] afir=dry=10:wet=10 [reverb_1]; [in_1_2] [reverb_1] amix=inputs=2:weights=8 1 [mix_1]; "
    "[mix_1] asplit=2 [mix_1_1] [mix_1_2]; [mix_1_1] [2] afir=dry=1:wet=1 [reverb_2]; "
    "[mix_1_2] [reverb_2] amix=inputs=2:weights=10 1 [mix_2]; "
    "[mix_2] equalizer=f=7710:t=q:w=0.6:g=-6,equalizer=f=33:t=q:w=0.44:g=-10 [out]; "
    "[out] alimiter=level_in=1:level_out=1:limit=0.5:attack=5:release=20:level=disabled"
)

app = Flask(__name__)
_model: TTSModel | None = None
_model_lock = threading.Lock()
_inference_lock = threading.Lock()
_voice_states: dict[tuple[str, str], dict[str, Any]] = {}
_voice_state_lock = threading.Lock()
_sfx_cache: dict[str, AudioSegment] = {}
_sfx_lock = threading.Lock()


def log(message: str) -> None:
    print(f"[tts-pocket] {message}", flush=True)


def log_timing(message: str) -> None:
    if LOG_TIMINGS:
        log(message)


def get_model() -> TTSModel:
    global _model
    if _model is not None:
        return _model

    with _model_lock:
        if _model is not None:
            return _model

        kwargs: dict[str, Any] = {
            "temp": MODEL_TEMPERATURE,
            "lsd_decode_steps": MODEL_LSD_DECODE_STEPS,
            "eos_threshold": MODEL_EOS_THRESHOLD,
            "quantize": MODEL_QUANTIZE,
        }
        if MODEL_NOISE_CLAMP:
            kwargs["noise_clamp"] = float(MODEL_NOISE_CLAMP)
        if MODEL_CONFIG:
            kwargs["config"] = MODEL_CONFIG
        else:
            kwargs["language"] = MODEL_LANGUAGE

        log("Loading PocketTTS model. First run may download model assets.")
        _model = TTSModel.load_model(**kwargs)
        log("PocketTTS model loaded.")
        return _model


def get_voice_state(voice: VoiceDefinition) -> dict[str, Any]:
    source = resolve_source(voice.source, VOICE_CONFIG_PATH)
    cache_key = (voice.name, source)
    cached = _voice_states.get(cache_key)
    if cached is not None:
        return cached

    with _voice_state_lock:
        cached = _voice_states.get(cache_key)
        if cached is not None:
            return cached

        model = get_model()
        log(f"Loading voice state for {voice.name}.")
        with _inference_lock:
            state = model.get_state_for_audio_prompt(source, truncate=True)
        log(f"Voice state loaded for {voice.name}.")
        _voice_states[cache_key] = state
        return state


_voice_catalog_cache: list[VoiceDefinition] | None = None
_voice_catalog_lock = threading.Lock()


def voices() -> list[VoiceDefinition]:
    # find_voice() runs on every /tts* request (up to 5 per spoken line), so this
    # gets called constantly - cache it instead of re-reading and re-parsing
    # voices.json from disk every time. /voices/reload clears the cache.
    global _voice_catalog_cache
    if _voice_catalog_cache is not None:
        return _voice_catalog_cache
    with _voice_catalog_lock:
        if _voice_catalog_cache is None:
            _voice_catalog_cache = load_catalog(VOICE_CONFIG_PATH)
        return _voice_catalog_cache


def voice_names() -> list[str]:
    return [voice.name for voice in voices()]


def find_voice(name: str) -> VoiceDefinition | None:
    for voice in voices():
        if voice.name == name:
            return voice
    return None


def require_authorization() -> None:
    if request.headers.get("Authorization", "") != AUTHORIZATION_TOKEN:
        abort(401)


def request_text() -> str:
    payload = request.get_json(silent=True) or {}
    text = str(payload.get("text", ""))
    return text[:MAX_TEXT_CHARS]


def request_text_radio() -> str:
    # The radio-gibberish request sends raw_text/gibberish_text instead of text.
    # We don't garble here, so fall back to whichever the caller provided.
    payload = request.get_json(silent=True) or {}
    text = payload.get("text")
    if text is None:
        text = payload.get("gibberish_text", payload.get("raw_text", ""))
    return str(text)[:MAX_TEXT_CHARS]


def request_is_radio_gibberish() -> bool:
    # The BYOND client always sends raw_text/gibberish_text as identical strings
    # (no client-side garbling), so there's nothing to diff word-for-word here -
    # this just distinguishes "this is the corrupted-variant request" from the
    # plain radio call, and random_corruption_bursts() approximates the effect.
    payload = request.get_json(silent=True) or {}
    return payload.get("text") is None and (
        "raw_text" in payload or "gibberish_text" in payload
    )


def request_pitch() -> int:
    raw_pitch = request.args.get("pitch", "0")
    try:
        return max(-12, min(12, int(float(raw_pitch))))
    except ValueError:
        return 0


def request_filters() -> tuple[str, set[str]]:
    filter_chain = request.args.get("filter", "").replace('"', "")
    special_filters = {
        item.strip().lower()
        for item in request.args.get("special_filters", "").split("|")
        if item.strip()
    }
    if request.args.get("silicon", ""):
        special_filters.add("silicon")
    return filter_chain, special_filters


def synthesize_text_wav(voice: VoiceDefinition, text: str) -> bytes:
    model = get_model()
    voice_state = get_voice_state(voice)
    with _inference_lock:
        audio = model.generate_audio(voice_state, text)
    return tensor_to_wav_bytes(audio, model.sample_rate)


_synth_cache_lock = threading.Lock()

def _synth_config_fingerprint() -> str:
    return "\0".join(
        str(part)
        for part in (
            MODEL_LANGUAGE,
            MODEL_CONFIG,
            MODEL_TEMPERATURE,
            MODEL_LSD_DECODE_STEPS,
            MODEL_EOS_THRESHOLD,
            MODEL_NOISE_CLAMP,
            MODEL_QUANTIZE,
        )
    )

def synthesize_text_wav_cached(voice: VoiceDefinition, text: str) -> bytes:
    if SYNTH_CACHE_VARIANTS <= 0:
        return synthesize_text_wav(voice, text)

    key = hashlib.sha1(
        f"{_synth_config_fingerprint()}\0{voice.name}\0{source}\0{text}".encode("utf-8")
    ).hexdigest()
    key_dir = SYNTH_CACHE_DIR / key
    with _synth_cache_lock:
        existing = sorted(key_dir.glob("*.wav")) if key_dir.exists() else []
        if len(existing) >= SYNTH_CACHE_VARIANTS:
            return random.choice(existing).read_bytes()
        next_index = len(existing)

    wav_bytes = synthesize_text_wav(voice, text)
    key_dir.mkdir(parents=True, exist_ok=True)
    final_path = key_dir / f"{next_index}.wav"
    temp_path = key_dir / f"{next_index}.wav.tmp{os.getpid()}.{threading.get_ident()}"
    temp_path.write_bytes(wav_bytes)
    os.replace(temp_path, final_path)
    return wav_bytes


def synthesize_blip_wav(voice_name: str, text: str, pitch: int) -> bytes:
    seed = int(hashlib.sha1(voice_name.encode("utf-8")).hexdigest()[:8], 16)
    rng = random.Random(seed)
    base_frequency = 170 + rng.randint(0, 180)
    pitch_factor = math.pow(2, pitch / 12) if ENABLE_PITCH else 1.0

    pcm = bytearray()
    emitted = False
    for index, char in enumerate(text.upper()):
        if len(pcm) / 2 >= BLIP_SAMPLE_RATE * 7:
            break
        if char.isspace():
            pcm.extend(silence_samples(80))
            continue
        if not char.isalnum():
            pcm.extend(silence_samples(35))
            continue
        if index % 2:
            continue

        offset = ((ord(char) * 37) + seed) % 260
        frequency = (base_frequency + offset) * pitch_factor
        duration = 35 + ((ord(char) + seed) % 4) * 8
        pcm.extend(tone_samples(frequency, duration))
        pcm.extend(silence_samples(12))
        emitted = True

    if not emitted:
        pcm.extend(silence_samples(120))

    return pcm_to_wav_bytes(bytes(pcm), BLIP_SAMPLE_RATE)


def tensor_to_wav_bytes(audio: Any, sample_rate: int) -> bytes:
    samples = audio.detach().cpu().numpy()
    samples = np.asarray(samples, dtype=np.float32).reshape(-1)
    samples = np.nan_to_num(samples)
    pcm = (np.clip(samples, -1.0, 1.0) * 32767).astype("<i2").tobytes()
    return pcm_to_wav_bytes(pcm, sample_rate)


def pcm_to_wav_bytes(pcm: bytes, sample_rate: int) -> bytes:
    buffer = io.BytesIO()
    with wave.open(buffer, "wb") as wav_file:
        wav_file.setnchannels(1)
        wav_file.setsampwidth(2)
        wav_file.setframerate(sample_rate)
        wav_file.writeframes(pcm)
    return buffer.getvalue()


def tone_samples(frequency: float, duration_ms: int) -> bytes:
    total_samples = max(1, int(BLIP_SAMPLE_RATE * duration_ms / 1000))
    t = np.arange(total_samples, dtype=np.float32) / BLIP_SAMPLE_RATE
    envelope = np.minimum(np.linspace(0, 1, total_samples), np.linspace(1, 0, total_samples))
    wave_data = (
        np.sin(2 * np.pi * frequency * t) * 0.42
        + np.sin(2 * np.pi * frequency * 2.01 * t) * 0.08
    )
    pcm = (wave_data * envelope * 32767).astype("<i2")
    return pcm.tobytes()


def silence_samples(duration_ms: int) -> bytes:
    total_samples = max(1, int(BLIP_SAMPLE_RATE * duration_ms / 1000))
    return b"\x00\x00" * total_samples


def wav_sample_rate(wav_bytes: bytes) -> int:
    try:
        with wave.open(io.BytesIO(wav_bytes), "rb") as wav_file:
            return wav_file.getframerate()
    except wave.Error:
        return BLIP_SAMPLE_RATE


DISALLOWED_FFMPEG_FILTERS = ("amovie", "azmq")


def format_filter_chain(filter_chain: str, wav_bytes: bytes) -> str:
    if not filter_chain:
        return ""
    lower_chain = filter_chain.lower()
    for disallowed in DISALLOWED_FFMPEG_FILTERS:
        if disallowed in lower_chain:
            abort(400)
    return filter_chain.replace("%SAMPLE_RATE%", str(wav_sample_rate(wav_bytes)))


def _run_ffmpeg(wav_bytes: bytes, filters: list[str], out_args: list[str]) -> bytes:
    command = ["ffmpeg", "-hide_banner", "-loglevel", "error", "-f", "wav", "-i", "pipe:0"]
    if filters:
        command.extend(["-filter_complex", ",".join(filters)])
    command.extend(out_args)
    try:
        result = subprocess.run(command, input=wav_bytes, capture_output=True, timeout=30)
    except subprocess.TimeoutExpired:
        app.logger.error("ffmpeg timed out after 30s")
        abort(500)
    if result.returncode != 0:
        app.logger.error("ffmpeg failed: %s", result.stderr.decode("utf-8", errors="replace"))
        abort(500)
    return result.stdout


def _run_silicon(wav_bytes: bytes, prefix_filters: list[str], out_args: list[str]) -> bytes:
    # afir convolution reverb against the two impulse responses (tgtts-qwen3).
    prefix = (",".join(prefix_filters) + ",") if prefix_filters else ""
    filter_complex = f"[0] {prefix}{SILICON_COMPLEX_TAIL}"
    command = [
        "ffmpeg", "-hide_banner", "-loglevel", "error",
        "-f", "wav", "-i", "pipe:0",
        "-i", str(SFX_DIR / SYNTH_IMPULSE_FILE),
        "-i", str(SFX_DIR / ROOM_IMPULSE_FILE),
        "-filter_complex", filter_complex,
    ]
    command.extend(out_args)
    try:
        result = subprocess.run(command, input=wav_bytes, capture_output=True, timeout=30)
    except subprocess.TimeoutExpired:
        app.logger.error("ffmpeg (silicon) timed out after 30s")
        abort(500)
    if result.returncode != 0:
        app.logger.error("ffmpeg (silicon) failed: %s", result.stderr.decode("utf-8", errors="replace"))
        abort(500)
    return result.stdout


def load_sfx(name: str) -> AudioSegment:
    cached = _sfx_cache.get(name)
    if cached is not None:
        return cached
    with _sfx_lock:
        cached = _sfx_cache.get(name)
        if cached is not None:
            return cached
        segment = AudioSegment.from_file(SFX_DIR / name)
        _sfx_cache[name] = segment
        return segment


def matched_sfx(name: str, frame_rate: int) -> AudioSegment:
    # tg's load_and_match: mono, resampled to the target rate so concatenation and
    # overlay line up with the synthesized voice instead of playing at the wrong speed.
    return load_sfx(name).set_channels(1).set_frame_rate(frame_rate)


def apply_radio_clicks(voice: AudioSegment) -> AudioSegment:
    # Mix in looped diffstatic, then bracket with a random mic-on / mic-off click,
    # matching tgtts-qwen3's radio_effect + radio prefix/suffix.
    frame_rate = voice.frame_rate
    static = matched_sfx(RADIO_STATIC_FILE, frame_rate)
    if len(static) < len(voice):
        static = static * (len(voice) // len(static) + 1)
    static = static[: len(voice)].apply_gain(RADIO_STATIC_GAIN_DB)
    voice = voice.overlay(static)

    start = matched_sfx(random.choice(RADIO_START_FILES), frame_rate)
    end = matched_sfx(random.choice(RADIO_END_FILES), frame_rate)
    return start + voice + end


def random_corruption_bursts() -> list[tuple[float, float]]:
    # Approximates tgtts-qwen3's word-aligned static corruption for high-interference
    # broadcasts, without real forced-alignment: a few random windows (as fractions of
    # total duration) get dropped out under static instead of specific corrupted words.
    count = random.randint(GIBBERISH_MIN_BURSTS, GIBBERISH_MAX_BURSTS)
    spans = []
    for _ in range(count):
        width = random.uniform(GIBBERISH_BURST_MIN_FRACTION, GIBBERISH_BURST_MAX_FRACTION)
        start = random.uniform(0.0, max(0.0, 1.0 - width))
        spans.append((start, start + width))
    return spans


def apply_corruption_bursts(voice: AudioSegment, spans: list[tuple[float, float]]) -> AudioSegment:
    if not spans:
        return voice
    frame_rate = voice.frame_rate
    duration_ms = len(voice)
    static = matched_sfx(RADIO_STATIC_FILE, frame_rate)
    if len(static) < duration_ms:
        static = static * (duration_ms // len(static) + 2)
    for start_frac, end_frac in sorted(spans):
        start_ms = int(start_frac * duration_ms)
        end_ms = min(duration_ms, int(end_frac * duration_ms))
        if end_ms <= start_ms:
            continue
        burst_static = static[start_ms:end_ms].apply_gain(GIBBERISH_STATIC_GAIN_DB)
        ducked = (voice[start_ms:end_ms] + GIBBERISH_DUCK_DB).overlay(burst_static)
        voice = voice[:start_ms] + ducked + voice[end_ms:]
    return voice


def wav_to_ogg(
    wav_bytes: bytes,
    filter_chain: str,
    special_filters: set[str],
    pitch: int,
    is_blips: bool,
    corruption_spans: list[tuple[float, float]] | None = None,
) -> tuple[bytes, float]:
    is_radio = "radio" in special_filters
    is_silicon = "silicon" in special_filters

    filters = []
    if ENABLE_PITCH and pitch and not is_blips:
        filters.append(f"rubberband=pitch={math.pow(2, pitch / 12):.6f}")
    if filter_chain:
        filters.append(format_filter_chain(filter_chain, wav_bytes))
    if is_radio:
        filters.extend(RADIO_VOICE_FILTERS)

    ogg_out = ["-vn", "-c:a", "libvorbis", "-b:a", OGG_BITRATE, "-f", "ogg", "pipe:1"]
    wav_out = ["-vn", "-f", "wav", "pipe:1"]

    if is_radio:
        # Everything into PCM first, splice the click SFX in the audio-segment
        # domain, then encode ogg ONCE (radio is fired twice per line, so the
        # extra encode/decode the old path did was a real serial cost).
        if is_silicon:
            voice_wav = _run_silicon(wav_bytes, filters, wav_out)
        elif filters:
            voice_wav = _run_ffmpeg(wav_bytes, filters, wav_out)
        else:
            voice_wav = wav_bytes
        voice = AudioSegment.from_file(io.BytesIO(voice_wav), format="wav")
        if corruption_spans:
            voice = apply_corruption_bursts(voice, corruption_spans)
        combined = apply_radio_clicks(voice)
        output = io.BytesIO()
        combined.export(output, format="ogg", codec="libvorbis", bitrate=OGG_BITRATE)
        return output.getvalue(), len(combined) / 1000.0

    # Non-radio: a single ffmpeg call straight to ogg.
    if is_silicon:
        ogg_bytes = _run_silicon(wav_bytes, filters, ogg_out)
    else:
        ogg_bytes = _run_ffmpeg(wav_bytes, filters, ogg_out)

    if is_silicon:
        # Silicon pads a reverb tail onto the end (apad=pad_dur=2 in
        # SILICON_COMPLEX_TAIL), so duration has to come from the actual output.
        duration = audio_duration_seconds(ogg_bytes)
    else:
        # Pitch-only rubberband and the per-voice EQ/dynamics filters all preserve
        # sample count, so the pre-filter WAV's duration is still accurate - skips
        # spawning a second ffmpeg process just to decode the ogg back out.
        duration = wav_duration_seconds(wav_bytes)
    return ogg_bytes, duration


def audio_duration_seconds(ogg_bytes: bytes) -> float:
    try:
        audio = AudioSegment.from_file(io.BytesIO(ogg_bytes), format="ogg")
        return audio.duration_seconds
    except Exception:
        return 0.0


def wav_duration_seconds(wav_bytes: bytes) -> float:
    try:
        with wave.open(io.BytesIO(wav_bytes), "rb") as wav_file:
            frame_count = wav_file.getnframes()
            frame_rate = wav_file.getframerate()
        return frame_count / frame_rate if frame_rate else 0.0
    except Exception:
        return 0.0


def audio_response(ogg_bytes: bytes, duration: float) -> Any:
    identifier = request.args.get("identifier", "tts")
    safe_identifier = "".join(char for char in identifier if char.isalnum() or char in "._-") or "tts"
    response = send_file(
        io.BytesIO(ogg_bytes),
        mimetype="audio/ogg",
        as_attachment=True,
        download_name=f"{safe_identifier}.ogg",
    )
    response.headers["audio-length"] = f"{duration:.3f}"
    return response


@app.route("/tts", methods=["GET", "POST"])
def text_to_speech() -> Any:
    require_authorization()
    total_start = time.perf_counter()

    voice_name = request.args.get("voice", "")
    voice = find_voice(voice_name)
    if voice is None:
        abort(404)

    text = request_text()
    filter_chain, special_filters = request_filters()
    pitch = request_pitch()

    synth_start = time.perf_counter()
    wav_bytes = synthesize_text_wav_cached(voice, text or " ")
    synth_elapsed = time.perf_counter() - synth_start
    encode_start = time.perf_counter()
    ogg_bytes, duration = wav_to_ogg(wav_bytes, filter_chain, special_filters, pitch, is_blips=False)
    encode_elapsed = time.perf_counter() - encode_start
    log_timing(
        f"tts generated voice={voice_name!r} chars={len(text)} "
        f"synth={synth_elapsed:.3f}s encode={encode_elapsed:.3f}s total={time.perf_counter() - total_start:.3f}s"
    )
    return audio_response(ogg_bytes, duration)


@app.route("/tts-blips", methods=["GET", "POST"])
def text_to_speech_blips() -> Any:
    require_authorization()
    total_start = time.perf_counter()

    voice_name = request.args.get("voice", "")
    voice = find_voice(voice_name)
    if voice is None:
        abort(404)

    text = request_text()
    filter_chain, special_filters = request_filters()
    pitch = request_pitch()

    synth_start = time.perf_counter()
    wav_bytes = synthesize_blip_wav(voice_name, text, pitch)
    synth_elapsed = time.perf_counter() - synth_start
    encode_start = time.perf_counter()
    ogg_bytes, duration = wav_to_ogg(wav_bytes, filter_chain, special_filters, pitch, is_blips=True)
    encode_elapsed = time.perf_counter() - encode_start
    log_timing(
        f"blips generated voice={voice_name!r} chars={len(text)} "
        f"synth={synth_elapsed:.3f}s encode={encode_elapsed:.3f}s total={time.perf_counter() - total_start:.3f}s"
    )
    return audio_response(ogg_bytes, duration)


@app.route("/tts-radio", methods=["GET", "POST"])
def text_to_speech_radio() -> Any:
    require_authorization()
    total_start = time.perf_counter()

    voice_name = request.args.get("voice", "")
    voice = find_voice(voice_name)
    if voice is None:
        abort(404)

    text = request_text_radio()
    is_gibberish = request_is_radio_gibberish()
    filter_chain, special_filters = request_filters()
    special_filters.add("radio")
    pitch = request_pitch()

    synth_start = time.perf_counter()
    wav_bytes = synthesize_text_wav_cached(voice, text or " ")
    synth_elapsed = time.perf_counter() - synth_start
    encode_start = time.perf_counter()
    corruption_spans = random_corruption_bursts() if is_gibberish else None
    ogg_bytes, duration = wav_to_ogg(
        wav_bytes, filter_chain, special_filters, pitch, is_blips=False, corruption_spans=corruption_spans
    )
    encode_elapsed = time.perf_counter() - encode_start
    log_timing(
        f"radio generated voice={voice_name!r} chars={len(text)} gibberish={is_gibberish} "
        f"synth={synth_elapsed:.3f}s encode={encode_elapsed:.3f}s total={time.perf_counter() - total_start:.3f}s"
    )
    return audio_response(ogg_bytes, duration)


@app.route("/tts-blips-radio", methods=["GET", "POST"])
def text_to_speech_blips_radio() -> Any:
    require_authorization()
    total_start = time.perf_counter()

    voice_name = request.args.get("voice", "")
    voice = find_voice(voice_name)
    if voice is None:
        abort(404)

    text = request_text()
    filter_chain, special_filters = request_filters()
    special_filters.add("radio")
    pitch = request_pitch()

    synth_start = time.perf_counter()
    wav_bytes = synthesize_blip_wav(voice_name, text, pitch)
    synth_elapsed = time.perf_counter() - synth_start
    encode_start = time.perf_counter()
    ogg_bytes, duration = wav_to_ogg(wav_bytes, filter_chain, special_filters, pitch, is_blips=True)
    encode_elapsed = time.perf_counter() - encode_start
    log_timing(
        f"blips-radio generated voice={voice_name!r} chars={len(text)} "
        f"synth={synth_elapsed:.3f}s encode={encode_elapsed:.3f}s total={time.perf_counter() - total_start:.3f}s"
    )
    return audio_response(ogg_bytes, duration)


@app.route("/tts-voices", methods=["GET"])
def tts_voices() -> Any:
    require_authorization()
    return json.dumps(voice_names())


@app.route("/pitch-available", methods=["GET"])
def pitch_available() -> Any:
    require_authorization()
    if not ENABLE_PITCH:
        abort(500)
    return make_response("Pitch available", 200)


@app.route("/toggle-logging", methods=["GET", "POST"])
def toggle_logging() -> Any:
    require_authorization()
    global LOG_TIMINGS
    LOG_TIMINGS = not LOG_TIMINGS
    return jsonify({"logging": LOG_TIMINGS})


@app.route("/voices/reload", methods=["POST"])
def reload_voices() -> Any:
    require_authorization()
    global _voice_catalog_cache
    with _voice_state_lock:
        _voice_states.clear()
    with _voice_catalog_lock:
        _voice_catalog_cache = None
    return jsonify({"voices": voice_names()})


@app.route("/voices/warmup", methods=["POST"])
def warmup_voices() -> Any:
    require_authorization()
    payload = request.get_json(silent=True) or {}
    requested_voices = payload.get("voices", payload.get("voice", []))
    if isinstance(requested_voices, str):
        requested_voices = [requested_voices]
    if not requested_voices:
        requested_voices = voice_names()

    thread = threading.Thread(target=warmup_voice_names, args=(list(requested_voices),), daemon=True)
    thread.start()
    return jsonify({"warming": requested_voices})


_health_check_count = 0


@app.route("/health-check", methods=["GET"])
def health_check() -> Any:
    # Docker hits this every 5s (Dockerfile HEALTHCHECK). A full gc.collect() walks
    # the whole object graph (torch model, voice/sfx caches included) and briefly
    # pauses every thread in the process - fine occasionally, but doing it that
    # often adds latency jitter to whatever synth happens to be in flight at the
    # same moment for no real benefit over Python's own incremental collection.
    global _health_check_count
    _health_check_count += 1
    if _health_check_count % 12 == 0:
        gc.collect()
    return "OK", 200


@app.route("/", methods=["GET"])
def root() -> Any:
    return jsonify(
        {
            "name": "NovaSector PocketTTS",
            "voices": len(voice_names()),
            "pitch": ENABLE_PITCH,
        }
    )


def warm_sfx() -> None:
    # Decode the radio/silicon SFX once so the first radio line doesn't pay for it.
    for name in [RADIO_STATIC_FILE, *RADIO_START_FILES, *RADIO_END_FILES]:
        try:
            load_sfx(name)
        except Exception as error:
            log(f"Failed to load SFX {name}: {error}")


def preload() -> None:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    SYNTH_CACHE_DIR.mkdir(parents=True, exist_ok=True)
    warm_sfx()
    if PRELOAD_MODEL:
        log("Preloading model because POCKETTTS_PRELOAD_MODEL is enabled.")
        get_model()
    if PRELOAD_VOICES:
        log("Preloading voice states because POCKETTTS_PRELOAD_VOICES is enabled.")
        for voice in voices():
            get_voice_state(voice)


def warmup_voice_names(names: list[str]) -> None:
    known_voices = {voice.name: voice for voice in voices()}
    for name in names:
        voice = known_voices.get(name)
        if voice is None:
            log(f"Skipping unknown warmup voice: {name}")
            continue
        try:
            get_voice_state(voice)
        except Exception as error:
            log(f"Warmup failed for {name}: {error}")


def configured_warmup_voices() -> list[str]:
    if WARMUP_VOICES.lower() == "all":
        return voice_names()
    if not WARMUP_VOICES:
        return []
    return [name.strip() for name in WARMUP_VOICES.split(",") if name.strip()]


def background_warmup() -> None:
    try:
        get_model()
        warmup_names = configured_warmup_voices()
        if warmup_names:
            log(f"Background voice warmup queued for {len(warmup_names)} voices.")
            warmup_voice_names(warmup_names)
        log("Background warmup complete.")
    except Exception as error:
        log(f"Background warmup failed: {error}")


def start_background_warmup() -> None:
    if not BACKGROUND_WARMUP:
        return
    log("Starting background model warmup.")
    thread = threading.Thread(target=background_warmup, daemon=True)
    thread.start()


if __name__ == "__main__":
    from waitress import serve

    preload()
    start_background_warmup()
    log(f"Serving on {HOST}:{PORT} with {len(voice_names())} voices.")
    serve(
        app,
        host=HOST,
        port=PORT,
        threads=WAITRESS_THREADS,
        backlog=8,
        connection_limit=24,
        channel_timeout=30,
    )
