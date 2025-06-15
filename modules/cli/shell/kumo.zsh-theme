# Define colors
local color_host="#ffbebc"
local color_time="#bc93ff"
local color_git="#fd8c73"
local color_exec="#a9ffb4"
local color_mem="#94ffa2"
local color_path="#61AFEF"
local color_status="#A9FFB4"
local color_error="#ef5350"

# Git prompt settings
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{green}✓%f"
zstyle ':vcs_info:*' unstagedstr "%F{yellow}Δ%f"
zstyle ':vcs_info:git:*' formats "%u%c %b"
zstyle ':vcs_info:git:*' actionformats "%u%c %b (%a)"

# Function to get execution time
function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    export RPROMPT="%F{$color_exec}${timer_show}s %f%F{white}%f"
    unset timer
  else
    export RPROMPT=""
  fi

  # Get memory info
  local mem_total=$(($(sysctl -n hw.memsize) / 1073741824))
  local mem_free=$(($(vm_stat | awk '/free/ {print $3}' | tr -d '.') * 4096 / 1073741824))
  local mem_used=$((mem_total - mem_free))
  local mem_percent=$((100 * mem_used / mem_total))

  # Right prompt
  RPROMPT+="%F{$color_mem} MEM: ${mem_percent}%% (${mem_used}/${mem_total}GB)%f"

  # Add root indicator if root
  if [ $(id -u) -eq 0 ]; then
    RPROMPT+=" "
  fi

  # Git info
  vcs_info
}

# Main prompt
PROMPT="%F{$color_host}%n@%m%f %F{white}on%f "
PROMPT+="%F{$color_time}$(date +"%A at %-I:%M %p")%f "
PROMPT+="%F{$color_git}${vcs_info_msg_0_}%f"$'\n'
PROMPT+="%F{$color_path}%~%f %F{$color_status}=>%f "

# Transient prompt
function zle-line-init zle-keymap-select {
  if [[ -n $RPROMPT ]]; then
    typeset -g _TRANSIENT_RPROMPT=$RPROMPT
    RPROMPT=
  fi
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

function accept-line-or-clear-warning() {
  if [[ -z $BUFFER ]]; then
    RPROMPT=$_TRANSIENT_RPROMPT
    unset _TRANSIENT_RPROMPT
  fi
  zle accept-line
}

zle -N accept-line-or-clear-warning
bindkey '^M' accept-line-or-clear-warning

# Console title
case $TERM in
  xterm*|rxvt*)
    precmd () {print -Pn "\e]0;%~\a"}
    ;;
esac
