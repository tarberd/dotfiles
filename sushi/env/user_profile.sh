# Comply with XDG Base Directory Specification
# https://specifications.freedesktop.org/basedir-spec/latest/

PATH="${HOME}/.local/bin:${PATH}"
export PATH

# set XDG_DATA_HOME to a machine local prefix so rr and distrobox don't the NFS on $HOME
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"

# end of XDG Base Directory configuration
