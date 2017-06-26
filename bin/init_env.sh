#!/bin/bash

export PATH="~/scripts_config/bin:$PATH"

# save original variables
if [[ -z "$_ORIGINAL_PATH" ]]; then
	echo "Saving path + ld library path"
	export _ORIGINAL_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
	export _ORIGINAL_PATH=$PATH
else
	echo "Restoring path + ld library path"
	export PATH=$_ORIGINAL_PATH
	export LD_LIBRARY_PATH=$_ORIGINAL_LD_LIBRARY_PATH
fi

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENV_PYTHON=/usr/bin/python3
if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
	source /usr/local/bin/virtualenvwrapper.sh
fi

export EDITOR=vim
alias ll='ls -lh'

hostname=`hostname`

if [[ "$hostname" == "pcsochor" ]]; then
	echo "PCsochor specific variables"
	export PREFIX="/home/isochor/local"
	export MATLABROOT=""
	export PS1="\[$(tput bold)\]\[$(tput setaf 7)\][\[$(tput setaf 3)\]\t \\[$(tput setaf 2)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 2)\]\h \[$(tput setaf 4)\]\w\[$(tput setaf 7)\]]\[$(tput setaf 4)\] \[$(tput sgr0)\]\n\[$(tput bold)\]\[$(tput setaf 4)\]$ \[$(tput sgr0)\]"
elif [[ "$hostname" == "pcsochorgpu" ]]; then
	echo "PCsochor-GPU specific variables"
	export PREFIX="/home/isochor/local"
	export MATLABROOT="/usr/local/MATLAB/R2015b"
	alias matlab='LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libstdc++.so.6" matlab'
	export PS1="\[$(tput bold)\]\[$(tput setaf 7)\][\[$(tput setaf 3)\]\t \\[$(tput setaf 2)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 1)\]\h \[$(tput setaf 4)\]\w\[$(tput setaf 7)\]]\[$(tput setaf 4)\] \[$(tput sgr0)\]\n\[$(tput bold)\]\[$(tput setaf 4)\]$ \[$(tput sgr0)\]"
else
	echo "SGE specific variables"
	PREXIX="/mnt/matylda1/isochor/local"
	alias qmy-all='qstat -u isochor'
	alias qlog='qlogin -q long.q@@stable -l ram_free=15000M,mem_free=15000M,matylda1=1'
	alias qlog-res='qlogin -q long.q@@stable -l ram_free=150000M,mem_free=150000M,matylda1=1'
	alias qlog-gpu='qlogin -q long.q@@gpu -l gpu=1,matylda1=10,mem_free=5G,ram_free=5G'
	alias matlab='LD_PRELOAD="/usr/lib64/libstdc++.so.6" matlab'
	export PS1="\[$(tput bold)\]\[$(tput setaf 7)\][\[$(tput setaf 3)\]\t \\[$(tput setaf 2)\]\u\[$(tput setaf 5)\]@\[$(tput setaf 5)\]\h \[$(tput setaf 4)\]\w\[$(tput setaf 7)\]]\[$(tput setaf 4)\] \[$(tput sgr0)\]\n\[$(tput bold)\]\[$(tput setaf 4)\]$ \[$(tput sgr0)\]"
fi


if [[ ! -z "$PREFIX" ]]; then
	echo "Adding $PREFIX to path and ld library path"
	if [[ -d "$PREFIX/bin" ]]; then
		export PATH="$PREFIX/bin:$PATH"
	fi
	if [[ -d "$PREFIX/lib" ]]; then
		export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
	fi
	if [[ -d "$PREFIX/lib64" ]]; then
		export LD_LIBRARY_PATH="$PREFIX/lib64:$LD_LIBRARY_PATH"
	fi
	if [[ -d "$PREFIX/lib/pkgconfig" ]]; then
		export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"
	fi
fi

if [[ ! -z "$MATLABROOT" ]]; then
	echo "Adding $MATLABROOT to path"
	export PATH="$MATLABROOT/bin:$PATH"
fi


tmux_session_name="isochor-tmux"
if [[ "$hostname" != "pcsochor" ]]; then
	if [[ $- == *i* ]]; then
		if [[ "$TERM" != "screen" ]]; then
		    if tmux has-session -t $tmux_session_name 2>/dev/null; then
		        tmux attach -t $tmux_session_name
		    else
		        tmux  new -s $tmux_session_name
		    fi
		fi
	fi
fi
