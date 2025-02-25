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
    opts = function()
      local dap = require("dap")

      --- Converts a callback-based function to a coroutine function.
      ---
      ---@param f function The function to convert.
      ---                  The callback needs to be its first argument.
      ---@return function A fire-and-forget coroutine function.
      ---                 Accepts the same arguments as f without the callback.
      ---                 Returns what f has passed to the callback.
      local cb_to_co = function(f)
        local f_co = function(...)
          local this = coroutine.running()
          assert(this ~= nil, "The result of cb_to_co must be called within a coroutine.")

          local f_status = "running"
          local f_ret = nil
          -- f needs to have the callback as its first argument, because varargs
          -- passing doesn’t work otherwise.
          f(function(ret)
            f_status = "done"
            f_ret = ret
            if coroutine.status(this) == "suspended" then
              -- If we are suspended, then f_co has yielded control after calling f.
              -- Use the caller of this callback to resume computation until the next yield.
              coroutine.resume(this)
            end
          end, ...)
          if f_status == "running" then
            -- If we are here, then `f` must not have called the callback yet, so it
            -- will do so asynchronously.
            -- Yield control and wait for the callback to resume it.
            coroutine.yield()
          end
          return f_ret
        end

        return f_co
      end

      local exec_co = cb_to_co(function(cb, cmd, opts)
        vim.system(cmd, opts, cb)
      end)

      local select_co = cb_to_co(function(cb, items, opts)
        vim.ui.select(items, opts, cb)
      end)

      local select_csproj_co = function()
        local items = vim.fn.globpath(vim.fn.getcwd(), "**/*.csproj", 0, 1)
        local opts = {
          format_item = function(path)
            return vim.fn.fnamemodify(path, ":t")
          end,
        }
        return select_co(items, opts)
      end

      local select_dll_co = function()
        local items = vim.fn.globpath(vim.fn.getcwd(), "**/bin/Debug/**/*.dll", 0, 1)
        local opts = {
          format_item = function(path)
            return vim.fn.fnamemodify(path, ":t")
          end,
        }
        return select_co(items, opts)
      end

      local dotnet_build_project_co = function(project)
        local cmd = { "dotnet", "build", "-c", "Debug", project }
        print("\nBuilding project " .. project .. "...")
        local exec_result = exec_co(cmd, {})
        if exec_result.signal == 0 then
          print("\nBuild: ✔️\n\n" .. exec_result.stdout)
        else
          print("\nBuild: ❌\n\n" .. exec_result.stderr)
        end
      end

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
              ---@diagnostic disable-next-line: redundant-parameter
              program = function()
                return coroutine.create(function(dap_run_co)
                  if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
                    local project = select_csproj_co()
                    dotnet_build_project_co(project)
                  end
                  local dll = select_dll_co()
                  coroutine.resume(dap_run_co, dll)
                end)
              end,
              cwd = "${workspaceFolder}",
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
