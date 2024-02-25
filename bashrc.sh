# /etc/skel/.bashrc

export WLR_RENDERER=gles2 # swaybg WL_DISPLAY_ROUNDTRIP failed for vulkan
export GTK_IM_MODULE=fcitx # emacs GDK_IS_WAYLAND_DISPLAY assertion fail for wayland
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

if [ -z "${WAYLAND_DISPLAY}" ] && [ ${XDG_VTNR} -eq 1 ]; then
    clear
  # uname -a
    dbus-run-session sway &>/dev/null
fi

# complete -cf doas

PATH=/usr/local/texlive/2023/bin/x86_64-linux:$PATH; export PATH
MANPATH=/usr/local/texlive/2023/texmf-dist/doc/man:$MANPATH; export MANPATH
INFOPATH=/usr/local/texlive/2023/texmf-dist/doc/info:$INFOPATH; export INFOPATH

alias proxy="doas anyconnect ~/.anyconnect"

# opam configuration
test -r /home/rne/.opam/opam-init/init.sh && . /home/rne/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# set fish as default user shell
[ -x /bin/fish ] && SHELL=/bin/fish exec fish
