-- TODO: Add interesting configuration function in here.
-- Basic keymap here.
vim.api.nvim_create_user_command("W", function() vim.cmd("write<bang>") end, {})
vim.api.nvim_create_user_command("WQ", function() vim.cmd("wqall<bang>") end, {})
vim.api.nvim_create_user_command("Wq", function() vim.cmd("wqall<bang>") end, {})
vim.api.nvim_create_user_command("Q", function() vim.cmd("qall<bang>") end, {})

-- Surround function.
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

-- copyPath function.
local function copyPath()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end
vim.api.nvim_create_user_command("Cppath", copyPath, {})
vim.api.nvim_create_user_command("CPAT", copyPath, {})
vim.api.nvim_create_user_command("Cpat", copyPath, {})

vim.keymap.set({'n','i'},";cpat",function() copyPath() end,{noremap = true, desc = "Comment the line in Insert Mode" })
-- vim.keymap.set('c',"cpat",function() copyPath() end,{noremap = true, desc = "Comment the line in Insert Mode" })

return {
    
}
