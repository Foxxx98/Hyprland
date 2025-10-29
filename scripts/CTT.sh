#!/bin/bash

CONFIG=~/.config/hypr/hyprland.conf
HYPRPAPER_CONF=~/.config/hypr/hyprpaper.conf
WALLPAPER_DIRA=/ThousanD/XternD/Projects/hyprland/wall/Alien/
WALLPAPER_DIRO=/ThousanD/XternD/Projects/hyprland/wall/Obsidian/
WALLPAPER_DIRV=/ThousanD/XternD/Projects/hyprland/wall/Vanda/
WALL_SCRIPT=/ThousanD/XternD/Projects/hyprland/scripts/awall.sh

# --- Theme options ---
set_theme() {
  local active="$1"
  local inactive="$2"

  sed -i "s/^\s*col\.active_border\s*=.*/  col.active_border = $active/" "$CONFIG"
  sed -i "s/^\s*col\.inactive_border\s*=.*/  col.inactive_border = $inactive/" "$CONFIG"

  echo "✅ Borders updated!"
  hyprctl reload
}

# --- Wallpaper options ---
set_random_wallpaper() {
  local folder="$1"
  local file1 file2

  # Pick a random .jpg for each monitor
  file1=$(find "$folder" -type f -iname '*.jpg' | shuf -n 1)
  file2=$(find "$folder" -type f -iname '*.jpg' | shuf -n 1)

  # Apply wallpapers via Hyprpaper IPC
  hyprctl hyprpaper preload "$file1"
  hyprctl hyprpaper preload "$file2"
  hyprctl hyprpaper wallpaper "DP-1,$file1"
  hyprctl hyprpaper wallpaper "HDMI-A-1,$file2"
  echo " Wallpapers set:"
  echo "   DP-1 -> $file1"
  echo "   HDMI-A-1 -> $file2"

  # Update hyprpaper.conf for next session
  if [ -f "$HYPRPAPER_CONF" ]; then
    sed -i "s|^\s*preload\s*=.*|preload = $file1|" "$HYPRPAPER_CONF"
    sed -i "s|^\s*wallpaper\s*=.*|wallpaper = DP-1,$file1; HDMI-A-1,$file2|" "$HYPRPAPER_CONF"
    echo " Updated hyprpaper.conf for next session."
  fi
}

# --- Update linux-wallpaperengine ID in external script ---
update_wallpaperengine_id() {
  local ids=("$@") # Array of possible IDs
  local script_path="$WALL_SCRIPT"

  # Pick a random ID from the array
  local new_id=${ids[RANDOM % ${#ids[@]}]}

  # Replace only the numeric ID at the end of the command
  sed -i "s/\(linux-wallpaperengine --screen-root DP-1 --fps 15 --scaling stretch \)[0-9]\+/\1$new_id/" "$script_path"
  echo " ✅ Updated linux-wallpaperengine ID to $new_id in $script_path"
}

# --- Menu ---
echo "Select a border color theme:"
options=(
  " Obsidian theme"
  " Vanda theme"
  " Alien theme"
  "❌ Exit"
)

select opt in "${options[@]}"; do
  case $REPLY in
  1)
    set_theme "rgba(814DDEff) rgba(9C6FE6ff) rgba(5F3A95ff) rgba(372952ff) 45deg" "rgba(05010Cff) rgba(10021Cff) rgba(1B0B30ff) rgba(16023Cff) 45deg"
    sleep 0.5
    set_random_wallpaper "$WALLPAPER_DIRO"
    sleep 0.5
    update_wallpaperengine_id 3229021240 3229047529 973101892
    sleep 1
    wal -i /ThousanD/XternD/Projects/hyprland/cwt/Obsidian.jpg
    sleep 1
    pkill waybar
    sleep 1
    setsid waybar >/dev/null 2>&1 &
    break
    ;;
  2)
    set_theme "rgba(ffffffee) rgba(bfbfbfb0) rgba(bfbfbfb0) rgba(ffffffee) 45deg" "rgba(2a2a2ab0) rgba(3c3c3cb0) rgba(3c3c3cb0) rgba(2a2a2ab0) 45deg"
    psleep 0.5
    set_random_wallpaper "$WALLPAPER_DIRV"
    sleep 1
    wal -i /ThousanD/XternD/Projects/hyprland/cwt/Vanda.jpg
    sleep 1
    pkill waybar
    sleep 1
    setsid waybar >/dev/null 2>&1 &
    break
    ;;
  3)
    set_theme "rgba(AAD5F0ff) rgba(88B8D6ff) rgba(1E3A4Dff) rgba(294952ff) 45deg" "rgba(09101Cff) rgba(1C2B3Cff) rgba(3A526B80) rgba(3A526Bff) 45deg"
    sleep 0.5
    set_random_wallpaper "$WALLPAPER_DIRA"
    sleep 1
    wal -i /ThousanD/XternD/Projects/hyprland/cwt/Alien.jpg
    sleep 1
    pkill waybar
    sleep 1
    setsid waybar >/dev/null 2>&1 &
    break
    ;;
  5)
    echo "Exiting."
    exit 0
    ;;
  *)
    echo "Invalid option."
    ;;
  esac
done
