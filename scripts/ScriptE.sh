WALL_SCRIPT=/ThousanD/XternD/Projects/hyprland/scripts/awall.sh

# --- Update linux-wallpaperengine ID in external script ---
update_wallpaperengine_id() {
  local ids=("$@")  # Array of possible IDs
  local script_path="$WALL_SCRIPT"
  
  # Pick a random ID from the array
  local new_id=${ids[RANDOM % ${#ids[@]}]}

  # Replace only the numeric ID at the end of the command
  sed -i "s/\(linux-wallpaperengine --screen-root DP-1 --fps 15 --scaling stretch \)[0-9]\+/\1$new_id/" "$script_path"
  echo " ✅ Updated linux-wallpaperengine ID to $new_id in $script_path"
}
echo "Select a border color theme:"
options=(
  " Obsidian theme"
  " Vanda theme"
  " Alien theme"
  "❌ Exit"
)

select opt in "${options[@]}"; do
  case $REPLY in  
  1) # Obsidian
    set_theme "rgba(814DDEff) rgba(9C6FE6ff) rgba(5F3A95ff) rgba(372952ff) 45deg" "rgba(05010Cff) rgba(10021Cff) rgba(1B0B30ff) rgba(16023Cff) 45deg"
    set_random_wallpaper "$WALLPAPER_DIRO"
    update_wallpaperengine_id 3229021240 4529627256 1293847560   # 3 possible IDs for Obsidian
    ;;
  2) # Vanda
    set_theme "rgba(ffffffee) rgba(bfbfbfb0) rgba(bfbfbfb0) rgba(ffffffee) 45deg" "rgba(2a2a2ab0) rgba(3c3c3cb0) rgba(3c3c3cb0) rgba(2a2a2ab0) 45deg"
    set_random_wallpaper "$WALLPAPER_DIRV"
    update_wallpaperengine_id 9876543210 1234567890 4567891230   # 3 possible IDs for Vanda
    ;;
  3) # Alien
    set_theme "rgba(AAD5F0ff) rgba(88B8D6ff) rgba(1E3A4Dff) rgba(294952ff) 45d:eg" "rgba(09101Cff) rgba(1C2B3Cff) rgba(3A526B80) rgba(3A526Bff) 45deg"
    set_random_wallpaper "$WALLPAPER_DIRA"
    update_wallpaperengine_id 8529637410 7410258369 3692581470   # 3 possible IDs for Alien
    ;;

*)    
break
