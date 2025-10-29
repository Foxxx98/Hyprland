#!/usr/bin/env bash
# Automatically update Spotify (Spicetify) theme using Pywal colors

WAL_COLORS="$HOME/.cache/wal/colors.json"
SPICETIFY_THEME="$HOME/.config/spicetify/Themes/pywal/color.ini"

# Generate the Spicetify color.ini from Pywal colors
python3 - <<'EOF'
import json, os
colors = json.load(open(os.path.expanduser("~/.cache/wal/colors.json")))

theme = f"""[pywal]
text = {colors['special']['foreground']}
subtext = {colors['colors']['color7']}
main = {colors['special']['background']}
sidebar = {colors['colors']['color0']}
player = {colors['colors']['color1']}
card = {colors['colors']['color2']}
button = {colors['colors']['color3']}
highlight = {colors['colors']['color4']}
notification = {colors['colors']['color5']}
notification_error = {colors['colors']['color1']}
"""

os.makedirs(os.path.expanduser("~/.config/spicetify/Themes/pywal"), exist_ok=True)
open(os.path.expanduser("~/.config/spicetify/Themes/pywal/color.ini"), "w").write(theme)
EOF

# Apply the theme with Spicetify
spicetify config current_theme pywal
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
spicetify apply
