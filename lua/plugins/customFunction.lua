-- TODO: Add interesting configuration function in here.
-- Basic keymap here.
-- vim.api.nvim_create_user_command("W", function() vim.cmd "write<bang>" end, {})
-- vim.api.nvim_create_user_command("WQ", function() vim.cmd "wqall<bang>" end, {})
-- vim.api.nvim_create_user_command("Wq", function() vim.cmd "wqall<bang>" end, {})
-- vim.api.nvim_create_user_command("Q", function() vim.cmd "qall" end, {})

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
function Surround(w_or_W)
  local open_char = vim.fn.input "Surround with: "
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
  local current_mode = vim.fn.mode()
  if closed_char ~= nil then
    if current_mode == "n" then
      if w_or_W == "w" then
        vim.cmd("normal! ciw" .. open_char)
      elseif w_or_W == "W" then
        vim.cmd([[normal! ciW]] .. open_char)
      end
    elseif current_mode == "v" then
      if w_or_W == "w" then
        vim.cmd("normal! c" .. open_char)
      elseif w_or_W == "W" then
        vim.cmd([[normal! c]] .. open_char)
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
vim.keymap.set({ "n", "v" }, ";ww", function() Surround "w" end)
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

vim.keymap.set("n", "<CR>", '@="m`o<C-V><Esc>``"<CR>')
vim.keymap.set("n", "<S-CR>", '@="m`O<C-V><Esc>``"<CR>')
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
return {}
