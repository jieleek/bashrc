# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
source ~/perl5/perlbrew/etc/bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export HOMEBREW_CURL_PATH=/home/linuxbrew/.linuxbrew/bin/curl

 [[ -r "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh" ]] && . "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh"

export PATH="/home/linuxbrew/.linuxbrew/opt/node@18/bin:$PATH"

