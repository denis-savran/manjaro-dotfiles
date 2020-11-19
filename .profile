# If running bash.
if [[ -n "$BASH_VERSION" ]]; then
    # Include .bashrc if it exists.
    if [[ -f "$HOME/.bashrc" ]]; then
	. "$HOME/.bashrc"
    fi
fi

if [[ -d "$HOME/bin" ]] ; then
    PATH="$HOME/bin:$PATH"
fi

if [[ -d "$HOME/.local/bin" ]] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export EDITOR=nvim

# Output ANSI "color" escape sequences in "raw" form.
LESS='--RAW-CONTROL-CHARS'
# Show the current position within the file on the prompt.
LESS+=' --LONG-PROMPT'
# Exit if an output fits the screen.
LESS+=' --quit-if-one-screen'
# Do not clear the screen after exiting.
# LESS+=' --no-init'
export LESS

export PAGER=less
# Run commands G (go to the end of the file) and g (go back to the beginning of the file)
# to properly calculate the position.
# export MANPAGER='less +Gg'

# https://wiki.archlinux.org/index.php/XDG_Base_Directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# Set configuration directories.
export IPYTHONDIR=$XDG_CONFIG_HOME/jupyter
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter

# Fixes 'missing or unsuitable terminal' error.
export TERM=xterm-256color

# FZF
# https://github.com/junegunn/fzf
export FZF_DEFAULT_OPTS="--layout=reverse --height 20%"

# VirtualenvWrapper
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/virtualenvwrapper
# https://virtualenvwrapper.readthedocs.io/en/latest/install.html#shell-startup-file
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/PycharmProjects

# SSH-Agent
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent
# https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login#18915067
# Conflicts with GNOME keyring.
# https://askubuntu.com/questions/3045/how-to-disable-gnome-keyring
SSH_ENV="$HOME/.ssh/environment"

function start_agent() {
    ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
}

if [[ -f "${SSH_ENV}" ]]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep "${SSH_AGENT_PID}" | grep 'ssh-agent$' > /dev/null || start_agent
else
    start_agent
fi
