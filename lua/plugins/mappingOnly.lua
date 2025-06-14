-- INFO: mapping disable for some unwanted effects

-- INFO: Keymapping and keybinding only files.
-- vim.api.nvim_set_keymap("i", "qq", "<Esc>", { noremap = true, silent = true, desc = "Escape." })
vim.api.nvim_set_keymap("v", "vv", "$", { noremap = true, silent = true, desc = "Escape and Visual line." })

-- Navigation easy
vim.api.nvim_set_keymap("n", "GG", "Gzz", { noremap = true, silent = true, desc = "Center Final line." })

-- INFO: Editing abilities, mostly alias the `ci*` bracket things.
-- And `yi*`, `vi*` as well?
vim.keymap.set({ "i" }, "<C-Space>", "<C-n>", { silent = true, desc = "Edit: change in angle bracket." })

vim.keymap.set(
  { "n", "i" },
  "ci,",
  "<Esc>ci<",
  { noremap = true, silent = true, desc = "Edit: change in angle bracket." }
)
vim.keymap.set(
  { "n", "i" },
  "yi,",
  "<Esc>yi<",
  { noremap = true, silent = true, desc = "Edit: yank in angle bracket." }
)

vim.keymap.set(
  { "n", "i" },
  "ci9",
  "<Esc>ci(",
  { noremap = true, silent = true, desc = "Edit: change in parentheses." }
)
vim.keymap.set({ "n", "i" }, "yi9", "<Esc>yi(", { noremap = true, silent = true, desc = "Edit: yank in parentheses." })

vim.keymap.set(
  { "n", "i" },
  "ci;",
  '<Esc>ci"',
  { noremap = true, silent = true, desc = "Edit: change in parentheses." }
)

vim.keymap.set({ "n", "i" }, "yi;", '<Esc>yi"', { noremap = true, silent = true, desc = "Edit: yank in parentheses." })

-- INFO: Terminal navigation keymode.
vim.api.nvim_set_keymap(
  "t",
  "qqq",
  "<C-\\><C-n>",
  { noremap = true, silent = true, desc = "Normal mode from Terminal mode" }
)
vim.api.nvim_set_keymap(
  "t",
  "qqi",
  "<Esc>i",
  { noremap = true, silent = true, desc = "Escape and insert in Terminal mode" }
)
vim.api.nvim_set_keymap(
  "t",
  "qqa",
  "<Esc>i",
  { noremap = true, silent = true, desc = "Escape and insert in Terminal mode" }
)
vim.api.nvim_set_keymap(
  "t",
  "qqa",
  "<Esc>i",
  { noremap = true, silent = true, desc = "Escape and insert in Terminal mode" }
)

if vim.fn.has "gui_running" then
  vim.keymap.set("c", "<M-p>", "<C-r>+", { noremap = true, silent = true, desc = "Paste in Command Line" })
  vim.keymap.set("c", "<C-v>", "<C-r>+", { noremap = true, silent = true, desc = "Paste in Command Line" })
  vim.keymap.set(
    { "c", "n", "i" },
    "<S-Insert>",
    "<C-r>+",
    { noremap = true, silent = true, desc = "Write and Quit Insert Mode" }
  )
else
  vim.keymap.set("c", "<M-p>", "<C-r>+", { noremap = true, silent = true, desc = "Paste in Command Line" })
end
--Plugin related mapping.
--Heavily related to plugins and astronvim core.
vim.keymap.set({ "n", "i" }, ";q", "<cmd>quitall!<CR>", { noremap = true, silent = true, desc = "Quit" })

-- LuaFormatter off
local function saveOnlySession()
  local session_name = require("resession").get_current()
  if session_name ~= nil then
    -- vim.notify(session_name, vim.log.levels.INFO)
    require("resession").save(session_name)
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cmd>wq!<CR>", true, true, true), "in", true)
end
vim.keymap.set(
  { "n", "i" },
  ";wq",
  function() saveOnlySession() end,
  { noremap = true, silent = true, desc = "Write and Quit Insert Mode" }
)
-- LuaFormatter on

vim.keymap.set( { "n", "i" }, "lwq", function() saveOnlySession() end, { noremap = false, silent = true, desc = "Alias to ;wq" })
vim.keymap.set( { "n", "i" }, "lq", function()   
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cmd>q!<CR>", true, true, true), "in", true)
end, { noremap = false, silent = true, desc = "Alias to ;wq" })

vim.keymap.set(
  { "n", "i" },
  ";gw",
  "<cmd>Savess<cr><cmd>wall!<CR><esc><cmd>ToggleTerm direction=float<cr>git wipp<cr>",
  { noremap = true, silent = true, desc = "Write and git Insert Mode" }
)

vim.keymap.set(
  { "n", "i" },
  ";wg",
  "<cmd>Savess<cr><cmd>wall!<CR><esc><cmd>ToggleTerm direction=float<cr>git cif<cr>",
  { noremap = true, silent = true, desc = "Write and git Insert Mode" }
)

vim.keymap.set(
  { "n", "i" },
  ";wr",
  "<cmd>wall!<CR><esc><cmd>ToggleTerm direction=float<cr>git rap<cr>",
  { noremap = true, silent = true, desc = "Write and git rap." }
)

vim.keymap.set(
  { "n", "i" },
  ";wt",
  "<esc><cmd>ToggleTerm direction=float<cr><cmd>wall<CR>",
  { noremap = true, silent = true, desc = "Write and Term Insert Mode" }
)

vim.keymap.set(
  { "n", "i" },
  ";ws",
  "<cmd>wall!<CR><cmd>Savess<cr>",
  { noremap = true, silent = true, desc = "Write and Save session" }
)

vim.keymap.set(
  { "n", "i" },
  ";wS",
  "<cmd>wall!<CR>:Savess",
  { noremap = true, silent = true, desc = "Prompt to Save." }
)

-- vim.keymap.set({ "n", "i" }, ";u", "<C-o>u", { noremap = true, silent = true, desc = "Undo Insert Mode" })
vim.keymap.set({ "n", "i" }, ";r", "<C-o><C-r>", { noremap = true, silent = true, desc = "Redo Insert Mode" })
if (vim.fn.has "win32") or (vim.fn.has "macunix") then
  vim.keymap.set(
    { "n", "i" },
    ";lg",
    "<cmd>wall!<CR><esc><cmd>ToggleTerm<cr>:vl g<cr><cmd>ToggleTerm<cr>", -- <cmd>colorscheme default<cr>",
    { noremap = true, silent = true, desc = "Launch GUI(Neovide)" }
  )
else
  vim.keymap.set(
    { "n", "i" },
    ";lg",
    "<cmd>wall!<CR><esc><cmd>ToggleTerm<cr>are you sure you have the GUI?<cr>",
    { noremap = true, silent = true, desc = "Launch GUI(Neovide) but Linux may not have the GUI" }
  )
end

-- INFO:: for some very vanilla operator function.
local function moveAndOpen(opts)
  -- INFO: open the next markdown links.
  if opts == "Back" then
    vim.cmd [[ normal F]w ]]
  else
    vim.cmd [[ normal f]w ]]
  end
  vim.ui.open(vim.fn.expand "<cfile>")
end
vim.api.nvim_create_user_command("GX", function() moveAndOpen "Back" end, { desc = "backward open liks." })
vim.api.nvim_create_user_command("Gx", function() moveAndOpen "Back" end, { desc = "backward open liks." })

vim.keymap.set(
  { "n", "i" },
  ";X",
  function() moveAndOpen "Back" end,
  { desc = "Open Scheme Link at the end of line.", noremap = false }
)
vim.keymap.set(
  { "n", "i" },
  "♂",
  function() moveAndOpen "Back" end,
  { desc = "Open Scheme Link at the end of line.", noremap = false }
)
vim.keymap.set(
  { "n", "i" },
  "<A-CR>",
  function() moveAndOpen "Back" end,
  { desc = "Open Scheme Link at the end of line.", noremap = false }
)
vim.keymap.set(
  { "n", "i" },
  "<cs-CR>",
  function() moveAndOpen "Back" end,
  { desc = "Open Scheme Link at the end of line.", noremap = false }
)
vim.keymap.set(
  { "n", "i" },
  ";x",
  function() moveAndOpen() end,
  { desc = "Open Scheme Link at the end of line.", noremap = false }
)
vim.keymap.set(
  { "i" },
  "gxx",
  function() moveAndOpen() end,
  { desc = "Open Scheme Link at the end of line.", noremap = false }
)
vim.keymap.set(
  { "n", "i" },
  "<C-cr>",
  function() moveAndOpen() end,
  { desc = "Open Scheme Link at the end of line.", noremap = false }
)

vim.keymap.set(
  { "n", "i" },
  ";/",
  function() require("Comment.api").toggle.linewise.count(vim.v.count1) end,
  { noremap = true, desc = "Comment the line in Insert Mode" }
)

vim.keymap.set({ "n", "i" }, ";tt", "<esc><cmd>ToggleTerm<cr>lsd<cr>", { noremap = true, desc = "Simply ToggleTerm" })

vim.keymap.set({ "n", "i" }, ";bc", "<esc><cmd>bd<cr>", { noremap = true, desc = "buffer deleted" })
vim.keymap.set({ "n", "i" }, ";bd", "<esc><cmd>bd<cr>", { noremap = true, desc = "buffer deleted" })

vim.keymap.set(
  { "n", "i" },
  ";jj",
  "<esc><cmd>ToggleTerm<cr>j<space>",
  { noremap = true, desc = "Journal (ready) in ToggleTerm" }
)

vim.keymap.set(
  { "n", "i" },
  ";ee",
  "<esc><cmd>ToggleTerm<cr>:e e<cr>",
  { noremap = true, desc = "Espanso in ToggleTerm " }
)
-- Pane vanilla
-- WARN: HACKY way to do it, also in old Vim API... Need to rewrite some day,
-- but not that urgent though.
local function quitWindow() vim.cmd["quit"]() end
local function evenWindow()
  -- One small behaviour here it I'm not sure if this work globally
  -- or just work in an area of splitted panes instead.
  vim.cmd["vsplit"]()
  vim.cmd["quit"]()
  vim.cmd["split"]()
  vim.cmd["quit"]()
end
-- See! Emacs key binding.
vim.keymap.set(
  { "n" },
  "<c-w><c-q>",
  function() quitWindow() end,
  { noremap = true, desc = "nvim-window: Jump to window" }
)
vim.keymap.set(
  { "n" },
  "<c-w><c-e>",
  function() evenWindow() end,
  { noremap = true, desc = "nvim-window: Jump to window" }
)
vim.keymap.set({ "n", "v" }, "<c-w><c-=>", "<esc><C-w>=", { noremap = true, desc = "Even panes." })

-- INFO: Toggling UI/UX functions.
vim.keymap.set(
  { "n", "i" },
  ";ud",
  function() require("astrocore.toggles").diagnostics() end,
  { desc = "Toggle diagnostics" }
)
vim.keymap.set({ "n", "i" }, ";us", function() require("astrocore.toggles").spell() end, { desc = "Toggle spellcheck" })
vim.keymap.set({ "n", "i" }, ";ut", function() require("astrocore.toggles").tabline() end, { desc = "Toggle tabline" })
vim.keymap.set(
  { "n", "i" },
  ";ul",
  function() require("astrocore.toggles").statusline() end,
  { desc = "Toggle statusline" }
)

vim.keymap.set(
  { "n", "i" },
  ";un",
  function() require("astrocore.toggles").notifications() end,
  { desc = "Toggle notifications" }
)

local kopts = { noremap = true, silent = true, desc = "escape search mode for hlslens" }
-- nvim-hlslens to stop search.
vim.api.nvim_set_keymap("n", ";n", "<Cmd>noh<CR>", kopts)
vim.api.nvim_set_keymap("n", ";<Esc>", "<Cmd>noh<CR>", kopts)

-- INFO: just open vscode instead.
local function open_in_vscode()
  local file_path = vim.api.nvim_buf_get_name(0)
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  if file_path ~= "" then
    vim.fn.system("code --goto " .. file_path .. ":" .. line .. ":" .. col) -- Open in VS Code
  else
    print "No file to open in VS Code!"
  end
end
-- vim.keymap.set({ "n","i" }, ";vs", open_in_vscode, { desc = "Open in VS Code" })
vim.keymap.set({ "n"}, "<C-v>","<Esc>P", { desc = "pure paste." })
vim.keymap.set({ "i"}, "<C-v>","<Esc>pi", { desc = "pure paste." })
-- For normal and visual mode deletion without yanking to the clipboard:
vim.keymap.set({ "n", "x" }, "d", '"_d')

return {}
