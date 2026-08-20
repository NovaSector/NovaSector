from __future__ import annotations

import json
import re
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Any


DEFAULT_VOICES = [
    {"name": "Woman Alba", "source": "alba", "gender": "female"},
    {"name": "Woman Anna", "source": "anna", "gender": "female"},
    {"name": "Woman Azelma", "source": "azelma", "gender": "female"},
    {"name": "Woman Cosette", "source": "cosette", "gender": "female"},
    {"name": "Woman Eve", "source": "eve", "gender": "female"},
    {"name": "Woman Mary", "source": "mary", "gender": "female"},
    {"name": "Woman Vera", "source": "vera", "gender": "female"},
    {"name": "Man Bill", "source": "bill_boerst", "gender": "male"},
    {"name": "Man Charles", "source": "charles", "gender": "male"},
    {"name": "Man George", "source": "george", "gender": "male"},
    {"name": "Man Javert", "source": "javert", "gender": "male"},
    {"name": "Man Marius", "source": "marius", "gender": "male"},
    {"name": "Man Michael", "source": "michael", "gender": "male"},
    {"name": "Man Paul", "source": "paul", "gender": "male"},
    {"name": "Man Stuart", "source": "stuart_bell", "gender": "male"},
]


@dataclass(frozen=True)
class VoiceDefinition:
    name: str
    source: str
    gender: str = ""


def slugify(value: str) -> str:
    slug = re.sub(r"[^a-zA-Z0-9]+", "-", value.strip().lower()).strip("-")
    return slug or "voice"


def display_name_for(name: str, gender: str = "", prefix_gender: bool = True) -> str:
    clean_name = " ".join(name.split())
    if not prefix_gender or not gender:
        return clean_name
    if re.search(r"\b(man|woman)\b", clean_name, flags=re.IGNORECASE):
        return clean_name
    if gender.lower() == "female":
        return f"Woman {clean_name}"
    if gender.lower() == "male":
        return f"Man {clean_name}"
    return clean_name


def load_catalog(path: Path) -> list[VoiceDefinition]:
    if not path.exists():
        return _normalize(DEFAULT_VOICES)

    with path.open("r", encoding="utf-8") as file:
        payload = json.load(file)

    raw_voices: Any
    if isinstance(payload, dict):
        raw_voices = payload.get("voices", [])
    else:
        raw_voices = payload

    return _normalize(raw_voices)


def save_catalog(path: Path, voices: list[VoiceDefinition]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    payload = {
        "voices": [asdict(voice) for voice in voices],
    }
    with path.open("w", encoding="utf-8") as file:
        json.dump(payload, file, indent="\t")
        file.write("\n")


def resolve_source(source: str, catalog_path: Path) -> str:
    if _is_remote_or_builtin(source):
        return source

    source_path = Path(source)
    if not source_path.is_absolute():
        source_path = catalog_path.parent / source_path
    resolved = source_path.resolve()
    base = catalog_path.parent.resolve()
    if not resolved.is_relative_to(base):
        raise ValueError(f"Voice source escapes the catalog directory: {source}")
    return str(resolved)


def relative_to_catalog(path: Path, catalog_path: Path) -> str:
    try:
        return path.resolve().relative_to(catalog_path.parent.resolve()).as_posix()
    except ValueError:
        return str(path.resolve())


def _normalize(raw_voices: Any) -> list[VoiceDefinition]:
    voices: list[VoiceDefinition] = []
    seen_names: set[str] = set()

    if isinstance(raw_voices, dict):
        raw_voices = [
            {"name": name, "source": source}
            for name, source in raw_voices.items()
        ]

    for item in raw_voices:
        if isinstance(item, str):
            item = {"name": item, "source": item}
        if not isinstance(item, dict):
            continue

        name = str(item.get("name", "")).strip()
        source = str(item.get("source", "")).strip()
        gender = str(item.get("gender", "")).strip().lower()
        if gender not in ("", "male", "female"):
            print(f"[voice-catalog] Unknown gender {gender!r} on voice {name!r} - treating as unset.")
            gender = ""
        if not name or not source or name in seen_names:
            continue

        seen_names.add(name)
        voices.append(VoiceDefinition(name=name, source=source, gender=gender))

    return voices


def _is_remote_or_builtin(source: str) -> bool:
    lower_source = source.lower()
    if lower_source.startswith(("hf://", "http://", "https://")):
        return True
    candidate = Path(source)
    if not candidate.is_absolute():
        candidate = _catalog_dir / candidate  # pass catalog_path in, same as resolve_source
    return not candidate.exists()
