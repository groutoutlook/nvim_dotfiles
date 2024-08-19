-- HACK: Emacs navigation., based on `readline.nvim`
local readline = require "readline"
-- vim.keymap.set("!", "<C-k>", readline.kill_line)
vim.keymap.set("!", "<C-u>", readline.backward_kill_line)
vim.keymap.set("!", "<M-d>", readline.kill_word)
vim.keymap.set("!", "<M-w>", readline.kill_word)
vim.keymap.set("!", "<M-BS>", readline.backward_kill_word)
-- vim.keymap.set("!", "<C-w>", readline.unix_word_rubout)
vim.keymap.set("!", "<C-d>", "<Delete>") -- delete-char
vim.keymap.set("!", "<C-h>", "<BS>") -- backward-delete-char
vim.keymap.set("!", "<C-a>", readline.beginning_of_line)
vim.keymap.set("!", "<C-e>", readline.end_of_line)
vim.keymap.set("!", "<M-f>", readline.forward_word)
vim.keymap.set("!", "<M-b>", readline.backward_word)
vim.keymap.set("!", "<C-f>", "<Right>") -- forward-char
vim.keymap.set("!", "<C-b>", "<Left>") -- backward-char
-- vim.keymap.set("!", "<C-n>", "<Down>") -- next-line
-- vim.keymap.set("!", "<C-p>", "<Up>") -- previous-line
-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
