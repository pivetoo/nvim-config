-- Stack .NET: easy-dotnet (Roslyn LSP + netcoredbg + test runner) plug-and-play
return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      "nvim-telescope/telescope.nvim",
    },
    ft = { "cs", "fsharp", "razor" },
    cmd = "Dotnet",
    keys = {
      { "<leader>nr", "<cmd>Dotnet run<CR>", desc = ".NET: run" },
      { "<leader>nb", "<cmd>Dotnet build<CR>", desc = ".NET: build" },
      { "<leader>nt", "<cmd>Dotnet testrunner<CR>", desc = ".NET: test runner" },
      { "<leader>ns", "<cmd>Dotnet secrets<CR>", desc = ".NET: user secrets" },
      { "<leader>no", "<cmd>Dotnet outdated<CR>", desc = ".NET: pacotes desatualizados" },
    },
    config = function()
      require("easy-dotnet").setup({
        picker = "telescope",
        lsp = {
          enabled = true,
          preload_roslyn = true,
        },
        debugger = {
          auto_register_dap = true,
          engine = "netcoredbg",
        },
        test_runner = {
          auto_start_testrunner = true,
        },
      })
    end,
  },
}
