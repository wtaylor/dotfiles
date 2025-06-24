-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Start server when cwd contains godot project
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("vvim", { clear = true }),
  callback = function(event)
    if vim.fs.dirname(vim.fs.find({ "project.godot" }, { limit = 10 })[1]) ~= nil then
      vim.api.nvim_command('echo serverstart("/tmp/nvim-godot.pipe")')
    end
  end,
})
