#!/bin/bash


export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENV_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

export EDITOR=vim

# initial variables
export PREFIX="/home/isochor/local"
export MATLABROOT="/usr/local/MATLAB/R2016b/"


# save original variables
if [[ -z "$ORIGINAL_PATH" ]]; then
	echo "Saving path + ld library path"
	export ORIGINAL_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
	export ORIGINAL_PATH=$PATH
else
	echo "Restoring path + ld library path"
	export PATH=$ORIGINAL_PATH
	export LD_LIBRARY_PATH=$ORIGINAL_LD_LIBRARY_PATH
fi


export PATH="$PREFIX/bin:$PATH"
export PATH="$MATLABROOT/bin:$PATH"


export PS1="\[$(tput bold)\]\[$(tput setaf 7)\][\[$(tput setaf 3)\]\t \\[$(tput setaf 2)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 2)\]\h \[$(tput setaf 4)\]\w\[$(tput setaf 7)\]]\[$(tput setaf 4)\] \[$(tput sgr0)\]\n\[$(tput bold)\]\[$(tput setaf 4)\]$ \[$(tput sgr0)\]"