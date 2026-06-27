-- Fuzzy finder: Telescope (alinhado com o picker do easy-dotnet)
return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master", -- master usa a API nova do treesitter (compativel com o branch main)
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Buscar arquivos" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Buscar texto (grep)" },
      { "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Buscar arquivo (nome)" },
      { "<C-S-f>", "<cmd>Telescope live_grep<CR>", desc = "Buscar texto em todos os arquivos" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers abertos" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Ajuda" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Arquivos recentes" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnosticos" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Simbolos do arquivo" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buscar no buffer" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          mappings = {
            i = { ["<C-u>"] = false, ["<C-d>"] = false },
          },
        },
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_dropdown() },
        },
      })
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
    end,
  },
}
