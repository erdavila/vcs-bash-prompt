# Git Bash

This is how the Git prompt is defined:

1. `/etc/profile`
    - Executes the files in `/etc/profile.d/`.
2. `/etc/profile.d/git-prompt.sh`:
    - If `~/.config/git/git-prompt.sh` exists, it is sourced.
    - Otherwise:
        1. `/mingw64/share/git/completion/git-prompt.sh` is sourced.
            - It contains the implementation of `__git_ps1`
        2. `PS1` is set as ``\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ ``.
