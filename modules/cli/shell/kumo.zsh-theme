preexec() {
  EFL_CMD_START=$(date +%s%N)
}

precmd() {
  if [[ -n $EFL_CMD_START ]]; then
    local now=$(date +%s%N)
    EFL_EXEC_TIME_MS=$(( (now - EFL_CMD_START) / 1000000 ))
  else
    EFL_EXEC_TIME_MS=0
  fi
}

memory_info() {
  local mem_total mem_available mem_used pct total_gb used_gb
  if [[ -r /proc/meminfo ]]; then
    mem_total=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
    mem_available=$(awk '/MemAvailable:/ {print $2}' /proc/meminfo)
    mem_used=$((mem_total - mem_available))
    pct=$(( mem_used * 100 / mem_total ))
    total_gb=$(awk "BEGIN{printf \"%.0f\",${mem_total}/1024/1024}")
    used_gb=$(awk "BEGIN{printf \"%.0f\",${mem_used}/1024/1024}")
    echo "MEM:${pct}% (${used_gb}/${total_gb}GB)"
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" *"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{$fg[yellow]%}EFL %{$fg[white]%}on %{$fg[magenta]%}$(date "+%A at %I:%M %p") %{$fg[red]%}$(git_prompt_info)%{$reset_color%}
%{$fg[cyan]%} %~%{$reset_color%} %(?.%{$fg[green]%}=> .%{$fg[red]%}=> )%{$reset_color%} '

RPROMPT='%{$fg[white]%}${EFL_EXEC_TIME_MS}ms %{$fg[yellow]%}⚡%{$reset_color%}%(#.%{$fg[red]%}#.%{$reset_color%}) $(memory_info)'
