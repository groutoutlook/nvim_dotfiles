-- Since it keep complaining about termguicolors.
vim.cmd [[
set termguicolors
]]
return {
  "rcarriga/nvim-notify",
  require("notify").setup {
    opts = {
      background_colour = "NotifyBackground",
      fps = 30,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade_in_slide_out",
      time_formats = {
        notification = "%T",
        notification_history = "%FT%T",
      },
      timeout = 50,
      top_down = false,
    },
  },
}
