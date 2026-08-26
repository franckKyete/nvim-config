require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
map("t", "jj", [[<C-\><C-n>]])

map('n', '<leader>n', vim.diagnostic.open_float)

map('n', '<leader>h', '<cmd>nohlsearch<CR>')
map({ 'n', 'i' }, '<C-s>', '<cmd>wa<CR><cmd>lua vim.notify("Saved all files!", vim.log.levels.INFO)<CR>')
map('i', '<C-d>', '<cmd>wa<CR><cmd>lua vim.notify("Saved all files!", vim.log.levels.INFO)<CR>')
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "Code actions" })


map('n', '<A-x>', '<cmd>lua require("nvchad.tabufline").close_buffer()<CR>')
map('n', '<M-Left>', '<cmd>lua require("nvchad.tabufline").prev()<CR>')
map('n', '<M-Right>', '<cmd>lua require("nvchad.tabufline").next()<CR>')
map('n', '<A-e>', '<cmd>NvimTreeFocus<CR>', { desc = "Focus the file tree" })


-- Move lines up/down
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("v", "<A-k>", "<cmd>m '>+1<CR>gv=gv", { desc = "Move selection up" })
map("v", "<A-j>", "<cmd>m '<-2<CR>gv=gv", { desc = "Move selection down" })

map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })


local dap = require("dap")

-- Build, then debug
map("n", "<leader>bd", function()
    -- choose your build command:
    local build_cmd = "cargo build" -- or "make", "npm run build", etc.

    -- run build asynchronously
    vim.fn.jobstart(build_cmd, {
        stdout_buffered = true,
        stderr_buffered = true,

        -- on_stdout = function(_, data)
        --     if data then print(table.concat(data, "\n")) end
        -- end,

        on_stderr = function(_, data)
            if data then vim.api.nvim_err_writeln("Some errors occurred") end
            -- if data then vim.api.nvim_err_writeln(table.concat(data, "\n")) end
        end,

        on_exit = function(_, code)
            if code == 0 then
                print("✅ Build succeeded — starting debugger...")
                dap.continue()
            else
                print("❌ Build failed")
            end
        end,
    })
end, { desc = "Build and debug" })

-- map('n', '<M-r>', function ()
--     vim.cmd.vnew()
--     vim.cmd.term()
--     vim.cmd.wincmd("J")
--     vim.api.nvim_win_set_height(0, 10)
--     -- vim.fn.chansend(vim.bo.channel, {"cargo run\r\n"})
-- end)

--  require("nvchad.tabufline").close_buffer()
--
--  -- closes all buffers
--  require("nvchad.tabufline").closeAllBufs(true)
--  require("nvchad.tabufline").closeAllBufs(false) -- excludes current buf
--
--  require("nvchad.tabufline").closeBufs_at_direction("left") -- or right
-- map('n', '<A-x>', ':bp<bar>bd#<CR>')

-- Format current buffer
-- map("n", "F", "<cmd>lua vim.lsp.buf.format()<CR>", { silent = true })

-- Format selection (visual mode)
-- map("v", "F", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", { silent = true })

-- Run neotest
map("n", "T", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
--
map('n', '<leader>ag', '<cmd>Antigravity<cr>', { desc = 'Toggle Antigravity' })
