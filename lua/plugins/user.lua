-- HACK: Emacs navigation., based on `emacsinsert.nvim`
local emacsinsert = require "emacsinsert"
-- vim.keymap.set("!", "<C-k>", emacsinsert.kill_line)
vim.keymap.set("!", "<C-u>", emacsinsert.backward_kill_line)
vim.keymap.set("!", "<M-d>", emacsinsert.kill_word)
vim.keymap.set("!", "<M-w>", emacsinsert.kill_word)
vim.keymap.set("!", "<M-BS>", emacsinsert.backward_kill_word)
-- vim.keymap.set("!", "<C-w>", emacsinsert.unix_word_rubout)
vim.keymap.set("!", "<C-d>", "<Delete>") -- delete-char
vim.keymap.set("!", "<C-h>", "<BS>") -- backward-delete-char
vim.keymap.set("!", "<C-a>", emacsinsert.beginning_of_line)
vim.keymap.set("!", "<C-e>", emacsinsert.end_of_line)
vim.keymap.set("!", "<M-f>", emacsinsert.forward_word)
vim.keymap.set("!", "<M-b>", emacsinsert.backward_word)
vim.keymap.set("!", "<C-f>", "<Right>") -- forward-char
vim.keymap.set("!", "<C-b>", "<Left>") -- backward-char
-- vim.keymap.set("!", "<C-n>", "<Down>") -- next-line
-- vim.keymap.set("!", "<C-p>", "<Up>") -- previous-line

return {
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
