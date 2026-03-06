require("noice").setup({
    lsp = {
        hover = {
            enabled = true,
            silent = false,
            -- use a border to differentiate
            border = "rounded",
        },
        signature = {
            enabled = false,
            border = "rounded",
        },
    },
    -- optional: make all popups stand out
    popupmenu = {
        border = { style = "rounded" }
    },
})
-- vim.cmd [[
--     highlight! link NoiceHover NormalFloat
--     highlight! NormalFloat guibg=#1e1e2e
--     highlight! FloatBorder guifg=#f38ba8 guibg=#1e1e2e
-- ]]
