-- TODO: Add interesting configuration function in here.
function Surround(w_or_W)
    local open_char = vim.fn.input("Surround with: ")
    local closed_char = nil
    if open_char == "(" then closed_char = ")" end
    if open_char == "[" then closed_char = "]" end
    if open_char == "{" then closed_char = "}" end
    if open_char == "<" then closed_char = ">" end
    if open_char == "'" then closed_char = "'" end
    if open_char == '"' then closed_char = '"' end
    if open_char == "`" then closed_char = "`" end
    if open_char == "/" then closed_char = "/" end
    if open_char == "|" then closed_char = "|" end

    if w_or_W == "w" then
        vim.cmd("normal! ciw" .. open_char)
    elseif w_or_W == "W" then
        vim.cmd([[normal! ciW]] .. open_char)
    end
    vim.cmd("normal! p")
    vim.cmd("normal! a" .. closed_char)
    vim.cmd("normal! a")
end

vim.api.nvim_set_keymap("n", "<leader>ww", ":lua Surround('w')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wW", ":lua Surround('W')<CR>", { noremap = true, silent = true })
