return {
  "mrjones2014/smart-splits.nvim",
  commit = "c4afaf23141651845e6e1966d936d79ff8939e4d",
  lazy = false,
  opts = {
    at_edge = "stop",
    float_win_behavior = "previous",
    multiplexer_integration = "wezterm",
    ignored_filetypes = {},
  },
  keys = {
    {
      "<A-h>",
      function()
        require("smart-splits").resize_left()
      end,
      desc = "Resize Left",
    },
    {
      "<A-j>",
      function()
        require("smart-splits").resize_down()
      end,
      desc = "Resize Down",
    },
    {
      "<A-k>",
      function()
        require("smart-splits").resize_up()
      end,
      desc = "Resize Up",
    },
    {
      "<A-l>",
      function()
        require("smart-splits").resize_right()
      end,
      desc = "Resize Right",
    },
    {
      "<C-h>",
      function()
        require("smart-splits").move_cursor_left()
      end,
      desc = "Focus Pane Left",
    },
    {
      "<C-j>",
      function()
        require("smart-splits").move_cursor_down()
      end,
      desc = "Focus Pane Down",
    },
    {
      "<C-k>",
      function()
        require("smart-splits").move_cursor_up()
      end,
      desc = "Focus Pane Up",
    },
    {
      "<C-l>",
      function()
        require("smart-splits").move_cursor_right()
      end,
      desc = "Focus Pane Right",
    },
  },
}
