from __future__ import annotations

import argparse
from pathlib import Path

from voice_catalog import (
    VoiceDefinition,
    display_name_for,
    load_catalog,
    relative_to_catalog,
    save_catalog,
    slugify,
)


BASE_DIR = Path(__file__).resolve().parent
DEFAULT_CONFIG = BASE_DIR / "voices.json"
DEFAULT_VOICES_DIR = BASE_DIR / "voices"


def list_voices(args: argparse.Namespace) -> None:
    for voice in load_catalog(args.config):
        gender = f" ({voice.gender})" if voice.gender else ""
        print(f"{voice.name}{gender}: {voice.source}")


def add_voice(args: argparse.Namespace) -> None:
    from pocket_tts import TTSModel, export_model_state

    source_audio = args.audio.resolve()
    if not source_audio.exists():
        raise SystemExit(f"Audio file does not exist: {source_audio}")

    voices_dir = args.voices_dir.resolve()
    voices_dir.mkdir(parents=True, exist_ok=True)

    display_name = display_name_for(args.name, args.gender, prefix_gender=not args.no_gender_prefix)
    export_path = (voices_dir / f"{args.slug or slugify(display_name)}.safetensors").resolve()

    kwargs = {
        "quantize": args.quantize,
    }
    if args.config_model:
        kwargs["config"] = str(args.config_model.resolve())
    else:
        kwargs["language"] = args.language

    model = TTSModel.load_model(**kwargs)
    state = model.get_state_for_audio_prompt(str(source_audio), truncate=True)
    export_model_state(state, export_path)

    voices = [voice for voice in load_catalog(args.config) if voice.name != display_name]
    voices.append(
        VoiceDefinition(
            name=display_name,
            source=relative_to_catalog(export_path, args.config),
            gender=args.gender,
        )
    )
    save_catalog(args.config, voices)
    print(f"Added {display_name}: {export_path}")


def remove_voice(args: argparse.Namespace) -> None:
    voices = load_catalog(args.config)
    kept = [voice for voice in voices if voice.name != args.name]
    if len(kept) == len(voices):
        raise SystemExit(f"Voice is not in the catalog: {args.name}")
    save_catalog(args.config, kept)
    print(f"Removed {args.name}")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Manage PocketTTS voices for the NovaSector TTS backend.")
    parser.add_argument("--config", type=Path, default=DEFAULT_CONFIG, help="Path to voices.json.")
    subparsers = parser.add_subparsers(dest="command", required=True)

    list_parser = subparsers.add_parser("list", help="List configured voices.")
    list_parser.set_defaults(func=list_voices)

    add_parser = subparsers.add_parser("add", help="Clone one voice clip into a fast safetensors voice.")
    add_parser.add_argument("name", help="Display name shown in game.")
    add_parser.add_argument("audio", type=Path, help="WAV/MP3/etc. clip to clone. Use only clips you have consent to use.")
    add_parser.add_argument("--gender", choices=["female", "male", "neutral"], default="", help="Optional gender hint for random voice selection.")
    add_parser.add_argument("--no-gender-prefix", action="store_true", help="Do not prefix the display name with Man/Woman.")
    add_parser.add_argument("--slug", help="File stem for the exported safetensors voice.")
    add_parser.add_argument("--voices-dir", type=Path, default=DEFAULT_VOICES_DIR, help="Directory for exported voices.")
    add_parser.add_argument("--language", default="english", help="PocketTTS language model to use.")
    add_parser.add_argument("--config-model", type=Path, help="PocketTTS model config YAML.")
    add_parser.add_argument("--quantize", action="store_true", help="Load PocketTTS with int8 quantization.")
    add_parser.set_defaults(func=add_voice)

    remove_parser = subparsers.add_parser("remove", help="Remove a voice from the catalog.")
    remove_parser.add_argument("name", help="Display name to remove.")
    remove_parser.set_defaults(func=remove_voice)

    return parser


def main() -> None:
    parser = build_parser()
    args = parser.parse_args()
    args.config = args.config.resolve()
    args.func(args)


if __name__ == "__main__":
    main()
