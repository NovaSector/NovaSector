import os
import re

greyscale_typepaths = {}

def get_icon_path(typepath):
    if "/clothing/" in typepath:
        return "'icons/map_icons/clothing.dmi'"
    elif "/mob/" in typepath:
        return "'icons/map_icons/mobs.dmi'"
    elif "/turf/" in typepath:
        return "'icons/map_icons/turfs.dmi'"
    elif "/datum/" in typepath:
        return "'icons/map_icons/objects.dmi'"
    elif "/obj/" in typepath:
        return "'icons/map_icons/items.dmi'"
    else:
        return "'icons/map_icons/unassigned.dmi'"

def is_typepath_line(line):
    stripped = line.strip()
    return re.match(r'^/(obj|mob|turf|datum|area)(/\w+)*$', stripped) is not None

def detect_line_ending(text):
    if "\r\n" in text:
        return "\r\n"
    elif "\r" in text:
        return "\r"
    else:
        return "\n"

def extract_comments(line):
    if '//' in line:
        _, comment = line.split('//', 1)
        return '//' + comment.rstrip()
    return ""

def get_parent_typepath(typepath):
    if '/' not in typepath.strip('/'):
        return None
    return '/' + '/'.join(typepath.strip('/').split('/')[:-1])

def parse_block_metadata(block_lines):
    icon = None
    icon_state = None
    post_init_icon_state = None

    for line in block_lines:
        if re.match(r'^\s*icon\s*=', line):
            match = re.search(r'=\s*(.+?)(\s*//.*)?$', line)
            if match:
                icon = match.group(1).strip()
        if re.match(r'^\s*icon_state\s*=', line):
            match = re.search(r'=\s*"?([^"]+)"?', line)
            if match:
                icon_state = match.group(1).strip()
        if re.match(r'^\s*post_init_icon_state\s*=', line):
            match = re.search(r'=\s*"?([^"]+)"?', line)
            if match:
                post_init_icon_state = match.group(1).strip()

    return icon, icon_state, post_init_icon_state

def process_block(typepath, block_lines, parent_values=None, force=False):
    existing_icon, existing_icon_state, existing_post = parse_block_metadata(block_lines)

    icon_comment = ""
    icon_state_comment = ""

    new_block = []
    for line in block_lines:
        if re.match(r'^\s*icon\s*=', line):
            icon_comment = extract_comments(line)
            continue
        if re.match(r'^\s*icon_state\s*=', line):
            icon_state_comment = extract_comments(line)
            continue
        if re.match(r'^\s*post_init_icon_state\s*=', line):
            continue
        new_block.append(line)

    insert_index = 0
    for i, line in enumerate(new_block):
        if "greyscale_config =" in line and "greyscale_config_" not in line:
            insert_index = i
            break

    if force or parent_values:
        new_icon = parent_values["icon"] if parent_values else get_icon_path(typepath)
        new_icon_state = parent_values["icon_state"] if parent_values else typepath
        new_post = parent_values["post_init_icon_state"] if parent_values else existing_icon_state or "PLACEHOLDER_GAGS_STATE"

        if force or not parent_values or (
            existing_icon != parent_values.get("icon") or
            existing_icon_state != parent_values.get("icon_state") or
            existing_post != parent_values.get("post_init_icon_state")
        ):
            if new_post:
                new_block.insert(insert_index, f'\tpost_init_icon_state = "{new_post}"')
            comment = f" {icon_state_comment}" if icon_state_comment else ""
            new_block.insert(insert_index, f'\ticon_state = "{new_icon_state}"{comment}')
            comment = f" {icon_comment}" if icon_comment else ""
            new_block.insert(insert_index, f'\ticon = {new_icon}{comment}')
            return [typepath] + new_block

    return None

def first_pass(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        text = f.read()
    lines = text.splitlines()
    typepath = None
    block_lines = []

    output = []
    newline = detect_line_ending(text)
    changed = False

    def flush_block():
        nonlocal changed
        if typepath:
            if any("greyscale_config =" in l and "greyscale_config_" not in l for l in block_lines):
                result = process_block(typepath, block_lines, None, force=True)
                if result:
                    greyscale_typepaths[typepath] = {
                        "icon": get_icon_path(typepath),
                        "icon_state": typepath,
                        "post_init_icon_state": parse_block_metadata(block_lines)[1] or "PLACEHOLDER_GAGS_STATE"
                    }
                    output.extend(result)
                    changed = True
                else:
                    output.extend([typepath] + block_lines)
            else:
                output.extend([typepath] + block_lines)

    for line in lines:
        stripped = line.strip()
        if is_typepath_line(stripped):
            flush_block()
            typepath = stripped
            block_lines = []
        elif typepath:
            if line.strip().startswith("proc") or not line.startswith((" ", "\t")):
                flush_block()
                typepath = None
                output.append(line)
            else:
                block_lines.append(line)
        else:
            output.append(line)
    flush_block()

    if changed:
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(newline.join(output) + newline)
        print(f"Updated (pass 1): {filepath}")

def second_pass(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        text = f.read()
    lines = text.splitlines()
    newline = detect_line_ending(text)

    output = []
    typepath = None
    block_lines = []
    changed = False

    def flush_block():
        nonlocal changed
        if typepath:
            parent = get_parent_typepath(typepath)
            while parent:
                if parent in greyscale_typepaths:
                    result = process_block(typepath, block_lines, greyscale_typepaths[parent], force=False)
                    if result:
                        output.extend(result)
                        changed = True
                    else:
                        output.extend([typepath] + block_lines)
                    break
                parent = get_parent_typepath(parent)
            else:
                output.extend([typepath] + block_lines)

    for line in lines:
        stripped = line.strip()
        if is_typepath_line(stripped):
            flush_block()
            typepath = stripped
            block_lines = []
        elif typepath:
            if line.strip().startswith("proc") or not line.startswith((" ", "\t")):
                flush_block()
                typepath = None
                output.append(line)
            else:
                block_lines.append(line)
        else:
            output.append(line)
    flush_block()

    if changed:
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(newline.join(output) + newline)
        print(f"Updated (pass 2): {filepath}")

def main():
    for root, _, files in os.walk("."):
        for file in files:
            if file.endswith(".dm"):
                first_pass(os.path.join(root, file))
    for root, _, files in os.walk("."):
        for file in files:
            if file.endswith(".dm"):
                second_pass(os.path.join(root, file))

if __name__ == "__main__":
    main()
