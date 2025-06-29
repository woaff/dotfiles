# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

eval "$(fzf --bash)"
export MANPAGER="vim -M +MANPAGER -"
export HOSTS=/mnt/c/Windows/System32/drivers/etc/hosts

# fzf preview
export FZF_DEFAULT_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || cat {} 2>/dev/null | head -500"'

# Enable TAB completion using fzf
source ~/fzf-tab-completion/bash/fzf-bash-completion.sh
bind -x '"\t": fzf_bash_completion'

export HTTP_PORT=10810
export SOCKS_PORT=10811
export HOSTIP=$(awk '/nameserver/ {print $2}' /etc/resolv.conf)

alias proxy='
	export HTTP_PROXY="http://$HOSTIP:$HTTP_PORT"
	export HTTPS_PROXY="http://$HOSTIP:$HTTP_PORT"
	export ALL_PROXY="socks5://$HOSTIP:$SOCKS_PORT"
	git config --global http.proxy "socks5://$HOSTIP:$SOCKS_PORT"
	git config --global https.proxy "socks5://$HOSTIP:$SOCKS_PORT"
'

alias unproxy='
	unset HTTP_PROXY
	unset HTTPS_PROXY
	unset ALL_PROXY
	git config --global --unset http.proxy
	git config --global --unset https.proxy
'
