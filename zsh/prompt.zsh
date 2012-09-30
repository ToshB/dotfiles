autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    m=""
    if [[ $st == "nothing to commit (working directory clean)" ]]
    then
      m="[%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      m="[%{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
    if [[ $(unpushed) != "" ]]
    then
      m+=" %{$fg_bold[magenta]%}unpushed%{$reset_color%}"
    fi
    m+="]"
    echo $m
  fi
}

git_prompt_info () {
 ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  /usr/bin/git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  
}

directory_name(){
  echo "[%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}]"
}

export PROMPT=$'$(directory_name)$(git_dirty)› '

precmd() {
  title "zsh" "%m" "%55<...<%~"
}
