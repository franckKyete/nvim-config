return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        opts = {
            git = { enable = true, timeout = 4000, },
            modified = { enable = true },
            diagnostics = { enable = true },
            view = { side = "left" },


            renderer = {
                highlight_git = "icon",
                highlight_diagnostics = "all",
                highlight_modified = "icon"
            }
        },
    }
}
