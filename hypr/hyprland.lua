-- Oskar's Hyprland Lua config.
-- Rewritten from ~/.config/hypr/hyprland.conf for Hyprland >= 0.55.

----------------
--  MONITORS  --
----------------

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "", mode = "2560x1440@143.91Hz", position = "auto", scale = "auto" })

-------------------
--  MY PROGRAMS  --
-------------------

local terminal = "kitty fish"
local fileManager = "nautilus"
local menu = "wofi --show drun"
local mainMod = "ALT" -- Physical Super position on my remapped keyboards.
local screenshotDir = "~/Dropbox/Screenshots"

-----------------
--  AUTOSTART  --
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
end)

-----------------------------
--  ENVIRONMENT VARIABLES  --
-----------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

---------------------
--  LOOK AND FEEL  --
---------------------

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 4,
        rounding_power = 2,
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
        force_split = 2,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = true,
        focus_on_activate = true,
    },

    cursor = {
        hide_on_key_press = true,
    },
})

-- Default curves and animations.
hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 } } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

-------------
--  INPUT  --
-------------

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "ctrl:nocaps",
        kb_rules = "",
        repeat_rate = 40,
        repeat_delay = 300,
        numlock_by_default = false,
        follow_mouse = 0,
        sensitivity = -0.7,
        accel_profile = "flat",
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

------------------
--  KEYBINDINGS --
------------------

local function bind(keys, dispatcher, desc)
    hl.bind(keys, dispatcher, desc and { description = desc } or nil)
end

local function bind_locked_repeating(keys, command)
    hl.bind(keys, hl.dsp.exec_cmd(command), { locked = true, repeating = true })
end

bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal), "Launch terminal")
bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu), "Launch app menu")
bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("xdg-open https://"), "Launch browser")
bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(fileManager), "Launch file manager")
bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd('command -v obsidian >/dev/null 2>&1 && obsidian vault="Notes" || xdg-open "obsidian://open?vault=Notes"'), "Launch Obsidian")
bind(mainMod .. " + SHIFT + SLASH", hl.dsp.exec_cmd("uwsm-app -- keepassxc"), "Launch password")

bind(mainMod .. " + Q", hl.dsp.window.close(), "Close window")
bind(mainMod .. " + P", hl.dsp.window.pseudo())

for key, dir in pairs({ left = "left", right = "right", up = "up", down = "down", h = "left", j = "down", k = "up", l = "right" }) do
    bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }))
end

for i = 1, 10 do
    local key = tostring(i % 10)
    bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

bind_locked_repeating("XF86AudioRaiseVolume", "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")
bind_locked_repeating("XF86AudioLowerVolume", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
bind_locked_repeating("XF86AudioMute", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
bind_locked_repeating("XF86AudioMicMute", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
bind_locked_repeating("XF86MonBrightnessUp", "brightnessctl -e4 -n2 set 5%+")
bind_locked_repeating("XF86MonBrightnessDown", "brightnessctl -e4 -n2 set 5%-")

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

bind(mainMod .. " + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "Insert" }), "Universal copy")
bind(mainMod .. " + V", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }), "Universal paste")
bind(mainMod .. " + X", hl.dsp.send_shortcut({ mods = "CTRL", key = "X" }), "Universal cut")

bind(mainMod .. " + F", hl.dsp.window.fullscreen(0), "Full screen")
bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2 }), "Tiled full screen")
bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen(1), "Full width")
bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }), "Toggle floating")

bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }), "Next workspace")
bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }), "Previous workspace")
bind(mainMod .. " + CTRL + TAB", hl.dsp.focus({ workspace = "previous" }), "Former workspace")

for key, dir in pairs({ LEFT = "left", RIGHT = "right", UP = "up", DOWN = "down", h = "left", j = "down", k = "up", l = "right" }) do
    bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.swap({ direction = dir }), "Swap window " .. dir)
end

bind("ALT + TAB", hl.dsp.window.cycle_next(), "Cycle to next window")
bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next("prev"), "Cycle to prev window")
bind("ALT + TAB", hl.dsp.window.bring_to_top(), "Bring active to top")
bind("ALT + SHIFT + TAB", hl.dsp.window.bring_to_top(), "Bring active to top")

bind(mainMod .. " + minus", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), "Shrink window width")
bind(mainMod .. " + equal", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), "Expand window width")
bind(mainMod .. " + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), "Shrink window height")
bind(mainMod .. " + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), "Expand window height")

bind(mainMod .. " + G", hl.dsp.group.toggle(), "Toggle window grouping")
bind(mainMod .. " + ALT + G", hl.dsp.group.move_window("out"), "Move window out of group")
bind(mainMod .. " + ALT + LEFT", hl.dsp.group.move_window("left"), "Move window to group left")
bind(mainMod .. " + ALT + RIGHT", hl.dsp.group.move_window("right"), "Move window to group right")
bind(mainMod .. " + ALT + TAB", hl.dsp.group.next(), "Next window in group")
bind(mainMod .. " + ALT + SHIFT + TAB", hl.dsp.group.prev(), "Prev window in group")

bind("PRINT", hl.dsp.exec_cmd("~/.local/bin/grimblast -f copysave area " .. screenshotDir .. "/$(date +%Y-%m-%d_%H-%M-%S).png"), "Screenshot region")
bind("SHIFT + PRINT", hl.dsp.exec_cmd("~/.local/bin/grimblast copysave output " .. screenshotDir .. "/$(date +%Y-%m-%d_%H-%M-%S).png"), "Screenshot fullscreen")
