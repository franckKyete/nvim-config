return {

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = true,
            },
            views = { mini = { win_options = { winblend = 0 } } },
            routes = {
                {
                    filter = {
                        event = "msg_showmode",
                    },
                    opts = { skip = false },
                    view = "mini",
                },
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    }
}
