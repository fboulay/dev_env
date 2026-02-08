#!/usr/bin/env bash
# Check updates using any software providing updates 

echo -e "Pacman"
checkupdates  

echo -e '\nAUR'  

paru -Qua  
echo -e '\nmise'  

mise outdated  

echo -e '\nrustup'  
rustup check  

echo -e '\nDoom emacs'  

cd /home/fboulay/.config/emacs || exit  
git fetch --quiet  
git rev-list 'HEAD..@{u}' 
