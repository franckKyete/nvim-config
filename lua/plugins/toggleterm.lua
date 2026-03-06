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

            vim.keymap.set({"n", "t"}, "<M-t>", overlay.toggle, { desc = "Toggle terminal overlay" })
            vim.keymap.set({"n", "t"}, "<M-a>", overlay.add, { desc = "Add terminal to overlay" })
            vim.keymap.set("n", "<M-r>", function() overlay.remove() end,
                { desc = "Remove last terminal from overlay" })
            vim.keymap.set("n", "<M-z>", overlay.toggle_zoom, { desc = "Zoom terminal in overlay" })

            vim.keymap.set({"n", "t"}, "<M-1>", function() overlay.focus(1) end, { desc = "Focus terminal 1" })
            vim.keymap.set({"n", "t"}, "<M-2>", function() overlay.focus(2) end, { desc = "Focus terminal 2" })
            vim.keymap.set({"n", "t"}, "<M-3>", function() overlay.focus(3) end, { desc = "Focus terminal 3" })
            vim.keymap.set({"n", "t"}, "<M-4>", function() overlay.focus(4) end, { desc = "Focus terminal 4" })

            vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
            vim.keymap.set("t", "<M-z>", function()
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
