-- Syntax highlighting / parsing
-- Branch "main" (reescrita) - exigido pelo Neovim 0.12+. O branch "master" antigo
-- quebra no Neovim 0.12 (erro em injecoes: attempt to call method 'range').
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "c_sharp",
        "typescript",
        "tsx",
        "javascript",
        "json",
        "html",
        "css",
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "bash",
        "yaml",
        "toml",
      })

      -- Liga highlight + indent por buffer (so quando ha parser para o filetype)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if pcall(vim.treesitter.start) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
