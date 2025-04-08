-- TODO: Add interesting configuration function in here.

-- copyPath function.
local function copyPath()
  local path = vim.fn.expand "%:p"
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end
vim.api.nvim_create_user_command("Cppath", copyPath, {})
vim.api.nvim_create_user_command("CPAT", copyPath, {})
vim.api.nvim_create_user_command("Cpat", copyPath, {})

vim.keymap.set(
  { "n", "i" },
  ";cpat",
  function() copyPath() end,
  { noremap = true, desc = "Comment the line in Insert Mode" }
)
vim.cmd [[
  "" From https://stackoverflow.com/a/6171215/340947
  " Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
  function! EscapeString (string)
    let string=a:string
    " Escape regex characters
    let string = escape(string, '^$.*\/~[]')
    " Escape the line endings
    let string = substitute(string, '\n', '\\n', 'g')
    return string
  endfunction

  function! GetVisual() range
    " Save the current register and clipboard
    let reg_save = getreg('"')
    let regtype_save = getregtype('"')
    let cb_save = &clipboard
    set clipboard&
    " Put the current visual selection in the " register
    normal! ""gvy
    let selection = getreg('"')
    " Put the saved registers and clipboards back
    call setreg('"', reg_save, regtype_save)
    let &clipboard = cb_save
    "Escape any special characters in the selection
    let escaped_selection = EscapeString(selection)
    return escaped_selection
  endfunction
  " vnoremap <c-r> <Esc>:%s/<c-r>=GetVisual()<cr>//g<left><left>
]]
-- as what I typically do to replace.
vim.api.nvim_set_keymap(
  "v",
  "<C-h>",
  "<Esc>:%s/<c-r>=GetVisual()<cr>//g<left><left>",
  { noremap = true, silent = true, desc = "Replace the selected text" }
)
vim.api.nvim_set_keymap(
  "v",
  "<C-r>",
  "<Esc>:%s/<c-r>=GetVisual()<cr>//g<left><left>",
  { noremap = true, silent = true, desc = "Replace the selected text" }
)

-- HACK: kludge to escape terminal mode and paste text in register * in(which we just copied)
vim.keymap.set("t", "<M-r>", "<C-\\><C-N>pi", { noremap = true, silent = true })
vim.keymap.set("t", "<M-p>", "<C-\\><C-N>pi", { noremap = true, silent = true })
-- INFO: capture word to find just like `#` in normal mode
-- But this is for custom search engine. For example, looking at Google..
-- Or docs, either offline or online. Even append it in some kind of URI builder.
function expandSearchWord(opts, engine)
  local currentWord = opts or vim.fn.expand "<cWORD>"
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- HACK: or you could call lua directly, not through excommand...
  -- Also nvim_replace_termcodes() could also help to reduce feedkey with present mapping.
  -- vim.api.nvim_feedkeys("gg " .. currentWord .. " \X0D", "t", false)
  -- vim.notify(currentWord .. "," .. row .. "," .. col)
  vim.ui.open("https://duckduckgo.com/?q=" .. currentWord)
end
function expandSearchObsidian(opts, engine)
  local currentWord = opts or vim.fn.expand "<cWORD>"
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.ui.open("obsidian://omnisearch?query=" .. currentWord)
end

vim.keymap.set(
  { "n", "i" },
  ";gg",
  function() expandSearchWord() end,
  { noremap = true, desc = "Google word under cursors" }
)
vim.keymap.set(
  { "n", "i" },
  ";oo",
  function() expandSearchObsidian() end,
  { noremap = true, desc = "Obsidian (ready) in ToggleTerm " }
)

local function copy_visual()
  local vstart = vim.fn.getpos "'<"

  local vend = vim.fn.getpos "'>"

  local line_start = vstart[2]

  local line_end = vend[2]
  local lines = vim.fn.getline(line_start, line_end)

  if type(lines) == "table" then
    return table.concat(lines, "\n")
  else
    return lines -- In case lines is not a table, return it directly
  end
end
vim.keymap.set({ "v" }, ";gg", function()
  -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-u>", true, false, true), "n", false)
  local GetString = copy_visual()
  expandSearchWord(GetString)
end, { noremap = true, desc = "Google in Visual Mode" })

return {}
