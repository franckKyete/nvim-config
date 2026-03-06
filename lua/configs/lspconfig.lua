local base = require("nvchad.configs.lspconfig")
base.defaults()

-- local on_attach = base.on_attach
-- local capabilities = base.capabilities

local lspconfig = vim.lsp.config

-- vim.lsp.handlers["textDocument/signatureHelp"] =
--     vim.lsp.with(vim.lsp.handlers.signature_help, { focus = false })

local servers = { "html", "bashls", "cssls", "slint-lsp", "kotlin_language_server", "typos-lsp",
    "csharp-language-server", "lemminx", "tailwindcss-language-server", "ts_ls", "eslint", "ast_grep", "slint_lsp",
    "csharp_ls", "laravel_ls" }

-- lspconfig.intelephense = {
--     root_dir = require('lspconfig.util').root_pattern("composer.json", ".git", "package.json"),
--     -- ... other config
-- }
lspconfig.laravel_ls = {
    -- root_dir = require('lspconfig.util').root_pattern("composer.json", ".git", "package.json"),
    settings = {
        intelephense = {
            environment = {
                includePaths = {
                    "vendor"
                }
            },
            files = {
                maxSize = 5000000
            }
        }
    }
}

lspconfig.slint_lsp = {
    cmd = {
        "slint-lsp",
        "-L", "material=./ui/lib/material/material.slint",
    }
}

lspconfig["tailwindcss-language-server"] = {
    filetypes = { "html", "css", "javascript", "javascript.jsx", "typescript", "typescriptreact", "javascriptreact", "typescript.tsx" },

}

lspconfig.ts_ls = {
    settings = {
        typescript = {
            tsdk = ".yarn/sdks/typescript/lib"
        },
    },
}
lspconfig.eslint = {
    settings = {
        nodePath = ".yarn/sdks"
    }
}
lspconfig["typos-lsp"] = {
    -- typos-lsp must be on your PATH, or otherwise change this to an absolute path to typos-lsp
    -- defaults to typos-lsp if unspecified
    cmd = { "typos-lsp" },
    -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
    cmd_env = { RUST_LOG = "error" },
    init_options = {
        -- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
        -- Defaults to Info.
        diagnosticSeverity = "Info"
    }
}



lspconfig.lua_ls = {
    -- capabilities = capabilities,
    -- on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.stdpath "config" .. "/lua"] = true,
                },
            },
        },
    },
}


lspconfig.kotlin_language_server = {
    -- on_attach = on_attach,
    -- capabilities = capabilities,
    -- filetypes = { 'kt' },

    -- root_dir = require('lspconfig.util').root_pattern("build.gradle", "settings.gradle"),

    root_dir = vim.fs.dirname(vim.fs.find(
        { "settings.gradle", "build.gradle", ".git" },
        { upward = true })[1]),
    settings = {
        kotlin = {
            compiler = {
                jvm = {
                    target = "21", -- Adjust based on your project
                },
            },
        },
    },

}

lspconfig["rust-analyzer"] = {
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true
            },
            check = {
                command = "check", -- change from "clippy" to "check"
            },
        }
    }
}

vim.lsp.enable(servers)



--
-- -- read :h vim.lsp.config for changing options of lsp servers
