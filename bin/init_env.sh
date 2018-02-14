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



export EDITOR=vim
alias ll='ls -lh'


hostname=`hostname`
if [[ "$hostname" == "pcsochor" ]]; then
	echo "PCsochor specific variables"
	alias spy='spyder3 -p $(pwd -P)'
	export PREFIX="/home/isochor/local"
	export MATYLDA_ALL_LOCATION="/mnt/matylda1"
	export MATLABROOT=""
	export CUDAHOME=""
	export PYTHON_BIN=/usr/bin/python3
	export PYTHON=python3
	export PS1="\[$(tput bold)\]\[$(tput setaf 7)\][\[$(tput setaf 3)\]\t \\[$(tput setaf 2)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 2)\]\h \[$(tput setaf 4)\]\w\[$(tput setaf 7)\]]\[$(tput setaf 4)\] \[$(tput sgr0)\]\n\[$(tput bold)\]\[$(tput setaf 4)\]$ \[$(tput sgr0)\]"
	export VIRTUALENVWRAPPER_PYTHON=$PYTHON_BIN
    export VIRTUALENV_PYTHON=$PYTHON_BIN
    if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
	    source /usr/local/bin/virtualenvwrapper.sh
    fi
elif [[ "$hostname" == "pcspanhel-gpu" ]]; then
	echo "PCspanhel-GPU specific variables"
	export MATYLDA_ALL_LOCATION="/home/isochor/matylda_all"
	export PREFIX="/home/isochor/local"
	export MATLABROOT=""
	export CUDAHOME=""
	export PYTHON_BIN=/usr/bin/python3
	alias python=python3
	alias pip=pip3
	alias ipython="~/.local/bin/ipython3"
	export PYTHON=/usr/bin/python3
	export PS1="\[$(tput bold)\]\[$(tput setaf 7)\][\[$(tput setaf 3)\]\t \\[$(tput setaf 2)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 1)\]\h \[$(tput setaf 4)\]\w\[$(tput setaf 7)\]]\[$(tput setaf 4)\] \[$(tput sgr0)\]\n\[$(tput bold)\]\[$(tput setaf 4)\]$ \[$(tput sgr0)\]"
else
	echo "SGE specific variables"
	export PREFIX="/mnt/matylda1/isochor/local"
	alias qmy-all='qstat -u isochor'
	alias qlog='qlogin -q long.q@@stable -l ram_free=15000M,mem_free=15000M,matylda1=1'
	alias qlog-res='qlogin -q long.q@@stable -l ram_free=150000M,mem_free=150000M,matylda1=1'
	alias qlog-gpu='qlogin -q long.q@@gpu -l gpu=1,matylda1=10,mem_free=5G,ram_free=5G'
	alias matlab='LD_PRELOAD="/usr/lib64/libstdc++.so.6" matlab'
	alias python=python3.6
	alias pip=pip3.6
	alias ipython="~/.local/bin/ipython3"
	export PYTHON=/usr/local/bin/python3.6
	#echo "Enabling python from $PYTHONHOME"
	#alias activate_canopy="source '/homes/kazi/isochor/Enthought/Canopy_64bit/User/bin/activate'"
	#VIRTUAL_ENV_DISABLE_PROMPT=1 source '/homes/kazi/isochor/Enthought/Canopy_64bit/User/bin/activate'
	export CUDAHOME="/usr/local/share/cuda" #cuda9
	export MATYLDA_ALL_LOCATION="/mnt/matylda1"
	export PATH="/homes/kazi/isochor/.local/bin:$PATH"
	export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
	if [ ! -z "$TERM" ]; then
		export PS1="\[$(tput bold)\]\[$(tput setaf 7)\][\[$(tput setaf 3)\]\t \\[$(tput setaf 2)\]\u\[$(tput setaf 5)\]@\[$(tput setaf 5)\]\h \[$(tput setaf 4)\]\w\[$(tput setaf 7)\]]\[$(tput setaf 4)\] \[$(tput sgr0)\]\n\[$(tput bold)\]\[$(tput setaf 4)\]$ \[$(tput sgr0)\]"	
	fi
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
		export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
	fi
fi

if [[ ! -z "$MATLABROOT" ]]; then
	echo "Adding $MATLABROOT to path"
	export PATH="$MATLABROOT/bin:$PATH"
fi

if [[ ! -z "$CUDAHOME" ]]; then
	echo "Adding CUDA from $CUDAHOME"
	if [[ -d "$CUDAHOME/bin" ]]; then
		export PATH="$CUDAHOME/bin:$PATH"
	fi
	if [[ -d "$CUDAHOME/lib64" ]]; then
		export LD_LIBRARY_PATH="$CUDAHOME/lib64:$LD_LIBRARY_PATH"
	fi
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
