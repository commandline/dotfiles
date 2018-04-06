EDITOR=nvim
export EDITOR

GPG_TTY=$(tty)
export GPG_TTY

_direnv_hook() {
  eval "$(direnv export bash)";
};
if ! [[ "$PROMPT_COMMAND" =~ _direnv_hook ]]; then
  PROMPT_COMMAND="_direnv_hook;$PROMPT_COMMAND";
fi

export NVM_DIR="/home/cmdln/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

source ~/.cargo/env

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/cmdln/libexec/google-cloud-sdk/path.bash.inc' ]; then source '/home/cmdln/libexec/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/cmdln/libexec/google-cloud-sdk/completion.bash.inc' ]; then source '/home/cmdln/libexec/google-cloud-sdk/completion.bash.inc'; fi

# clone the fzf repo into .fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,target}/*" 2> /dev/null'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# clone the bash-git-prompt repo into .bash-git-prompt
GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh

# Sync the environment of an existing shell
#
#  tmux already updates the environment according to
#  the update-environment settings in the config. However
#  for existing shells you need to sync from from tmux's view
#  of the world.
function tmux_sync_env
{
    external_env=`tmux showenv | grep -v "^-"`
    export ${external_env}
}
alias se="tmux_sync_env"
