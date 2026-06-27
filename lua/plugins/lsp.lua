-- Camada de linguagem (LSP) usando a API nativa do Neovim 0.11+
-- (vim.lsp.config / vim.lsp.enable). O easy-dotnet cuida do Roslyn (C#) por conta propria.
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- Capabilities do blink.cmp aplicadas a todos os servidores
      local caps = vim.lsp.protocol.make_client_capabilities()
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        caps = blink.get_lsp_capabilities(caps)
      end
      vim.lsp.config("*", { capabilities = caps })

      -- Customizacoes por servidor (mescladas com o config base do nvim-lspconfig)
      vim.lsp.config("vtsls", {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
            },
          },
        },
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = { checkThirdParty = false },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
          },
        },
      })

      -- Instala + habilita automaticamente (mason-lspconfig 2.x chama vim.lsp.enable)
      require("mason-lspconfig").setup({
        ensure_installed = {
          "vtsls",
          "eslint",
          "tailwindcss",
          "lua_ls",
        },
      })

      -- Servidores instalados globalmente via npm (vscode-langservers-extracted) e
      -- ja presentes no PATH: habilitados manualmente (uteis para Razor/markup).
      vim.lsp.enable({ "html", "cssls", "jsonls" })

      -- Keymaps ativados ao anexar um LSP ao buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, fn, desc, mode)
            vim.keymap.set(mode or "n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          local tb = require("telescope.builtin")
          map("gd", tb.lsp_definitions, "Ir para definicao")
          map("gr", tb.lsp_references, "Referencias")
          map("gI", tb.lsp_implementations, "Implementacoes")
          map("gD", vim.lsp.buf.declaration, "Declaracao")
          map("<leader>D", tb.lsp_type_definitions, "Definicao de tipo")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>rn", vim.lsp.buf.rename, "Renomear simbolo")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "v" })
          map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Formatar (LSP)")
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = { border = "rounded", source = true },
      })
    end,
  },
}
