-- Nucleo de debug compartilhado (.NET e JS/TS reutilizam isto)
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: continuar/iniciar" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: step into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: step out" },
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Debug: breakpoint" },
      {
        "<leader>B",
        function()
          require("dap").set_breakpoint(vim.fn.input("Condicao do breakpoint: "))
        end,
        desc = "Debug: breakpoint condicional",
      },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug: REPL" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Debug: terminar" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: alternar UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup({})

      -- Sinais visuais dos breakpoints
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })

      -- Abrir/fechar a UI automaticamente com a sessao
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },
}
