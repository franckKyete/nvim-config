return {
    {
        "rcarriga/nvim-notify",
        lazy = false,
        opts = {
            timeout = 5000,
            stages = "fade_in_slide_out",
            top_down = false,
            bottom_up = true
        },
        config = function()
            vim.notify = require "notify"
            vim.lsp.handlers["window/showMessage"] = function(_, result, _)
                vim.notify(result.message, vim.log.levels[result.type])
            end
        end,
    }
}
