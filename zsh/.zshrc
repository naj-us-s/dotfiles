export XDG_CONFIG_HOME="$HOME/.config"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

alias ls="eza --icons=always"

eval "$(zoxide init zsh)"

alias cd="z"
#starship
export STARSHIP_CONFIG="$HOME/dotfiles/.config/starship/starship.toml"
eval "$(starship init zsh)"

export PATH=$PATH:/Users/kagaseo/.spicetify
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# --yazi config
export EDITOR="nvim"


# Added by Antigravity
export PATH="/Users/kagaseo/.antigravity/antigravity/bin:$PATH"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

ani-status() {
	local hist="${ANI_CLI_HIST_DIR:-${XDG_STATE_HOME:-$HOME/.local/state}/ani-cli}/ani-hsts"
	local mode="${ANI_CLI_MODE:-sub}"
	local api="https://api.allanime.day/api"
	local ref="https://allmanga.to"
	local agent='Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/121.0'
	local gql='query ($showId: String!) { show( _id: $showId ) { _id availableEpisodesDetail }}'
	local found=0

	[[ -s "$hist" ]] || { print "No ani-cli history yet."; return 0; }
	print "Watched history"
	awk -F '\t' '{printf "  %d. %s — last watched: %s\n", NR, $3, $1}' "$hist"

	print "\nUnwatched episodes"
	while IFS=$'\t' read -r watched id title; do
		local latest="$(
			curl -e "$ref" -s -H "Content-Type: application/json" -X POST "$api" \
				--data "{\"variables\":{\"showId\":\"$id\"},\"query\":\"$gql\"}" -A "$agent" |
			sed -nE "s|.*$mode\\\":\\[([0-9.\\\",]*)\\].*|\\1|p" |
			sed 's|,|\n|g; s|\"||g' |
			sort -n -k 1 |
			awk 'NF{v=$0} END{print v}'
		)"
		[[ -z "$latest" ]] && continue
		if awk -v a="$latest" -v b="$watched" 'BEGIN{exit !(a>b)}'; then
			print -- "  - $title (watched: $watched, latest: $latest)"
			found=1
		fi
	done < "$hist"
	(( found == 0 )) && print -- "  - none"
}
