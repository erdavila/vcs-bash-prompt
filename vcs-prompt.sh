# TODO: update with most recent Git implementation

export GIT_PS1_SHOWDIRTYSTATE=yes      # Show unstaged ('*') and staged ('+')
export GIT_PS1_SHOWSTASHSTATE=yes      # Show stash with '$'
export GIT_PS1_SHOWUNTRACKEDFILES=yes  # Show untracked files with '%'

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
export GIT_PS1_SHOWUPSTREAM="${OPTIONS[@]}"

# See more information about the identity of commits checked out as a detached HEAD
#export GIT_PS1_DESCRIBE_STYLE=contains  # relative to newer annotated tag (v1.6.3.2~35)
#export GIT_PS1_DESCRIBE_STYLE=branch    # relative to newer tag or branch (master~4)
#export GIT_PS1_DESCRIBE_STYLE=describe  # relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
#export GIT_PS1_DESCRIBE_STYLE=default   # exactly matching tag
export GIT_PS1_SHOWCOLORHINTS=yes  # colored hint about the current dirty state (only with PROMPT_COMMAND!)

unset OPTIONS


# The length to truncate long commit descriptions
export JJ_PS1_DESCRIPTION_LEN=25


function __vcs_ps1() {
  # preserve exit status
	local exit="$?"
  __jj_ps1 "$@" || __git_ps1 "$@"
  return "$exit"
}


# Sources the git-prompt.sh file from the Git project
source [PUT PATH FOR the git-prompt.sh file from the Git project HERE]

# Sources the jj-prompt.sh file
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/jj-prompt.sh"


# Uncomment and define ONE of the lines below:
#export PS1=[PUT THE PS1 DEFINITION HERE]
#export PROMPT_COMMAND=[PUT THE PROMPT_COMMAND DEFINITION HERE]
