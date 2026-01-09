source /mingw64/share/git/completion/git-prompt.sh

#!export GIT_PS1_SHOWDIRTYSTATE=yes      # Show unstaged ('*') and staged ('+')
#!export GIT_PS1_SHOWSTASHSTATE=yes      # Show stash with '$'
#!export GIT_PS1_SHOWUNTRACKEDFILES=yes  # Show untracked files with '%'

# See the difference between HEAD and its upstream
# '<'  indicates you are behind
# '>'  indicates you are ahead
# '<>' indicates you have diverged
# '='  indicates that there is no difference
OPTIONS=()
OPTIONS+=(auto)      # Not needed if using any of the options below
#OPTIONS+=(verbose)   # show number of commits ahead/behind (+/-) upstream
#OPTIONS+=(git)       # always compare HEAD to @{upstream}
#OPTIONS+=(svn)       # always compare HEAD to your SVN upstream
#!export GIT_PS1_SHOWUPSTREAM="${OPTIONS[@]}"

# See more information about the identity of commits checked out as a detached HEAD
#export GIT_PS1_DESCRIBE_STYLE=contains  # relative to newer annotated tag (v1.6.3.2~35)
#export GIT_PS1_DESCRIBE_STYLE=branch    # relative to newer tag or branch (master~4)
#export GIT_PS1_DESCRIBE_STYLE=describe  # relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
#export GIT_PS1_DESCRIBE_STYLE=default   # exactly matching tag
#!export GIT_PS1_SHOWCOLORHINTS=yes  # colored hint about the current dirty state (only with PROMPT_COMMAND!)

unset OPTIONS

function __vcs_ps1() {
  # preserve exit status
	local exit="$?"
  __jj_ps1 "$@" || __git_ps1 "$@"
  return "$exit"
}

function __jj_ps1() {
  # Based in:
  #   https://zerowidth.com/2025/async-zsh-jujutsu-prompt-with-p10k/
  #   https://gist.github.com/hroi/d0dc0e95221af858ee129fd66251897e
  #   https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh

  # preserve exit status
	local exit="$?"
  local pcmode=no
	local ps1pc_start='\u@\h:\w '
	local ps1pc_end='\$ '
	local printf_format=' (%s)'

  case "$#" in
    2|3)  pcmode=yes
      ps1pc_start="$1"
      ps1pc_end="$2"
			printf_format="${3:-$printf_format}"
			# set PS1 to a plain prompt so that we can
			# simply return early if the prompt should not
			# be decorated
			PS1="$ps1pc_start$ps1pc_end"
    ;;
		0|1)	printf_format="${1:-$printf_format}"
		;;
		*)	return "$exit"
		;;
  esac

  # Check that jj is installed
  command -v jj >/dev/null 2>&1 || return

  local workspace # Must be in a separate line to keep the returned status code
  workspace=$(jj workspace root 2>/dev/null) || return

  function jj_log() {
    jj --config "revset-aliases.'closest_bookmark(to)'='heads(::to & bookmarks())'" log --repository "$workspace" --ignore-working-copy "$@"
  }

  function jj_log_no_graph() {
    jj_log --no-graph "$@"
  }

  local revision=$(jj_log_no_graph --limit 1 --color always \
    --config "template-aliases.'truncated_description(commit)'='label(\"description placeholder\", if(commit.description() == \"\", \"(no desc)\", \"\\\"\" ++ truncate_end(25, commit.description().first_line(), \"…\") ++ \"\\\"\"))'" \
    --config "template-aliases.'format_short_id(id)'='id.shortest(4)'" \
    -r @ \
    -T 'separate(
      " ",
      format_short_change_id_with_hidden_and_divergent_info(self),
      format_short_commit_id(commit_id),
      if(empty, label("empty", "(empty)"), ""),
      if(parents.len() > 1, label("merge", "merged")),
      truncated_description(self) ++
      if(description == "", "[@-:" ++ parents.map(|p| truncated_description(p)).join("|") ++ "]", ""),
      if(conflict, label("conflict", "(conflict)"), "")
    )')

  local bookmark=$(jj_log_no_graph --limit 1 --color always \
    -r "closest_bookmark(@)" \
    -T 'bookmarks.join(" ")' 2>/dev/null)

  if [[ -n "$bookmark" ]]; then
    local distance=$(jj_log --color never \
      -r "closest_bookmark(@)..@" \
      --count)
  fi

  # local file_status=$(jj_log --color never \
  #   -r @ \
  #   -T 'self.diff().files().map(|f| f.status()).join("\n")' 2>/dev/null | \
  #   sort | uniq -c | awk '
  #     /modified/ { parts[++i] = "\033[0;36m±" $1 "\033[0m" }
  #     /added/ { parts[++i] = "\033[0;32m+" $1 "\033[0m" }
  #     /removed/ { parts[++i] = "\033[0;31m-" $1 "\033[0m" }
  #     /copied/ { parts[++i] = "\033[0;33m⧉" $1 "\033[0m" }
  #     /renamed/ { parts[++i] = "\033[0;35m↻" $1 "\033[0m" }
  #     END { for (j=1; j<=i; j++) printf "%s%s", parts[j], (j<i ? " " : "") }
  #   ')

  # WARNING: this command may make jj create a snapshot
  # local untracked_count=$(jj status --repository "$workspace" --color never | grep '^\? ' | wc -l)

  unset -f jj_log jj_log_no_graph

  local jjstring=$revision

  if [[ -n "$bookmark" ]]; then
    jjstring+=" $bookmark"
    if [[ "$distance" -gt 0 ]]; then
      jjstring+=$'\033[38;5;127m'"⇡${distance}"$'\033[0m'
    fi
  fi
  # if [[ -n "$file_status" ]]; then
  #   jjstring+=" ${file_status}"
  # fi
  # if [[ $untracked_count -gt 0 ]]; then
  #   jjstring+=" \033[0;34m?${untracked_count}\033[0m"
  # fi

  if [ "$pcmode" = yes ]; then
    jjstring=$(echo "$jjstring" | sed 's/\x1b\[[0-9;]*m/\\\[&\\\]/g')
  fi

  if [ "$pcmode" = yes ]; then
    jjstring=$(printf -- "$printf_format" "$jjstring")
    PS1="${ps1pc_start}${jjstring}${ps1pc_end}"
  else
    printf -- "$printf_format" "$jjstring"
  fi

  return "$exit"
}

export PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__vcs_ps1`\[\033[0m\]\n$ '
# export PROMPT_COMMAND='__vcs_ps1 "\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]" "\[\033[0m\]\n$ "'
