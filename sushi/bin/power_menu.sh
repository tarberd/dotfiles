lock=$HOME/dotfiles/bin/lock.sh

case $(wofi -d -L 9 -l 3 -W 110 -x -100 -y 10 \
    << EOF | sed 's/^ *//'
    Shutdown
    Reboot
    Suspend
    Hibernate
    UEFI
    Logout
    Lock
    Cancel
EOF
) in
    "Shutdown")
        systemctl poweroff
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "UEFI")
        systemctl reboot --firmware-setup
        ;;
    "Suspend")
        $lock && systemctl suspend
        ;;
    "Hibernate")
        $lock && systemctl hibernate
        ;;
    "Logout")
        swaymsg exit
        ;;
    "Lock")
        $lock
        ;;
esac
