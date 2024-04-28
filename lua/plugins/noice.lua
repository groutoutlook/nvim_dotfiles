vim.keymap.set("n", "<leader>nl", function() require("noice").cmd "last" end)
vim.keymap.set("n", "<leader>nh", function() require("noice").cmd "history" end)

-- local noice = require "noice"
-- noice.setup {
--   routes = {
--     {
--       view = "notify",
--       filter = { event = "msg_showmode" },
--     },
--  },
-- }
--
-- Comment out the astrocommunity.lua since I think I already setting things up here.
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = function(_, opts)
    local utils = require "astrocore"
    local cmdline_y_pos = 17
    return utils.extend_tbl(opts, {
      views = {
        cmdline_popup = {
          position = {
            row = cmdline_y_pos,
            col = "50%",
          },
          size = {
            width = 80,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = (cmdline_y_pos + 2),
            col = "50%",
          },
          size = {
            width = 70,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = {
          enabled = false,
        },
        hover = {
          enabled = false,
        },
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = utils.is_available "inc-rename.nvim", -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    })
  end,
}
