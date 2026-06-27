-- Camada de IA: ponte com o Claude Code CLI (servidor WebSocket + diffs no Neovim)
return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      -- Abre o Claude sempre no raiz do monorepo (por causa do CLAUDE.md / .playbook),
      -- independente de onde o arquivo atual esta.
      terminal = {
        cwd = vim.fn.expand("~/dev/web-projects"),
      },
    },
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeStatus",
      "ClaudeCodeStart",
      "ClaudeCodeStop",
      "ClaudeCodeOpen",
      "ClaudeCodeClose",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
      "ClaudeCodeCloseAllDiffs",
    },
    keys = {
      { "<leader>a", nil, desc = "IA / Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Alternar Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focar Claude" },
      {
        "<C-;>",
        function()
          if vim.bo.buftype == "terminal" then
            vim.cmd("wincmd p") -- estou no Claude -> volto pro editor
          else
            vim.cmd("ClaudeCodeFocus") -- estou no editor -> foco o Claude
          end
        end,
        mode = { "n", "t" },
        desc = "Alternar editor <-> Claude",
      },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Retomar sessao" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continuar sessao" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Selecionar modelo" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Enviar buffer atual" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Enviar selecao" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Adicionar arquivo (explorer)",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
      },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Aceitar diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Rejeitar diff" },
    },
  },
}
