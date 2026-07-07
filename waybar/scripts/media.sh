#!/usr/bin/env bash

player_status=$(playerctl status 2>/dev/null)

if [ "$player_status" = "Playing" ] || [ "$player_status" = "Paused" ]; then
  artist=$(playerctl metadata artist 2>/dev/null | head -c 20)
  title=$(playerctl metadata title 2>/dev/null | head -c 25)
  player=$(playerctl metadata --format '{{playerName}}' 2>/dev/null)

  # player icon map
  case "$player" in
    spotify)   icon="󰓇" ;;
    firefox)   icon="󰈹" ;;
    chromium)  icon="󰊯" ;;
    mpv)       icon="󰐊" ;;
    vlc)       icon="󰕼" ;;
    *)         icon="󰎇" ;;
  esac

  if [ -n "$artist" ] && [ -n "$title" ]; then
    text="$icon  $artist — $title"
  elif [ -n "$title" ]; then
    text="$icon  $title"
  else
    text="$icon  Unknown"
  fi

  if [ "$player_status" = "Paused" ]; then
    tooltip="Paused: $text"
    class="paused"
  else
    tooltip="Playing: $text"
    class="playing"
  fi

  echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
else
  echo ""
fi
