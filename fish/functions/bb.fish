# ~/.local/bin/bb is the desktop AppImage, which ignores CLI args.
# Route to the real CLI inside the running app's mount instead.
function bb
    if set -q BB_CLI
        $BB_CLI $argv
        return
    end
    set -l cli /tmp/.mount_bb*/resources/app.asar.unpacked/node_modules/bb-app/host-daemon/dist/bb
    if test -n "$cli[1]"
        $cli[1] $argv
    else
        command bb $argv
    end
end
