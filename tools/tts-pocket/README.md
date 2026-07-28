# PocketTTS backend

This is a single-container TTS backend for NovaSector's existing TTS subsystem. It implements the game-facing endpoints already used by `code/controllers/subsystem/tts.dm`:

- `GET /tts` / `GET /tts-radio`
- `GET /tts-blips` / `GET /tts-blips-radio`
- `GET /tts-voices`
- `GET /pitch-available`
- `GET|POST /toggle-logging` — flip per-request timing logs at runtime
- `GET /health-check`

PocketTTS runs on CPU, so this avoids the old GPU/RVC path while keeping the BYOND config unchanged.

## Quick start

```
cd tools\tts-pocket
docker compose up --build
```

Docker is the easiest route because the server also needs `ffmpeg` for OGG output and in-game audio filters.
The server starts without blocking on the model, so `/tts-voices` should answer quickly. By default it warms the model and configured voices in the background; the first spoken line may still wait if it arrives before warmup finishes.

Then enable TTS in `config/config.txt`:

```txt
TTS_HTTP_URL http://localhost:5002
TTS_HTTP_TOKEN coolio
TTS_MAX_CONCURRENT_REQUESTS 1
TTS_HTTP_TIMEOUT_SECONDS 30
```

Use a real random token for production and keep the service behind localhost or a trusted reverse proxy.

## Clone a voice from one clip

The fast path is to export a clip to a `.safetensors` voice state once, then the server can load it quickly for every round.

```
cd tools\tts-pocket
python -m venv .venv
.\.venv\Scripts\pip install torch torchaudio --index-url https://download.pytorch.org/whl/cpu
.\.venv\Scripts\pip install -r requirements.txt
.\.venv\Scripts\python manage_voices.py add "Bartender" C:\clips\bartender.wav --gender male
```

That writes a safetensors file under `voices/` and appends a `Man Bartender` entry to `voices.json`. Restart the container for changes to take effect.

Use clean clips with permission from the speaker. PocketTTS reproduces the recording quality and voice characteristics of the sample.

## Voice catalog

`voices.json` controls what appears in game. A voice source can be:

- a built-in PocketTTS voice, such as `alba` or `marius`;
- a relative path under this folder, such as `voices/bartender.safetensors`;
- an absolute local path;
- an `hf://`, `http://`, or `https://` audio URL.

Keep `Man` or `Woman` in display names when you want the game's random gender matching to pick them appropriately.

## Variables

- `TTS_AUTHORIZATION_TOKEN`: must match `TTS_HTTP_TOKEN`.
- `POCKETTTS_LANGUAGE`: PocketTTS model language, default `english`.
- `POCKETTTS_QUANTIZE`: set `1` to load the model with int8 quantization; Docker defaults to `1` for lower CPU latency.
- `POCKETTTS_ENABLE_PITCH`: set `1` to expose `/pitch-available` and apply semitone pitch shifting with ffmpeg.
- `POCKETTTS_PRELOAD_MODEL`: set `1` to load the model at boot instead of on first speech.
- `POCKETTTS_PRELOAD_VOICES`: set `1` to load every voice state at boot.
- `POCKETTTS_BACKGROUND_WARMUP`: set `0` to disable background model warmup.
- `POCKETTTS_WARMUP_VOICES`: comma-separated voice names to warm in the background, or `all`; Docker defaults to `all`.
- `POCKETTTS_LOG_TIMINGS`: set `0` to disable per-request timing logs.
- `POCKETTTS_WORKERS`: independent Gunicorn worker processes. Use this for multiple CPUs/cores.
- `POCKETTTS_THREADS`: HTTP threads per worker. Keep this at `1` for synthesis-heavy use.
- `POCKETTTS_TORCH_THREADS`: CPU compute threads per worker. Useful when running several workers.
- `POCKETTTS_WORKER_TIMEOUT`: seconds before Gunicorn kills a slow worker.

## Multiple CPUs

For lower latency under load, run multiple worker processes and let each worker own its own PocketTTS model. Good starting points:

```powershell
# 4 physical cores
$env:POCKETTTS_WORKERS = "2"
$env:POCKETTTS_TORCH_THREADS = "2"
docker compose up --build
```

```powershell
# 8+ physical cores
$env:POCKETTTS_WORKERS = "4"
$env:POCKETTTS_TORCH_THREADS = "2"
docker compose up --build
```

Then set the game to allow about the same number of concurrent TTS messages:

```txt
TTS_MAX_CONCURRENT_REQUESTS 2
```

or:

```txt
TTS_MAX_CONCURRENT_REQUESTS 4
```

Do not set both `POCKETTTS_WORKERS` and `POCKETTTS_TORCH_THREADS` too high. Four workers each using eight Torch threads can be slower than two workers using two threads, because the CPU spends too much time fighting itself.

## Latency notes

Watch the container logs after a player speaks. Lines like this show where time is going:

```txt
[tts-pocket] tts generated voice='Man Marius' chars=42 synth=1.820s encode=0.110s total=1.941s
```

If `synth` is high, tune `POCKETTTS_WORKERS`, `POCKETTTS_TORCH_THREADS`, and `POCKETTTS_QUANTIZE`. If backend `total` is low but the game still speaks late, the remaining delay is likely BYOND-side HTTP queueing or waiting for earlier queued speech from the same speaker.
