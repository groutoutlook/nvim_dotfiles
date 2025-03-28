-- TODO: Add interesting configuration function in here.

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

-- Get selected text
-- function get_visual_selection()
--   local s_start = vim.fn.getpos "'<"
--   local s_end = vim.fn.getpos "'>"
--   local n_lines = math.abs(s_end[2] - s_start[2]) + 1
--   local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
--   lines[1] = string.sub(lines[1], s_start[3], -1)
--   if n_lines == 1 then
--     lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
--   else
--     lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
--   end
--   return table.concat(lines, "\n")
-- end

-- HACK: kludge to escape terminal mode and paste text in register * in(which we just copied)
-- It might sound bad on termux, which has a really slow clipboard though.
vim.keymap.set("t", "<M-r>", "<C-\\><C-N>pi", { noremap = true, silent = true })
vim.keymap.set("t", "<M-p>", "<C-\\><C-N>pi", { noremap = true, silent = true })
-- INFO: capture word to find just like `#` in normal mode
-- But this is for custom search engine. For example, looking at Google..
-- Or docs, either offline or online. Even append it in some kind of URI builder.
function expandSearchWord(opts, engine)
  local currentWord = opts or vim.fn.expand "<cWORD>"
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- vim.cmd "ToggleTerm"
  -- HACK: or you could call lua directly, not through excommand...
  -- Also nvim_replace_termcodes() could also help to reduce feedkey with present mapping.
  -- vim.api.nvim_feedkeys("gg " .. currentWord .. " \x0D", "t", false)
  -- vim.notify(currentWord .. "," .. row .. "," .. col)
  vim.ui.open("https://duckduckgo.com/?q=" .. currentWord)
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
  function() expandSearchWord() end,
  { noremap = true, desc = "Obsidian (ready) in ToggleTerm " }
)

local function copy_visual()
  -- vim.wait(500, function()
  --   vim.api.nvim_feedkeys("y", "n", false)
  --   -- return false
  -- end, 100)
  vim.api.nvim_feedkeys("y", "in", true)
  local copied = vim.fn.getreg "+"
  return copied
end
vim.keymap.set({ "v" }, ";gg", function()
  -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-u>", true, false, true), "n", false)
  local GetString = copy_visual()
  expandSearchWord(GetString)
end, { noremap = true, desc = "Google (ready) in ToggleTerm " })

-- INFO: Additional step after adding hyperlink?
-- Add newline, tab, "brief" or "tldr" string there. Maybe separate it in a new function as a way of providing summary.
function addBriefText(opts)
  -- INFO: Guard input here.
  local inputWord = opts or nil
  if inputWord == nil then
    vim.notify("No proper input..", vim.log.levels.ERROR)
    return
  end

  -- INFO: Process output.
  local outputHead = "- " .. inputWord .. ": "
  local outputContent = "\n"
  vim.api.nvim_feedkeys(outputHead .. outputContent, "t", false)
end

-- INFO: Insert hyperlink function in neovim, markdown to be specific
function Hyperlink(opts)
  -- local extra_args = opts.args
  local registerString = vim.fn.getreg "+"
  local link_content = registerString
  local current_mode = vim.fn.mode()
  -- INFO: get cursor here.
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  if (current_mode == "i") or (current_mode == "n") then
    local bulletPoint = { "Recap", "Root", "Resolution", "Reason", "Related" }

    if registerString:sub(1, 1) ~= "[" then
      -- INFO: Check if it's an URI.
      -- Although in the future we may need to expand this behaviour.
      local link_pattern = "^http"
      local link_title = vim.fn.input "Link Brief?: "

      if string.match(registerString, link_pattern) then
        link_content = registerString
      else
        local crop_register = string.sub(link_content, -10)
        local warningMessage = "'" .. crop_register .. "'" .. "is not a link"
        -- vim.notify(warningMessage, vim.log.levels.ERROR)
        link_content = vim.fn.input "Link content: " or nil
      end

      -- INFO: looping through bullet points.

      vim.cmd "startinsert"
      if link_title:sub(1, 1) == "[" then
        vim.api.nvim_feedkeys("- " .. link_title .. " ", "t", false)
      else
        vim.api.nvim_feedkeys("- [" .. link_title .. "](" .. link_content .. ")", "t", false)
      end
    else
      vim.cmd "startinsert"
      vim.api.nvim_feedkeys("- " .. registerString, "t", false)
      -- vim.notify("Just the original contents.", vim.log.levels.WARN)
    end

    -- HACK: Append bullet points.
    vim.api.nvim_feedkeys("\n\09", "t", false)
    for i = 1, #bulletPoint do
      addBriefText(bulletPoint[i])
    end

    -- INFO: moving here, I dont know why it just cant move
    --
    vim.api.nvim_win_set_cursor(0, { row, col })
    -- vim.notify(row .. " - " .. col)
    -- vim.cmd("normal " .. #bulletPoint .. "k")
    -- vim.cmd "startinsert"
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

-- TODO: add a function which append triggers
-- Improve this function to add more words at the trigger at the initial state
function addEspansoString(opts)
  -- - trigger: "swtich"
  --replace: "switch"
  local wordCase = opts or "strictMatch"
  local triggerString = vim.fn.input "Trigger with: " or ""
  local replaceString = vim.fn.input "Replace with: " or ""
  vim.api.nvim_put({ "  - triggers: [" .. triggerString .. "," }, "l", true, false)
  vim.api.nvim_put({ "    ]" }, "l", true, false)
  vim.api.nvim_put({ '    replace: "' .. replaceString .. '" ' }, "l", true, false)
  -- always true since I type some capitalized text as well.
  vim.api.nvim_put({ "    propagate_case: true" }, "l", true, false)
  -- For some files which already defined some default config though.
  -- HACK: Hard-coding the linevalue. Either passing line value into the vim.cmd, or make it find the trigger: line
  -- Or render all the text backward. Put it all, cursor stay at the same location.
  if wordCase == "strictMatch" then
    vim.api.nvim_put({ "    word: true" }, "l", true, false)
    vim.cmd [[
    normal 4k
    startinsert!
    ]]
  else
    vim.cmd [[
    normal 3k
    startinsert!
    ]]
  end
end

vim.keymap.set({ "n", "i" }, ";ep", function() addEspansoString "allMatch" end, { desc = "paste Wild match snippets" })
vim.keymap.set(
  { "n", "i" },
  ";es",
  function() addEspansoString "strictMatch" end,
  { desc = "paste strict match snippets(extra newline to trigger match)" }
)

return {}
