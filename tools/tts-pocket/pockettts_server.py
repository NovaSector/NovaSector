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
import wave
from pathlib import Path
from typing import Any

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

AUTHORIZATION_TOKEN = os.getenv("TTS_AUTHORIZATION_TOKEN", os.getenv("POCKETTTS_AUTHORIZATION_TOKEN", "coolio"))
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
RESPONSE_CACHE_ENABLED = os.getenv("POCKETTTS_RESPONSE_CACHE", "1").strip().lower() in {"1", "true", "yes", "on"}
LOG_TIMINGS = os.getenv("POCKETTTS_LOG_TIMINGS", "1").strip().lower() in {"1", "true", "yes", "on"}

BLIP_SAMPLE_RATE = 24_000
RADIO_CLICK_STYLE_VERSION = 2
SILICON_FILTER = (
    "aresample=44100,"
    "acrusher=samples=2:level_out=3,"
    "aecho=0.8:0.88:45|85:0.25|0.14,"
    "aemphasis=type=cd,"
    "equalizer=f=7710:t=q:w=0.6:g=-6,"
    "equalizer=f=33:t=q:w=0.44:g=-10,"
    "alimiter=level_in=1:level_out=1:limit=0.5:attack=5:release=20"
)

app = Flask(__name__)
_model: TTSModel | None = None
_model_lock = threading.Lock()
_inference_lock = threading.Lock()
_voice_states: dict[tuple[str, str], dict[str, Any]] = {}
_voice_state_lock = threading.Lock()
_response_cache_lock = threading.Lock()


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


def voices() -> list[VoiceDefinition]:
    return load_catalog(VOICE_CONFIG_PATH)


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


def response_cache_dir() -> Path:
    return CACHE_DIR / "responses"


def voice_fingerprint(voice: VoiceDefinition | None, voice_name: str = "") -> str:
    if voice is None:
        return voice_name

    source = resolve_source(voice.source, VOICE_CONFIG_PATH)
    source_path = Path(source)
    if source_path.exists():
        stat = source_path.stat()
        return f"{voice.name}:{source}:{stat.st_mtime_ns}:{stat.st_size}"
    return f"{voice.name}:{source}"


def response_cache_key(
    kind: str,
    voice: VoiceDefinition | None,
    voice_name: str,
    text: str,
    filter_chain: str,
    special_filters: set[str],
    pitch: int,
) -> str:
    payload = {
        "kind": kind,
        "voice": voice_fingerprint(voice, voice_name),
        "text": text,
        "filter": filter_chain,
        "special_filters": sorted(special_filters),
        "pitch": pitch if ENABLE_PITCH else 0,
        "ogg_bitrate": OGG_BITRATE,
        "radio_click_style": RADIO_CLICK_STYLE_VERSION if "radio" in special_filters else None,
    }
    encoded = json.dumps(payload, sort_keys=True, separators=(",", ":")).encode("utf-8")
    return hashlib.sha256(encoded).hexdigest()


def read_response_cache(cache_key: str) -> tuple[bytes, float] | None:
    if not RESPONSE_CACHE_ENABLED:
        return None

    ogg_path = response_cache_dir() / f"{cache_key}.ogg"
    metadata_path = response_cache_dir() / f"{cache_key}.json"
    if not ogg_path.exists() or not metadata_path.exists():
        return None

    try:
        metadata = json.loads(metadata_path.read_text(encoding="utf-8"))
        return ogg_path.read_bytes(), float(metadata.get("duration", 0))
    except (OSError, ValueError, json.JSONDecodeError):
        return None


def write_response_cache(cache_key: str, ogg_bytes: bytes, duration: float) -> None:
    if not RESPONSE_CACHE_ENABLED:
        return

    cache_dir = response_cache_dir()
    cache_dir.mkdir(parents=True, exist_ok=True)
    ogg_path = cache_dir / f"{cache_key}.ogg"
    metadata_path = cache_dir / f"{cache_key}.json"
    tmp_suffix = f"{os.getpid()}.{threading.get_ident()}"
    tmp_ogg_path = cache_dir / f"{cache_key}.{tmp_suffix}.ogg.tmp"
    tmp_metadata_path = cache_dir / f"{cache_key}.{tmp_suffix}.json.tmp"

    with _response_cache_lock:
        tmp_ogg_path.write_bytes(ogg_bytes)
        tmp_metadata_path.write_text(json.dumps({"duration": duration}), encoding="utf-8")
        tmp_ogg_path.replace(ogg_path)
        tmp_metadata_path.replace(metadata_path)


def synthesize_text_wav(voice: VoiceDefinition, text: str) -> bytes:
    model = get_model()
    voice_state = get_voice_state(voice)
    with _inference_lock:
        audio = model.generate_audio(voice_state, text)
    return tensor_to_wav_bytes(audio, model.sample_rate)


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


def format_filter_chain(filter_chain: str, wav_bytes: bytes) -> str:
    if not filter_chain:
        return ""
    return filter_chain.replace("%SAMPLE_RATE%", str(wav_sample_rate(wav_bytes)))


def wav_to_ogg(
    wav_bytes: bytes,
    filter_chain: str,
    special_filters: set[str],
    pitch: int,
    is_blips: bool,
) -> tuple[bytes, float]:
    filters = []
    if ENABLE_PITCH and pitch and not is_blips:
        filters.append(f"rubberband=pitch={math.pow(2, pitch / 12):.6f}")
    if filter_chain:
        filters.append(format_filter_chain(filter_chain, wav_bytes))
    if "silicon" in special_filters:
        filters.append(SILICON_FILTER)

    command = [
        "ffmpeg",
        "-hide_banner",
        "-loglevel",
        "error",
        "-f",
        "wav",
        "-i",
        "pipe:0",
    ]
    if filters:
        command.extend(["-filter_complex", ",".join(filters)])
    command.extend(["-vn", "-c:a", "libvorbis", "-b:a", OGG_BITRATE, "-f", "ogg", "pipe:1"])

    result = subprocess.run(command, input=wav_bytes, capture_output=True)
    if result.returncode != 0:
        app.logger.error("ffmpeg failed: %s", result.stderr.decode("utf-8", errors="replace"))
        abort(500)

    ogg_bytes = result.stdout
    if "radio" in special_filters:
        ogg_bytes = add_radio_clicks(ogg_bytes)

    if not filter_chain and not special_filters:
        duration = wav_duration_seconds(wav_bytes)
    else:
        duration = audio_duration_seconds(ogg_bytes)
    return ogg_bytes, duration


def add_radio_clicks(ogg_bytes: bytes) -> bytes:
    audio = AudioSegment.from_file(io.BytesIO(ogg_bytes), format="ogg")
    combined = radio_click(start=True) + audio + radio_click(start=False)
    output = io.BytesIO()
    combined.export(output, format="ogg", codec="libvorbis", bitrate=OGG_BITRATE)
    return output.getvalue()


def radio_click(start: bool) -> AudioSegment:
    duration = 85 if start else 120
    total_samples = max(1, int(BLIP_SAMPLE_RATE * duration / 1000))
    rng = np.random.default_rng(random.getrandbits(32))

    noise = rng.normal(0.0, 1.0, total_samples).astype(np.float32)
    short_average = np.convolve(noise, np.ones(5, dtype=np.float32) / 5, mode="same")
    long_average = np.convolve(noise, np.ones(28, dtype=np.float32) / 28, mode="same")
    static = short_average - (long_average * 0.45)

    progress = np.linspace(0, 1, total_samples, dtype=np.float32)
    attack = np.minimum(progress * (18 if start else 10), 1.0)
    release = np.power(np.maximum(1 - progress, 0.0), 0.55 if start else 0.75)
    envelope = attack * release

    timeline = np.arange(total_samples, dtype=np.float32) / BLIP_SAMPLE_RATE
    pop_frequency = 120 if start else 85
    pop_decay = np.exp(-timeline * (55 if start else 38))
    pop = np.sin(2 * np.pi * pop_frequency * timeline) * pop_decay

    samples = (static * envelope * 0.34) + (pop * 0.18)
    samples = np.tanh(samples * 1.7) / 1.7
    pcm = (np.clip(samples, -1.0, 1.0) * 32767).astype("<i2").tobytes()

    return AudioSegment(
        data=pcm,
        sample_width=2,
        frame_rate=BLIP_SAMPLE_RATE,
        channels=1,
    ).apply_gain(-7)


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
    cache_key = response_cache_key("tts", voice, voice_name, text, filter_chain, special_filters, pitch)
    cached_response = read_response_cache(cache_key)
    if cached_response is not None:
        log_timing(f"tts cache voice={voice_name!r} chars={len(text)} total={time.perf_counter() - total_start:.3f}s")
        return audio_response(*cached_response)

    synth_start = time.perf_counter()
    wav_bytes = synthesize_text_wav(voice, text or " ")
    synth_elapsed = time.perf_counter() - synth_start
    encode_start = time.perf_counter()
    ogg_bytes, duration = wav_to_ogg(wav_bytes, filter_chain, special_filters, pitch, is_blips=False)
    encode_elapsed = time.perf_counter() - encode_start
    write_response_cache(cache_key, ogg_bytes, duration)
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
    cache_key = response_cache_key("blips", voice, voice_name, text, filter_chain, special_filters, pitch)
    cached_response = read_response_cache(cache_key)
    if cached_response is not None:
        log_timing(f"blips cache voice={voice_name!r} chars={len(text)} total={time.perf_counter() - total_start:.3f}s")
        return audio_response(*cached_response)

    synth_start = time.perf_counter()
    wav_bytes = synthesize_blip_wav(voice_name, text, pitch)
    synth_elapsed = time.perf_counter() - synth_start
    encode_start = time.perf_counter()
    ogg_bytes, duration = wav_to_ogg(wav_bytes, filter_chain, special_filters, pitch, is_blips=True)
    encode_elapsed = time.perf_counter() - encode_start
    write_response_cache(cache_key, ogg_bytes, duration)
    log_timing(
        f"blips generated voice={voice_name!r} chars={len(text)} "
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


@app.route("/voices/reload", methods=["POST"])
def reload_voices() -> Any:
    require_authorization()
    with _voice_state_lock:
        _voice_states.clear()
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


@app.route("/health-check", methods=["GET"])
def health_check() -> Any:
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


def preload() -> None:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    if RESPONSE_CACHE_ENABLED:
        response_cache_dir().mkdir(parents=True, exist_ok=True)
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
