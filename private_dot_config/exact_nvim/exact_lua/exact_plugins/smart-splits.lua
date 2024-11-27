return {
  "mrjones2014/smart-splits.nvim",
  keys = function()
    return {
      { "<A-h>", require("smart-splits").resize_left, desc = "resize left" },
      { "<A-j>", require("smart-splits").resize_down, desc = "resize down" },
      { "<A-k>", require("smart-splits").resize_up, desc = "resize up" },
      { "<A-l>", require("smart-splits").resize_right, desc = "resize right" },
      { "<C-h>", require("smart-splits").move_cursor_left, desc = "move cursor left" },
      { "<C-j>", require("smart-splits").move_cursor_down, desc = "move cursor down" },
      { "<C-k>", require("smart-splits").move_cursor_up, desc = "move cursor up" },
      { "<C-l>", require("smart-splits").move_cursor_right, desc = "move cursor right" },
      { "<leader><leader>h", require("smart-splits").swap_buf_left, desc = "swap buffer left" },
      { "<leader><leader>j", require("smart-splits").swap_buf_down, desc = "swap buffer down" },
      { "<leader><leader>k", require("smart-splits").swap_buf_up, desc = "swap buffer up" },
      { "<leader><leader>l", require("smart-splits").swap_buf_right, desc = "swap buffer right" },
    }
  end,
}
