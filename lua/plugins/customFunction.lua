-- TODO: Add interesting configuration function in here.

vim.keymap.set(
  { "n", "i" },
  ";mm",
  function() require("mini.map").toggle() end,
  { noremap = true, silent = true, desc = "Map toggle" }
)
vim.keymap.set(
  { "n", "i" },
  ";mf",
  function() require("mini.map").toggle_focus() end,
  { noremap = true, silent = true, desc = "Map focus" }
)
-- Surround function.
function Surround(w_or_W, char)
  char = char or nil
  local link_title = char or vim.fn.input "Surround with: "
  local closed_char = nil
  --Edge case
  -- FIXME: May need to rewrite this part into something else like a table.
  --
  if link_title == "]" then link_title = "[" end
  if link_title == ")" then link_title = "(" end

  if link_title == "(" then closed_char = ")" end
  if link_title == "[" then closed_char = "]" end
  if link_title == "{" then closed_char = "}" end
  if link_title == "<" then closed_char = ">" end
  if link_title == "'" then closed_char = "'" end
  if link_title == '"' then closed_char = '"' end
  if link_title == "`" then closed_char = "`" end
  if link_title == "/" then closed_char = "/" end
  if link_title == "|" then closed_char = "|" end

  local current_mode = vim.fn.mode()
  if closed_char ~= nil then
    if current_mode == "n" then
      if w_or_W == "w" then
        vim.cmd("normal! ciw" .. link_title)
      elseif w_or_W == "W" then
        vim.cmd([[normal! ciW]] .. link_title)
      end
    elseif current_mode == "v" then
      if w_or_W == "w" then
        vim.cmd("normal! c" .. link_title)
      elseif w_or_W == "W" then
        vim.cmd([[normal! c]] .. link_title)
      end
    end

    vim.cmd "normal! p"
    vim.cmd("normal! a" .. closed_char)
    vim.cmd "normal! a"
  else
    vim.cmd [[write]]
  end
end

vim.keymap.set({ "n", "v" }, "<leader>ww", function() Surround "w" end)
-- vim.keymap.set({ "n", "v" }, "<leader>wW", function() Surround "W" end)
vim.keymap.set({ "n", "v", "i" }, ";ww", function() Surround "w" end)
-- vim.keymap.set({ "n", "v" }, ";wW", function() Surround "W" end)

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
-- vim.keymap.set("n", "<CR>", '@="m`o<C-V><Esc>``"<CR>')
-- vim.keymap.set("n", "<S-CR>", '@="m`O<C-V><Esc>``"<CR>')
-- local function addNewLines(before, count)
--   local line = vim.fn.line "."
--   local start = line + (before and -1 or 0)
--   local lines = {}
--   table.insert(lines, "")
--   for _ = 1, count - 1 do
--     table.insert(lines, "")
--   end
--   local buf = vim.api.nvim_get_current_buf()
--   vim.api.nvim_buf_set_lines(buf, start, start, false, lines)
-- end
--
-- vim.keymap.set("n", "[<cr>", function() addNewLines(true, vim.v.count) end, {})
-- vim.keymap.set("n", "]<cr>", function() addNewLines(false, vim.v.count) end, {})
vim.cmd [[
  "" From https://stackoverflow.com/a/6171215/340947
  " Escape special characters in a string for exact matching.
  " This is useful to copying strings from the file to the search tool
  " Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
  function! EscapeString (string)
    let string=a:string
    " Escape regex characters
    let string = escape(string, '^$.*\/~[]')
    " Escape the line endings
    let string = substitute(string, '\n', '\\n', 'g')
    return string
  endfunction

  " Get the current visual block for search and replaces
  " This function passed the visual block through a string escape function
  " Based on this - https://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
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

-- Get selected text
local function get_visual_selection()
  local s_start = vim.fn.getpos "'<"
  local s_end = vim.fn.getpos "'>"
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, "\n")
end
-- Instead of yanking them, could use the function above to get the text first.
vim.keymap.set(
  { "v" },
  ";oo",
  "y<esc><cmd>ToggleTerm<cr>lsd<cr>:o<space><C-v><cr>",
  { noremap = true, desc = "Obsidian (ready) in ToggleTerm " }
)
-- HACK: kludge to escape terminal mode and paste text in register * in(which we just copied)
-- It might sound bad on termux, which has a really slow clipboard though.
vim.keymap.set("t", "<M-r>", "<C-\\><C-N>pi", { noremap = true, silent = true })
vim.keymap.set(
  { "v" },
  ";gg",
  "y<esc><cmd>ToggleTerm<cr>gg<space><C-\\><C-N>pi<cr>",
  { noremap = true, desc = "Google (ready) in ToggleTerm " }
)

-- INFO: Additional step after adding hyperlink?
-- Add newline, tab, "brief" or "tldr" string there. Maybe separate it in a new function as a way of providing summary.
function addBriefText(opts)
  local BriefHead = "\n\09- Brief:"
  local BriefContent = " "
  vim.api.nvim_feedkeys(BriefHead .. BriefContent, "t", false)
end

-- INFO: Insert hyperlink function in neovim, markdown to be specific
function Hyperlink(opts)
  local extra_args = opts.args
  local link_content = vim.fn.getreg "+"
  local link_pattern = "^http"

  if string.match(link_content, link_pattern) then
    link_content = link_content
  else
    local crop_register = string.sub(link_content, -10)
    local warningMessage = "'" .. crop_register .. "'" .. "is not a link"
    vim.notify(warningMessage, vim.log.levels.ERROR)
    link_content = ""
  end

  local current_mode = vim.fn.mode()
  if (current_mode == "i") or (current_mode == "n") then
    local link_title = vim.fn.input "Link Brief?: "
    vim.cmd "startinsert"
    if link_title == nil then
      vim.api.nvim_feedkeys(" [](" .. link_content .. ")", "t", false)
    else
      vim.api.nvim_feedkeys(" [" .. link_title .. "](" .. link_content .. ")", "t", false)
    end
    addBriefText()
  else
    -- local selected_string = get_visual_selection()
    Surround("w", "[")
    -- vim.api.nvim_feedkeys("lll", "i", false)
    vim.cmd [[
    startinsert
    normal l
    ]]
    vim.api.nvim_feedkeys("(" .. link_content .. ")", "t", false)
  end
end

vim.keymap.set({ "n", "v", "i" }, "<C-k>", function() Hyperlink "reservedArgument" end)

function addEspansoString(opts)
  -- - trigger: "swtich"
  --replace: "switch"
  local wordCase = opts or "strictMatch"
  local triggerString = vim.fn.input "Trigger with: " or ""
  local replaceString = vim.fn.input "Replace with: " or ""
  vim.api.nvim_put({ '  - trigger: "' .. triggerString .. '" ' }, "l", true, false)
  vim.api.nvim_put({ '    replace: "' .. replaceString .. '" ' }, "l", true, false)
  -- always true since I type some capitalized text as well.
  vim.api.nvim_put({ "    propagate_case: true" }, "l", true, false)
  -- For some files which already defined some default config though.
  if wordCase == "strictMatch" then vim.api.nvim_put({ "    word: true" }, "l", true, false) end
end

vim.keymap.set({ "n", "i" }, ";ep", function() addEspansoString "allMatch" end, { desc = "paste Wild match snippets" })
vim.keymap.set(
  { "n", "i" },
  ";es",
  function() addEspansoString "strictMatch" end,
  { desc = "paste strict match snippets(extra newline to trigger match)" }
)

return {}
