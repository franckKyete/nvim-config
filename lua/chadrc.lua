-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "dark_horizon",
    theme_toggle = { "vscode_light", "dark_horizon" },
    -- transparency = 0.,
    -- opacity = 0.5,
    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },
}


-- M.nvdash = { load_on_startup = true }
M.ui = {
    tabufline = {
        lazyload = false,
        enabled = true,
        order = { "treeOffset", "buffers", "tabs", },
    },
    statusline = {
        enabled = true,
        theme = "default",
        separator_style = "round"
    },
    telescope = { style = "bordered" }, -- borderless / bordered

}
M.nvdash = {
    load_on_startup = true,

    header = {
        "                            ",
        "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
        "   ▄▀███▄     ▄██ █████▀    ",
        "   ██▄▀███▄   ███           ",
        "   ███  ▀███▄ ███           ",
        "   ███    ▀██ ███           ",
        "   ███      ▀ ███           ",
        "   ▀██ █████▄▀█▀▄██████▄    ",
        "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
        "                            ",
        "     Powered By  eovim    ",
        "                            ",
    },

    -- buttons = {
    --     { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
    --     { txt = "  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
    --     -- more... check nvconfig.lua file for full list of buttons
    -- },


    buttons = {
        { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
        { txt = "󰈚  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
        { txt = "󰈭  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
        { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },
    },
}


return M
