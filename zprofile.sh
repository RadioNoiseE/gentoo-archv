[[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && exec startx

test -r /home/rne/.opam/opam-init/init.sh && . /home/rne/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
