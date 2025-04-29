import os
import re

modified_typepaths = {}

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
    return re.match(r'^/(obj|mob|turf|datum|area|clothing)(/\w+)*$', stripped) is not None

def detect_line_ending(text):
    if "\r\n" in text:
        return "\r\n"
    elif "\r" in text:
        return "\r"
    else:
        return "\n"

def process_block(typepath, block_lines):
    greyscale_line_index = None
    icon_state_line_index = None
    icon_line_index = None
    old_icon_state_val = "Placeholder icon_state GAG"

    modified = block_lines.copy()

    for i, line in enumerate(block_lines):
        if re.search(r'\bgreyscale_config\s*=\s*null\b', line):
            return None  # skip this block entirely

        if re.search(r'\bgreyscale_config\s*=', line) and not re.search(r'\bgreyscale_config_\w+\s*=', line):
            greyscale_line_index = i

        if re.match(r'^\s*icon_state\s*=', line):
            icon_state_line_index = i
            match = re.search(r'=\s*["\']?([^"\']+)["\']?', line)
            if match:
                old_icon_state_val = match.group(1)

        if re.match(r'^\s*icon\s*=', line):
            icon_line_index = i

    if greyscale_line_index is None:
        return None  # skip modification if no greyscale_config line is found

    icon_line = f"\ticon = {get_icon_path(typepath)}"
    icon_state_line = f'\ticon_state = "{typepath}"'
    post_icon_line = f'\tpost_init_icon_state = "{old_icon_state_val}"'

    lines_to_remove = sorted(
        [i for i in [icon_line_index, icon_state_line_index] if i is not None],
        reverse=True
    )
    for i in lines_to_remove:
        del modified[i]

    insert_index = greyscale_line_index - sum(1 for i in lines_to_remove if i < greyscale_line_index)
    modified.insert(insert_index, post_icon_line)
    modified.insert(insert_index, icon_state_line)
    modified.insert(insert_index, icon_line)

    return [typepath] + modified

def process_file(filepath):
    with open(filepath, 'rb') as f:
        raw = f.read()
    text = raw.decode('utf-8')
    newline = detect_line_ending(text)
    lines = text.splitlines()

    output = []
    block = []
    typepath = None
    inside_proc = False
    changed = False

    for i, line in enumerate(lines):
        stripped = line.strip()

        # Detect entering or leaving a proc block
        if re.match(r'^/.*?/(proc|verb|Initialize|update_icon_state)\b', stripped):
            inside_proc = True
        if inside_proc and stripped == "":
            inside_proc = False

        if is_typepath_line(stripped) and not inside_proc:
            if typepath:
                result = process_block(typepath, block)
                if result:
                    output.extend(result)
                    changed = True
                else:
                    output.extend([typepath] + block)
                block = []
            typepath = stripped
        elif typepath and not inside_proc:
            block.append(line)
        else:
            if typepath:
                result = process_block(typepath, block)
                if result:
                    output.extend(result)
                    changed = True
                else:
                    output.extend([typepath] + block)
                block = []
                typepath = None
            output.append(line)

    if typepath:
        result = process_block(typepath, block)
        if result:
            output.extend(result)
            changed = True
        else:
            output.extend([typepath] + block)

    if changed:
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(newline.join(output) + newline)
        print("Edited:", filepath)

def main():
    for root, dirs, files in os.walk("."):
        for name in files:
            if name.endswith(".dm"):
                process_file(os.path.join(root, name))

if __name__ == "__main__":
    main()
