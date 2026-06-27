-- Stack React/TypeScript: debug via js-debug-adapter (pwa-node / pwa-chrome).
-- O LSP (vtsls, eslint, tailwindcss) e instalado/habilitado em lsp.lua.
return {
  -- Garante o adapter de debug JS/TS instalado via Mason (nao e um LSP)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
    event = "VeryLazy",
    opts = {
      ensure_installed = { "js-debug-adapter" },
      run_on_start = true,
    },
  },

  -- Wiring do nvim-dap para Node e Chrome
  {
    "mfussenegger/nvim-dap",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      local dap = require("dap")

      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter"

      for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
        dap.adapters[adapter] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = mason_bin,
            args = { "${port}" },
          },
        }
      end

      -- Aliases para compatibilidade com configs estilo VS Code (type = "node"/"chrome")
      dap.adapters["node"] = dap.adapters["pwa-node"]
      dap.adapters["chrome"] = dap.adapters["pwa-chrome"]

      -- No WSL o Chrome roda no lado Windows; apontamos para o executavel do Windows
      local windows_chrome = "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
      local chrome_exec = vim.fn.filereadable(windows_chrome) == 1 and windows_chrome or nil

      local node_config = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch arquivo atual (Node)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach a processo Node",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
      }

      local chrome_config = {
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch React (Chrome, :5173 Vite)",
          url = "http://localhost:5173",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          runtimeExecutable = chrome_exec,
          -- ATENCAO (WSL): o Chrome roda no Windows e o debugger no WSL. Se o
          -- breakpoint nao "colar", confira o webRoot e o mapeamento localhost.
        },
      }

      for _, ft in ipairs({ "javascript", "typescript" }) do
        dap.configurations[ft] = node_config
      end
      for _, ft in ipairs({ "javascriptreact", "typescriptreact" }) do
        dap.configurations[ft] = chrome_config
      end
    end,
  },
}
