if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x MIRRORD_LAYER_FILE_MACOS_ARM64 "/usr/local/share/libmirrord_layer.dylib"

set -gx GPG_TTY (tty)
