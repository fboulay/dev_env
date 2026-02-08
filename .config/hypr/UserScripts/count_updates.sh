#!/usr/bin/env bash
# Count number of updates for each tool
# Returns a string representing the number of updates


package_count=$( (checkupdates 2>/dev/null ; paru -Qua 2>/dev/null) | wc -l)
mise_count=$(mise outdated --json | jq 'length')
rustup_count=$(rustup check | grep -c "update available")

git -C /home/fboulay/.config/emacs fetch --quiet  
doom_count=$(git -C /home/fboulay/.config/emacs rev-list --count 'HEAD..@{u}')

printf "%s-%s-%s-%s" "$package_count" "$mise_count" "$rustup_count" "$doom_count"
