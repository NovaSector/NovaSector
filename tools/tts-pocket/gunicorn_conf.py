from __future__ import annotations

import os


bind = f"0.0.0.0:{os.getenv('POCKETTTS_PORT', '5002')}"
workers = int(os.getenv("POCKETTTS_WORKERS", "1"))
threads = int(os.getenv("POCKETTTS_THREADS", "1"))
timeout = int(os.getenv("POCKETTTS_WORKER_TIMEOUT", "180"))
worker_class = "gthread"
accesslog = "-"
errorlog = "-"


def post_worker_init(worker) -> None:
    import pockettts_server

    pockettts_server.log(
        f"Worker {worker.pid} ready with {threads} HTTP thread(s)."
    )
    pockettts_server.preload()
    pockettts_server.start_background_warmup()
