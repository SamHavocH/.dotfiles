-- Caelestia variable overrides: lyne-dots keybinding layout.
-- Only the bindings that Caelestia exposes as variables live here; the rest are
-- rebound in hypr-user.lua.

return {
    -- Workspaces: SUPER + 1-0 to switch, SUPER + SHIFT + 1-0 to move a window
    kbGoToWs                   = "SUPER",
    kbMoveWinToWs              = "SUPER + SHIFT",
    kbGoToWsGroup              = "CTRL + SUPER",
    kbMoveWinToWsGroup         = "CTRL + SUPER + ALT",
    kbNextWs                   = "CTRL + SUPER + Right",
    kbPrevWs                   = "CTRL + SUPER + Left",

    -- Window groups (unchanged from Caelestia defaults)
    kbWindowGroupCycleNext     = "ALT + TAB",
    kbWindowGroupCyclePrev     = "SHIFT + ALT + TAB",
    kbUngroup                  = "SUPER + U",
    kbToggleGroup              = "SUPER + Comma",

    -- Window actions
    kbCloseWindow              = "SUPER + Q",
    kbWindowFullscreen         = "SUPER + F",
    kbWindowBorderedFullscreen = "SUPER + SHIFT + F",
    kbToggleWindowFloating     = "SUPER + SHIFT + Space",
    kbPinWindow                = "SUPER + ALT + P", -- SUPER + P is pseudo in lyne
    kbWindowPip                = "SUPER + ALT + backslash",
    -- Mouse move/resize stay on SUPER + LMB/RMB (bound directly by Caelestia).
    -- These extra aliases are moved off SUPER + Z/X, which lyne uses for apps.
    kbMoveWindow               = "CTRL + SUPER + mouse:272",
    kbResizeWindow             = "CTRL + SUPER + mouse:273",

    -- Special workspaces: lyne uses W (chat), M (music), S (scratchpad)
    kbSpecialWs                = "SUPER + S",
    kbMusicWs                  = "SUPER + M",
    kbCommunicationWs          = "SUPER + W",
    kbTodoWs                   = "SUPER + R",
    kbSystemMonitorWs          = "CTRL + SHIFT + Escape",

    -- Apps
    kbTerminal                 = "SUPER + Return",
    kbBrowser                  = "SUPER + Z",
    kbFileExplorer             = "SUPER + D",
    kbEditor                   = "SUPER + C",

    -- Misc
    kbSession                  = "SUPER + End", -- lyne power menu
    kbShowSidebar              = "SUPER + N",
    kbShowPanels               = "SUPER + SHIFT + N", -- SUPER + K is focus up in lyne
    kbClearNotifs              = "CTRL + ALT + C",
    kbLock                     = "CTRL + ALT + L", -- SUPER + L is focus right in lyne
    kbRestoreLock              = "CTRL + ALT + SHIFT + L",
}
