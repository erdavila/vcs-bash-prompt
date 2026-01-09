# Git Bash for Windows
- `/etc/profile.d/git-prompt.sh`:
  - If `~/.config/git/git-prompt.sh` exists, sources it.
  - Otherwise, sources `/mingw64/share/git/completion/git-prompt.sh` and defines the prompt in `PS1`.
    - `/mingw64/share/git/completion/git-prompt.sh` contains the implementation of `__git_ps1`
    - `PS1` is `\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ `
