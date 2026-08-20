FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1
ENV HF_HOME=/app/cache/huggingface
ENV XDG_CACHE_HOME=/app/cache

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install torch torchaudio --index-url https://download.pytorch.org/whl/cpu \
    && pip install -r requirements.txt

COPY . .
RUN mkdir -p /app/cache /app/voices

EXPOSE 5002
HEALTHCHECK --interval=5s --timeout=3s --retries=6 --start-period=60s \
    CMD curl -sf http://localhost:5002/health-check || exit 1

CMD ["gunicorn", "--config", "gunicorn_conf.py", "pockettts_server:app"]
