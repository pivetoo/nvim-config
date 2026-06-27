-- UI: tema, statusline, icones, git, explorer e descoberta de keymaps
return {
  -- Colorscheme
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.moonflyNormalFloat = true
      vim.cmd.colorscheme("moonfly")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "moonfly",
        globalstatus = true,
        section_separators = "",
        component_separators = "|",
      },
    },
  },

  -- Sinais de git na coluna lateral
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  -- Explorer de arquivos
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<leader>fe", "<cmd>NvimTreeToggle<CR>", desc = "Explorer de arquivos" },
      { "<C-b>", "<cmd>NvimTreeToggle<CR>", desc = "Explorer de arquivos (estilo VSCode)" },
    },
    opts = {
      view = { width = 35 },
      filters = {
        dotfiles = false,
        git_ignored = true, -- esconde bin/, obj/, node_modules/ (ja no .gitignore)
        custom = {
          "*.slnx",
          "^bin$",
          "^obj$",
          "node_modules",
          "^\\.git$",
        },
      },
    },
  },

  -- Descoberta de keymaps
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f", group = "Buscar/Arquivos" },
        { "<leader>a", group = "IA / Claude" },
        { "<leader>d", group = "Debug/Diagnostico" },
        { "<leader>n", group = ".NET" },
        { "<leader>c", group = "Codigo (LSP)" },
        { "<leader>s", group = "Splits" },
        { "<leader>r", group = "Rename" },
      },
    },
  },
}
