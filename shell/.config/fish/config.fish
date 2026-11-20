if status is-interactive
    # Commands to run in interactive sessions can go here
end

/opt/homebrew/bin/brew shellenv fish | source
fish_add_path -g /Library/Frameworks/Python.framework/Versions/3.13/bin
fish_add_path -g /opt/local/bin /opt/local/sbin
fish_add_path -g ~/.local/bin

set -x MIRRORD_LAYER_FILE_MACOS_ARM64 "/usr/local/share/libmirrord_layer.dylib"

set -gx GPG_TTY (tty)
