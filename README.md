# vcs-bash-prompt

A custom Bash prompt for Jujutsu (jj) that integrates with the Git prompt.

TODO: include a sample of the JJ prompt.

## Configuration

1. Download and save [vcs-prompt.sh](./vcs-prompt.sh).
    * On Linux or Cygwin: save it in `~/.config/bash/`. Create that directory if it doesn't exist.
    * On Git Bash for Windows: save it as `~/.config/git/git-prompt.sh`. Note the difference:
        * `~/.config/git/git-prompt.sh` - Correct
        * `~/.config/bash/vcs-prompt.sh` - WRONG!
2. Download and save [jj-prompt.sh](./jj-prompt.sh) to the same location.
3. Edit the `vcs-prompt.sh` file (or `git-prompt.sh` in Git Bash for Windows):
    1. Towards the end of the file, include the path for the `git-prompt.sh` file from the Git project. [See options below](#the-git-promptsh-file-from-the-git-project).

        Example on Linux:
        ```bash
        # Sources the git-prompt.sh file from the Git project
        source ???TODO???
        ```

        Example on Cygwin:
        ```bash
        # Sources the git-prompt.sh file from the Git project
        source ???TODO???
        ```

        Example on Git Bash for Windows:
        ```bash
        # Sources the git-prompt.sh file from the Git project
        source /mingw64/share/git/completion/git-prompt.sh
        ```
    2. At the very end of the file, define a value for `PS1` or `PROMPT_COMMAND` (not both!). [See instructions below](#defining-values-for-ps1-or-prompt_command-variables).
    3. Optional: customize the prompt output by setting the variables `GIT_PS1_*` and `JJ_PS1_*`.

4. Only on Linux and Cygwin: add the line below to `~/.bashrc`.
    ```bash
    source ~/.config/bash/vcs-prompt.sh
    ```


## Configuring only the Jujutsu prompt

TODO

## The `git-prompt.sh` file from the Git project

TODO

## Defining values for `PS1` or `PROMPT_COMMAND` variables

TODO
