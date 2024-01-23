# /etc/skel/.bashrc

export WLR_RENDERER=vulkan
export GTK_IM_MODULE=fcitx # emacs GDK_IS_WAYLAND_DISPLAY assertion fail
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

if [ -z "${WAYLAND_DISPLAY}" ] && [ ${XDG_VTNR} -eq 1 ]; then
    clear
    uname -a
    dbus-run-session sway
fi

complete -cf doas
