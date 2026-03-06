local M = {}

local Terminal = require("toggleterm.terminal").Terminal

local state = {
    open = false,
    terms = {},
    wins = {},
    next_count = 101,
    zoomed_index = nil,
    last_focused_index = 1,
}

local function start_insert()
    vim.cmd("startinsert")
end

local function valid_win(win)
    return win and vim.api.nvim_win_is_valid(win)
end

local function valid_buf(buf)
    return buf and vim.api.nvim_buf_is_valid(buf)
end

local function close_all_wins()
    for _, win in ipairs(state.wins) do
        if valid_win(win) then
            vim.api.nvim_win_close(win, true)
        end
    end
    state.wins = {}
end

local function create_term()
    local term = Terminal:new({
        count = state.next_count,
        hidden = true,
    })
    state.next_count = state.next_count + 1
    return term
end

local function ensure_term_buf(term)
    if valid_buf(term.bufnr) then
        return term.bufnr
    end

    term:open()
    term:close()
    return term.bufnr
end

local function open_float(buf, row, col, width, height)
    return vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        row = row,
        col = col,
        width = width,
        height = height,
        style = "minimal",
        border = "rounded",
        zindex = 20,
    })
end

local function set_win_opts(win)
    vim.wo[win].number = false
    vim.wo[win].relativenumber = false
    vim.wo[win].signcolumn = "no"
    vim.wo[win].cursorline = false
    vim.wo[win].winblend = 0
end

local function overlay_geometry()
    local ui = vim.api.nvim_list_uis()[1]
    local total_w = math.floor(ui.width * 0.86)
    local total_h = math.floor(ui.height * 0.82)
    local start_col = math.floor((ui.width - total_w) / 2)
    local start_row = math.floor((ui.height - total_h) / 2)

    return {
        width = total_w,
        height = total_h,
        col = start_col,
        row = start_row,
        gap = 0,
    }
end

local function compute_layout(n)
    local g = overlay_geometry()
    local row = g.row
    local col = g.col
    local width = g.width
    local height = g.height
    local gap = g.gap

    if n <= 0 then
        return {}
    end

    if n == 1 then
        return {
            { row = row, col = col, width = width - 2, height = height - 2 },
        }
    end

    if n == 2 then
        local cell_w = math.floor((width - gap) / 2) - 2
        local cell_h = height - 2

        return {
            { row = row, col = col,                    width = cell_w, height = cell_h },
            { row = row, col = col + cell_w + 2 + gap, width = cell_w, height = cell_h },
        }
    end

    if n == 3 then
        local top_h = math.floor((height - gap) / 2) - 2
        local bottom_h = math.floor((height - gap) / 2) - 2
        local top_w = math.floor((width - gap) / 2) - 2

        return {
            { row = row,                   col = col,                   width = top_w,     height = top_h },
            { row = row,                   col = col + top_w + 2 + gap, width = top_w,     height = top_h },
            { row = row + top_h + 2 + gap, col = col,                   width = width - 2, height = bottom_h },
        }
    end

    -- 4+ => 2x2 using first 4 terminals
    local cell_w = math.floor((width - gap) / 2) - 2
    local cell_h = math.floor((height - gap) / 2) - 2

    return {
        { row = row,                    col = col,                    width = cell_w, height = cell_h },
        { row = row,                    col = col + cell_w + 2 + gap, width = cell_w, height = cell_h },
        { row = row + cell_h + 2 + gap, col = col,                    width = cell_w, height = cell_h },
        { row = row + cell_h + 2 + gap, col = col + cell_w + 2 + gap, width = cell_w, height = cell_h },
    }
end


local function get_focused_overlay_index()
    local current = vim.api.nvim_get_current_win()
    for i, win in ipairs(state.wins) do
        if win == current and valid_win(win) then
            return i
        end
    end
    return state.last_focused_index or 1
end

local function set_focus(index)
    local win = state.wins[index]
    if valid_win(win) then
        state.last_focused_index = index
        vim.api.nvim_set_current_win(win)
        start_insert()
    end
end

function M.render()
    close_all_wins()

    local count = math.min(#state.terms, 4)
    if count == 0 then
        state.open = false
        return
    end

    local layout = {}

    if state.zoomed_index then
        local g = overlay_geometry()
        layout = {
            {
                row = g.row,
                col = g.col,
                width = g.width - 2,
                height = g.height - 2,
            },
        }

        local term = state.terms[state.zoomed_index]
        local buf = ensure_term_buf(term)
        local win = open_float(buf, layout[1].row, layout[1].col, layout[1].width, layout[1].height)
        set_win_opts(win)
        state.wins = { win }
        state.open = true
        return
    end

    layout = compute_layout(count)

    for i = 1, count do
        local term = state.terms[i]
        local buf = ensure_term_buf(term)
        local box = layout[i]

        local win = open_float(buf, box.row, box.col, box.width, box.height)
        set_win_opts(win)
        table.insert(state.wins, win)
    end

    state.open = true
end

function M.open()
    if #state.terms == 0 then
        table.insert(state.terms, create_term())
    end

    M.render()
    if valid_win(state.wins[1]) then
        vim.api.nvim_set_current_win(state.wins[1])
        start_insert()
    end
end

function M.close()
    close_all_wins()
    state.open = false
end

function M.toggle()
    if state.open then
        M.close()
    else
        M.open()
    end
end

function M.add()
    if #state.terms >= 4 then
        vim.notify("Terminal overlay supports up to 4 terminals", vim.log.levels.WARN)
        return
    end

    table.insert(state.terms, create_term())
    M.render()

    local idx = #state.wins
    if valid_win(state.wins[idx]) then
        vim.api.nvim_set_current_win(state.wins[idx])
        start_insert()
    end
end

function M.remove(index)
    if #state.terms == 0 then
        return
    end

    index = index or #state.terms

    if index < 1 or index > #state.terms then
        return
    end

    table.remove(state.terms, index)

    if #state.terms == 0 then
        M.close()
        return
    end

    M.render()
    local target = math.min(index, #state.wins)
    if valid_win(state.wins[target]) then
        vim.api.nvim_set_current_win(state.wins[target])
        start_insert()
    end
end

function M.remove_current()
    if not state.open or #state.terms == 0 then
        return
    end

    local index

    if state.zoomed_index then
        index = state.zoomed_index
    else
        index = get_focused_overlay_index()
    end

    M.remove(index)
end

function M.focus(index)
    if not state.open then
        M.open()
        return
    end

    if state.zoomed_index then
        if index == state.zoomed_index then
            set_focus(1)
        end
        return
    end

    set_focus(index)
end

function M.toggle_zoom()
    if not state.open or #state.terms == 0 then
        M.open()
        return
    end

    if state.zoomed_index then
        local previous = state.zoomed_index
        state.zoomed_index = nil
        M.render()
        set_focus(previous)
        return
    end

    local index = get_focused_overlay_index()
    state.zoomed_index = index
    state.last_focused_index = index
    M.render()
    set_focus(1)
end

function M.resize()
    if state.open then
        M.render()
        if state.zoomed_index then
            set_focus(1)
        else
            set_focus(math.min(state.last_focused_index, #state.wins))
        end
    end
end

return M
