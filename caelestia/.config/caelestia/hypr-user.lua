-- User keybindings: lyne-dots layout on top of the Caelestia shell.
-- Loaded after hyprland/keybinds.lua, so it can remove Caelestia defaults that
-- clash with the lyne bindings and add the vim-style ones lyne relies on.

local fn = require("utils.functions")

-- Remove Caelestia defaults that collide with lyne bindings.
-- Wrapped in pcall so an API change can never abort the whole config load.
local function unbind(keys)
    for _, key in ipairs(keys) do
        pcall(hl.unbind, key)
    end
end

unbind({
    "SUPER + SUPER_L",       -- double-tap SUPER launcher -> lyne uses SUPER + Space only
    "SUPER + SHIFT + L",     -- suspend -> lyne: move window right
    "SUPER + SHIFT + M",     -- mute -> lyne: move window to music workspace
    "SUPER + SHIFT + S",     -- screenshot freeze -> lyne: move window to scratchpad
    "SUPER + Minus",         -- resize -> lyne: zoom out
    "SUPER + Equal",         -- resize -> lyne: zoom in
})

-- Replacements for the unbound Caelestia actions
hl.bind("CTRL + ALT + SHIFT + Delete", hl.dsp.exec_cmd("systemctl suspend-then-hibernate"), { locked = true })
hl.bind("CTRL + SUPER + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("CTRL + SUPER + S", hl.dsp.global("caelestia:screenshotFreeze"))

-- Move focus: SUPER + H J K L
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

-- Move window: SUPER + SHIFT + H J K L
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Resize window: SUPER + ALT + H J K L
hl.bind("SUPER + ALT + H", fn.resize_active_window(-20, 0), { repeating = true })
hl.bind("SUPER + ALT + L", fn.resize_active_window(20, 0), { repeating = true })
hl.bind("SUPER + ALT + K", fn.resize_active_window(0, -20), { repeating = true })
hl.bind("SUPER + ALT + J", fn.resize_active_window(0, 20), { repeating = true })

-- Workspace navigation: CTRL + SUPER + H/L
hl.bind("CTRL + SUPER + H", hl.dsp.focus({ workspace = "-1" }), { repeating = true })
hl.bind("CTRL + SUPER + L", hl.dsp.focus({ workspace = "+1" }), { repeating = true })
hl.bind("CTRL + SUPER + SHIFT + H", hl.dsp.window.move({ workspace = "-1" }), { repeating = true })
hl.bind("CTRL + SUPER + SHIFT + L", hl.dsp.window.move({ workspace = "+1" }), { repeating = true })
hl.bind("CTRL + SUPER + SHIFT + Left", hl.dsp.window.move({ workspace = "-1" }), { repeating = true })
hl.bind("CTRL + SUPER + SHIFT + Right", hl.dsp.window.move({ workspace = "+1" }), { repeating = true })

-- Move window to a special workspace: SUPER + SHIFT + W/M/S
hl.bind("SUPER + SHIFT + W", hl.dsp.window.move({ workspace = "special:communication" }))
hl.bind("SUPER + SHIFT + M", hl.dsp.window.move({ workspace = "special:music" }))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:special" }))

-- Layout actions
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + Tab", hl.dsp.layout("togglesplit"))

-- Launcher on SUPER + Space (the double-tap SUPER binding still works)
hl.bind("SUPER + Space", hl.dsp.global("caelestia:launcher"))

-- Screen zoom: SUPER + = / SUPER + -
local zoom = 1.0
local function set_zoom(delta)
    return function()
        zoom = math.max(1.0, math.min(5.0, zoom + delta))
        hl.dispatch(hl.dsp.exec_cmd(("hyprctl keyword cursor:zoom_factor %.1f"):format(zoom)))
    end
end
hl.bind("SUPER + Equal", set_zoom(0.2), { repeating = true })
hl.bind("SUPER + Minus", set_zoom(-0.2), { repeating = true })

-- Wallpaper: Caelestia has no picker drawer, so this cycles to a random one
hl.bind("SUPER + B", hl.dsp.exec_cmd("caelestia wallpaper -r"))
