return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        lazy = false,
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<c-\>]],
                direction = "float",
                shade_terminals = false,
                start_in_insert = true,
                persist_size = true,
                persist_mode = true,
                float_opts = {
                    border = "rounded",
                },
            })

            local overlay = require("configs.terminal_overlay")

            vim.keymap.set("n", "<leader>to", overlay.toggle, { desc = "Toggle terminal overlay" })
            vim.keymap.set({"n", "t"}, "<leader>ta", overlay.add, { desc = "Add terminal to overlay" })
            vim.keymap.set("n", "<leader>tr", function() overlay.remove() end,
                { desc = "Remove last terminal from overlay" })
            vim.keymap.set("n", "<leader>tz", overlay.toggle_zoom, { desc = "Zoom terminal in overlay" })

            vim.keymap.set("n", "<leader>t1", function() overlay.focus(1) end, { desc = "Focus terminal 1" })
            vim.keymap.set("n", "<leader>t2", function() overlay.focus(2) end, { desc = "Focus terminal 2" })
            vim.keymap.set("n", "<leader>t3", function() overlay.focus(3) end, { desc = "Focus terminal 3" })
            vim.keymap.set("n", "<leader>t4", function() overlay.focus(4) end, { desc = "Focus terminal 4" })

            vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
            vim.keymap.set("t", "<leader>tz", function()
                vim.cmd("stopinsert")
                overlay.toggle_zoom()
            end, { desc = "Zoom terminal in overlay" })

            vim.api.nvim_create_autocmd("VimResized", {
                callback = function()
                    overlay.resize()
                end,
            })
        end,
    }
}
