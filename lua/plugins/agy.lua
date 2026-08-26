return {
    {
        "denerblack/agy.nvim",
        lazy = false,
        config = function()
            require("agy").setup({
                -- continue = true,            -- always resume the last conversation
                -- skip_permissions = true,    -- pass --dangerously-skip-permissions
                -- args = { "--add-dir", vim.fn.getcwd() },
            })
        end,
        keys = {
            { "<C-,>",      function() require("agy").toggle() end, mode = { "n", "t" },                     desc = "Toggle agy" },
            { "<leader>na", function() require("agy").toggle() end, desc = "Toggle agy" },
            { "<leader>nc", "<cmd>AgyContinue<cr>",                 desc = "agy: continue last conversation" },
            { "<leader>nf", "<cmd>AgySendFile<cr>",                 desc = "agy: send current file" },
            { "<leader>nm", "<cmd>AgyMcpInstall<cr>",               desc = "agy: install MCP bridge" },
            -- visual: use the range-aware command (range-safe; avoids E481 "No range allowed")
            { "<leader>ns", "<cmd>AgySendSelection<cr>",            mode = "v",                              desc = "agy: send selection" },
        },
    },
}
