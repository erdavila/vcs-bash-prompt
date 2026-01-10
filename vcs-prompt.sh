##########################
### Git prompt options ###
##########################

# Show unstaged ('*') and staged ('+').
# Can be overridden per repository with bash.showDirtyState = false.
export GIT_PS1_SHOWDIRTYSTATE=yes

# Show stash with '$'.
export GIT_PS1_SHOWSTASHSTATE=yes

# Show untracked files with '%'.
# Can be overridden per repository with bash.showUntrackedFiles = false.
export GIT_PS1_SHOWUNTRACKEDFILES=yes

# See the difference between HEAD and its upstream.
# Can be overridden per repository with bash.showUpstream.
# '<'  indicates you are behind
# '>'  indicates you are ahead
# '<>' indicates you have diverged
# '='  indicates that there is no difference
OPTIONS=()
OPTIONS+=(auto)      # Not needed if using any of the options below
#OPTIONS+=(verbose)   # show number of commits ahead/behind (+/-) upstream
#OPTIONS+=(name)      # if verbose, then also show the upstream abbrev name
#OPTIONS+=(legacy)    # don't use the '--count' option available in recent versions of git-rev-list
#OPTIONS+=(git)       # always compare HEAD to @{upstream}
#OPTIONS+=(svn)       # always compare HEAD to your SVN upstream
export GIT_PS1_SHOWUPSTREAM="${OPTIONS[@]}"
unset OPTIONS

# The separator between the branch name and the state symbols. Default is a single space.
#export GIT_PS1_STATESEPARATOR=' '

# Sparse checkout indicator.
#export GIT_PS1_COMPRESSSPARSESTATE=yes  # show a single '?' instead of "|SPARSE"
#export GIT_PS1_OMITSPARSESTATE=yes      # do not show any indicator

# Unresolved conflicts indicator as "|CONFLICT".
export GIT_PS1_SHOWCONFLICTSTATE=yes

# See more information about the identity of commits checked out as a detached HEAD
#export GIT_PS1_DESCRIBE_STYLE=contains  # relative to newer annotated tag (v1.6.3.2~35)
#export GIT_PS1_DESCRIBE_STYLE=branch    # relative to newer tag or branch (master~4)
#export GIT_PS1_DESCRIBE_STYLE=describe  # relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
#export GIT_PS1_DESCRIBE_STYLE=tag       # relative to any older tag (v1.6.3.1-13-gdd42c2f)
#export GIT_PS1_DESCRIBE_STYLE=default   # exactly matching tag

# Colored hint about the current dirty state.
export GIT_PS1_SHOWCOLORHINTS=yes

# Do not show prompt when the current directory is set up to be ignored by git.
# Can be overridden per repository with bash.hideIfPwdIgnored = false.
#export GIT_PS1_HIDE_IF_PWD_IGNORED=yes


##############################
### Jujutsu prompt options ###
##############################

export JJ_PS1_DESCRIPTION_LEN=25  # The length to truncate long commit descriptions


################################################################################
################################################################################
################################################################################

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
