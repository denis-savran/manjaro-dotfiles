# https://github.com/ohmyzsh/ohmyzsh/blob/master/templates/zshrc.zsh-template
export ZSH="$HOME/.local/share/zsh/oh-my-zsh"

### OMZ installer.
# https://github.com/ohmyzsh/ohmyzsh
if [[ ! -d "${ZSH}" ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing Oh My Zsh…%f"
    command mkdir -p "${ZSH}"
    command git clone https://github.com/ohmyzsh/ohmyzsh "${ZSH}" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

### Zinit installer.
# https://github.com/zdharma/zinit
# http://zdharma.org/zinit/wiki/INTRODUCTION/
if [[ ! -d "$HOME/.zinit" ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing Zinit…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

# Load Zinit.
. "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

DISABLE_UPDATE_PROMPT="true"

# History
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
HIST_STAMPS="yyyy-mm-dd"
# man zshparam
HISTFILE="$HOME/.zsh_history"
HISTSIZE=125000
SAVEHIST=100000
# man zshoptions
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# Powerline
# https://github.com/Powerlevel9k/powerlevel9k/wiki/Stylizing-Your-Prompt
# Show all colors in a terminal:
# for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND="015"  # white
POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND="220"  # gold
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="015"  # white
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="240"  # gray

POWERLEVEL9K_VCS_CLEAN_FOREGROUND="015"  # white
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="022"  # green
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="015"  # white
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="166"  # orange
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="015"  # white
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="124"  # red

POWERLEVEL9K_DIR_HOME_FOREGROUND="015"  # white
POWERLEVEL9K_DIR_HOME_BACKGROUND="240"  # gray
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="015"  # white
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="240"  # gray
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="015"  # white
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="240"  # gray
POWERLEVEL9K_DIR_ETC_FOREGROUND="015"  # white
POWERLEVEL9K_DIR_ETC_BACKGROUND="240"  # gray

POWERLEVEL9K_VIRTUALENV_FOREGROUND="015"  # white
POWERLEVEL9K_VIRTUALENV_BACKGROUND="161"  # magneta

POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="015"  # white
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="105"  # purple

POWERLEVEL9K_TIME_FOREGROUND="015"  # white
POWERLEVEL9K_TIME_BACKGROUND="240"  # gray

# https://github.com/Powerlevel9k/powerlevel9k/blob/master/README.md#available-prompt-segments
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    context vcs dir_writable dir virtualenv background_jobs status newline
    time
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

# https://github.com/romkatv/powerlevel10k
zinit depth=1 light-mode for \
    romkatv/powerlevel10k

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
plugins=(
    # Aliases
    alias-finder
    common-aliases
    extract

    # Distributions
    # archlinux
    # debian

    # Daemons
    gpg-agent

    # Tools
    rsync
    ansible
    fzf
    fd
    ripgrep
    httpie

    # Development
    git
    mercurial
    gitignore
    pip
    virtualenvwrapper
    docker
    docker-compose
    kubectl
    helm
)

# Load OMZ.
. "${ZSH}/oh-my-zsh.sh"

# Load scripts.
scripts=(
    aliases.sh
    functions.sh
    custom.sh
)
for script in "${scripts[@]}"; do
    script_path="${XDG_CONFIG_HOME}/zsh/${script}"
    if [[ -f "${script_path}" ]]; then
        . "${script_path}"
    fi
done

# https://github.com/zsh-users/zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions/issues/363
zinit wait lucid atload'_zsh_autosuggest_start' light-mode for \
    zsh-users/zsh-autosuggestions
# ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(backward-kill-word)

# https://github.com/zsh-users/zsh-syntax-highlighting
# Source command must be at the end of the file!
zinit light zsh-users/zsh-syntax-highlighting
