return {
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup({ transparent = true })
      vim.cmd.colorscheme("nord")
    end,
    install = {
      colorscheme = { "nord" },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}
