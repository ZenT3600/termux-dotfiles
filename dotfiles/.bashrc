source "${EXTERNAL_STORAGE}/termuxlauncher/.apps-launcher"

function inputfromvim() {
	ls $HOME/.tmp 2> /dev/null || mkdir $HOME/.tmp
        nvim $HOME/.tmp/$1
}

function header() {
	neofetch
	echo
	echo -e "# Battery:\n> $(termux-battery-status | jq -r .percentage)%" | glow -
	echo -e "# Notifications:\n> $(termux-notification-list | jq -r .[].id | wc -l)" | glow -
}

alias contactnames="termux-contact-list | jq -r .[].name"
alias contactnums="termux-contact-list | jq -r .[].number"
function name2num() {
	mapfile -t arr < <(contactnames)
	mapfile -t nums < <(contactnums)
	name=$(contactnames | fzf)
	for i in "${!arr[@]}"; do
		if [[ "${arr[$i]}" = "${name}" ]]; then
			echo "${nums[i]}"
		fi
	done
}
alias call="name2num | xargs termux-telephony-call"
alias callnum="termux-telephony-call"
function sms() {
	num=$(name2num)
	inputfromvim sms.input
	cat $HOME/.tmp/sms.input | termux-sms-send -n $num
	rm $HOME/.tmp/sms.input
}
function smsnum() {
	inputfromvim sms.input
	cat $HOME/.tmp/sms.input | termux-send-sms -n $1
	rm $HOME/.tmp/sms.input
}

alias la="ls -la"
alias ls="ls -l"

alias wa="launch whatsapp"
alias ds="launch aliucord"
alias tg="launch nekogram-x"
alias rd="launch reddit"
alias tw="launch twitch"
alias yt="launch newpipe-sponsorblock"
alias em="launch email"

alias app="launch \$(launch --list | fzf)"

export PATH="$PATH:$HOME/scripts"
export GPG_TTY=$(tty)

PS1='\[\e[0;1m\][\[\e[0;2m\]\t\[\e[0;1m\]] \[\e[0;36m\]\u\[\e[0m\]@\[\e[0;36m\]\h \[\e[0m\](\[\e[0;36m\]\w\[\e[0m\])\n\[\e[0m\][\[\e[0;2m\]$(ip route get 1.1.1.1 | awk -F"src " '"'"'NR==1{split($2,a," ");print a[1]}'"'"')\[\e[0m\]] \[\e[0m\]\$\[\e[0m\] '

header
