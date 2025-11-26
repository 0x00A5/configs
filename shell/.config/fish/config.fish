if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x MIRRORD_LAYER_FILE_MACOS_ARM64 "../../../target/aarch64-apple-darwin/debug/libmirrord_layer.dylib"
source ~/.local/bin/env

set -gx GPG_TTY (tty)
