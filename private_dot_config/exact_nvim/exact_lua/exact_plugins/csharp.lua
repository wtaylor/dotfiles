return {
  {
    "seblj/roslyn.nvim",
    ft = "cs",
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c_sharp" } },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>dE",
        function()
          require("dap").set_exception_breakpoints()
        end,
        desc = "Set Exception Breakpoints",
      },
    },
    opts = function()
      local dap = require("dap")

      local select_dll = vim.schedule_wrap(function(cb)
        local items = vim.fn.globpath(vim.fn.getcwd(), "**/bin/Debug/**/*.dll", 0, 1)
        local opts = {
          format_item = function(path)
            return vim.fn.fnamemodify(path, ":t")
          end,
        }
        vim.ui.select(items, opts, function(selection)
          if selection ~= nil then
            cb(selection)
          end
        end)
      end)

      if not dap.adapters["netcoredbg"] then
        require("dap").adapters["netcoredbg"] = {
          type = "executable",
          command = vim.fn.exepath("netcoredbg"),
          args = { "--interpreter=vscode" },
          options = {
            detached = false,
          },
        }
      end
      for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = "netcoredbg",
              name = "Launch file",
              request = "launch",
              cwd = "${fileDirname}",
              program = function()
                return coroutine.create(function(dap_run_co)
                  vim.ui.select({ "Yes", "No" }, { prompt = "Rebuild Project?" }, function(choice)
                    if choice == "Yes" then
                      local projects = vim.fn.globpath(vim.fn.getcwd(), "**/*.csproj", 0, 1)
                      local project_select_opts = {
                        format_item = function(path)
                          return vim.fn.fnamemodify(path, ":t")
                        end,
                      }
                      vim.ui.select(projects, project_select_opts, function(project)
                        local cmd = { "dotnet", "build", "-c", "Debug", project }
                        print("\nBuilding project " .. project .. "...")
                        vim.system(cmd, {}, function(build_result)
                          if build_result.signal == 0 then
                            print("\nBuild: ✔️\n\n" .. build_result.stdout)
                            select_dll(function(dll)
                              coroutine.resume(dap_run_co, dll)
                            end)
                          else
                            print("\nBuild: ❌\n\n" .. build_result.stderr)
                          end
                        end)
                      end)
                    else
                      select_dll(function(dll)
                        coroutine.resume(dap_run_co, dll)
                      end)
                    end
                  end)
                end)
              end,
            },
          }
        end
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "Issafalcon/neotest-dotnet",
    },
    opts = {
      adapters = {
        ["neotest-dotnet"] = {
          -- Here we can set options for neotest-dotnet
        },
      },
    },
  },
}
