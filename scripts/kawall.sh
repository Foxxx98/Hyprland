#!/bin/bash
# /ThousanD/XternD/Projects/hyprland/wa_stop.sh

HYPRPAPER_CONF=~/.config/hypr/hyprpaper.conf
PID_FILE=/tmp/linux_wallpaperengine.pid

if [ -f "$PID_FILE" ]; then
  WEPID=$(cat "$PID_FILE")
  echo "🛑 Stopping linux-wallpaperengine (PID: $WEPID)..."
  kill "$WEPID" 2>/dev/null
  rm -f "$PID_FILE"
  sleep 1
else
  echo "⚠️ No PID file found — trying to kill manually..."
  pkill -f "linux-wallpaperengine --screen-root DP-1"
fi

echo "🔄 Restarting Hyprpaper for DP-1..."
if [ -f "$HYPRPAPER_CONF" ]; then
  hyprctl hyprpaper reload
  echo "✅ Hyprpaper restarted for DP-1."
else
  echo "⚠️ Hyprpaper config not found at $HYPRPAPER_CONF"
fi
