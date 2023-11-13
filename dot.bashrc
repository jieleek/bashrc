# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias gl="git log --oneline --all --graph --decorate  $*"
alias rm="rm -i"
alias notepad3="/mnt/c/Users/x/scoop/apps/notepad3/current/Notepad3.exe"
JAVA11_HOME="/usr/lib/jvm/java-11-openjdk"
JAVA8_HOME="/usr/lib/jvm/java-1.8.0-openjdk"
export JAVA8_HOME JAVA11_HOME

# Cleanup all Windows PATH environment
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

# Run following line to disable PS1 change by conda
# $ conda config --set changeps1 false

function parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function parse_git_branch_and_conda() {
    local branchname=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [ ! "${branchname}" == "" ]
    then
        echo -e " (g ${branchname} c $CONDA_DEFAULT_ENV)"
    else
        echo " (c $CONDA_DEFAULT_ENV)"
    fi
}

export HISTSIZE=9999
export PS1="\n\u@oracle \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \n$ "
# export PS1="\n$PS1 \[\033[33m\]\$(parse_git_branch_and_conda)\[\033[00m\] \n$ "

export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/home/noname/perl5";
export PERL_MB_OPT="--install_base /home/noname/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/noname/perl5";
export PERL5LIB="/home/noname/perl5/lib/perl5:$PERL5LIB";
export PATH="/home/noname/perl5/bin:$PATH";

M2_HOME=/home/noname/apache/apache-maven-3.8.4
export PATH="$M2_HOME/bin:$PATH";

source <(kubectl completion bash)
source /home/linuxbrew/.linuxbrew/etc/profile.d/z.sh

export PKG_CONFIG_PATH=/usr/share/pkgconfig:$PKG_CONFIG_PATH

export DOTNET_ROOT="/home/linuxbrew/.linuxbrew/opt/dotnet/libexec"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
