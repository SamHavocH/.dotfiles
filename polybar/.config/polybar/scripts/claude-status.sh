#!/usr/bin/env bash
# Polybar widget for Claude Code sessions that finished or need input.
# State files are written by ~/.claude/hooks/status.sh. Each names a target:
# tmux:<pane> for sessions inside tmux, x:<window> otherwise. A flag is cleared
# when its target is visible: the pane is current in a focused tmux client, or
# the X window is focused.
#   claude-status.sh          run the widget (polybar, tail = true)
#   claude-status.sh visible  print the targets you are looking at right now
#   claude-status.sh clear    drop flags of visible targets (tmux/i3 focus hooks)
#   claude-status.sh focus    jump to the most urgent flagged session
dir="${XDG_RUNTIME_DIR:-/tmp}/claude-status"
mkdir -p "$dir"

input_bg="#cb5760"
done_bg="#999f63"
fg="#15121c"

visible() {
  tmux list-clients -F '#{client_flags} #{pane_id}' 2>/dev/null | awk '/focused/ {print "tmux:" $NF}'
  local active
  active=$(xprop -root _NET_ACTIVE_WINDOW 2>/dev/null | awk '{print $NF}')
  [ -n "$active" ] && echo "x:$((active))"
}

clear_visible() {
  local t
  for t in $(visible); do
    grep -lx "target=$t" "$dir"/* 2>/dev/null | xargs -r rm -f
  done
}

focus() {
  local f target wid pane client_name client_pid
  f=$(grep -l '^state=input' "$dir"/* 2>/dev/null | head -1)
  [ -n "$f" ] || f=$(ls -t "$dir"/* 2>/dev/null | head -1)
  [ -n "$f" ] || return
  target=$(sed -n 's/^target=//p' "$f")
  case $target in
    tmux:*)
      pane=${target#tmux:}
      read -r _ client_name client_pid < <(tmux list-clients -F '#{client_activity} #{client_name} #{client_pid}' | sort -rn | head -1)
      [ -n "$client_name" ] || return
      tmux switch-client -c "$client_name" -t "$pane" \; select-window -t "$pane" \; select-pane -t "$pane"
      wid=$(tr '\0' '\n' < "/proc/$client_pid/environ" | sed -n 's/^WINDOWID=//p') ;;
    x:*) wid=${target#x:} ;;
  esac
  [ -n "$wid" ] && i3-msg -q "[id=$wid] focus"
}

pill() { # color icon count
  local label=" $2"
  [ "$3" -gt 1 ] && label+=" $3"
  printf '%%{F%s}%%{T2}%%{T-}%%{B%s}%%{F%s}%s %%{B-}%%{F%s}%%{T2}%%{T-}%%{F-} ' "$1" "$1" "$fg" "$label" "$1"
}

render() {
  local input=0 done=0 f out=""
  for f in "$dir"/*; do
    [ -f "$f" ] || continue
    case $(sed -n 's/^state=//p' "$f") in
      input) input=$((input + 1)) ;;
      done) done=$((done + 1)) ;;
    esac
  done
  [ "$input" -gt 0 ] && out+=$(pill "$input_bg" "" "$input")
  [ "$done" -gt 0 ] && out+=$(pill "$done_bg" "" "$done")
  echo "$out"
}

case $1 in
  visible) visible; exit ;;
  clear) clear_visible; exit ;;
  focus) focus; exit ;;
esac

trap 'kill 0' EXIT

i3-msg -t subscribe -m '["window"]' |
  jq --unbuffered -r 'select(.change == "focus") | .container.window' |
  while read -r _; do clear_visible; done &

render
inotifywait -m -q -e close_write,moved_to,delete "$dir" | while read -r _; do render; done
