if [ -d /home/linuxbrew ]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    alias brew="env PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin brew"
fi
alias md5='openssl md5'
alias aptl='apt list -a'
alias apts='apt search'
alias apti='apt show'
alias aptu='sudo apt update'
alias aptU='sudo apt upgrade'
alias aptI='sudo apt install'
alias aptR='sudo apt autoremove'

alias aptUy='aptU -y'
alias aptIy='aptI -y'
alias aptRy='aptR -y'

alias aptAy='aptu && aptUy && aptRy'
