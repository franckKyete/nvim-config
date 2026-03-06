return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "williamboman/mason.nvim"
    },
    {
        "mrcjkb/rustaceanvim",
        version = '^6',
        lazy = false,
        config = function()
            vim.g.rustaceanvim = {
                -- Plugin configuration
                tools = {
                },
                -- LSP configuration
                server = {
                    default_settings = {
                        -- rust-analyzer language server configuration
                        ['rust-analyzer'] = {
                            check = {
                                command = "check", -- change from "clippy" to "check"
                            },
                            cargo = {
                                allFeatures = true
                            }
                        },
                    },
                },
                -- DAP configuration
                dap = {
                },
            }
        end

    },
    -- test new blink
    { import = "nvchad.blink.lazyspec" },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "lua", "javascript", "typescript",
                "vim", "lua", "vimdoc",
                "html", "css", "slint",
                "rust", "tsx", "kotlin"
            },
            highlight = {
                enable = true
            }
        },
    },

    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        opts = function()
            return require "configs.null-ls"
        end
    },
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "html"
        },
        config = function()
            require("nvim-ts-autotag").setup()
        end
    },
    {
        "tpope/vim-fugitive",
        lazy=false
    }
    -- test new blink
    -- { import = "nvchad.blink.lazyspec" },

    -- {
    -- 	"nvim-treesitter/nvim-treesitter",
    -- 	opts = {
    -- 		ensure_installed = {
    -- 			"vim", "lua", "vimdoc",
    --      "html", "css"
    -- 		},
    -- 	},
    -- },
}
