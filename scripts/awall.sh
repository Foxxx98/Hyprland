HYPRPAPER_CONF=~/.config/hypr/hyprpaper.conf
PID_FILE=/tmp/linux_wallpaperengine.pid

# Kill Hyprpaper only for DP-1
echo "Stopping Hyprpaper for DP-1..."
pkill -f "hyprpaper.*DP-1" >/dev/null 2>&1
sleep 1

# Start linux-wallpaperengine
echo "Starting linux-wallpaperengine..."
linux-wallpaperengine --screen-root DP-1 --fps 15 --scaling stretch 3229021240 &
echo $! >"$PID_FILE"

echo "✅ linux-wallpaperengine started (PID: $(cat $PID_FILE))"
