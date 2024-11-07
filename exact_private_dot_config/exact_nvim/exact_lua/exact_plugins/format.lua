return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        yaml = { "yamlfmt" },
      },
    },
  },
  {
    "zapling/mason-conform.nvim",
    dependencies = { "mason.nvim", "stevearc/conform.nvim" },
  },
}
