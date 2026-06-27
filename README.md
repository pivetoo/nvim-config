# nvim-config

Configuração do Neovim para desenvolvimento **.NET (C#)** e **React/TypeScript** em WSL2,
com integração ao **Claude Code**. Estrutura modular sobre o `lazy.nvim`.

## Requisitos

- Neovim **0.12+** (o treesitter usa o branch `main`)
- `git`, `ripgrep`, `fd`, um compilador C (`gcc`)
- **tree-sitter CLI** (`npm i -g tree-sitter-cli`) — necessário pro treesitter compilar parsers
- .NET SDK (Roslyn é instalado via `dotnet tool install --global roslyn-language-server`)
- Node.js (LSPs de TS/web via Mason; `vscode-langservers-extracted` global p/ Razor)
- Claude Code CLI (`claude`) autenticado, para a camada de IA

## Instalação

```bash
git clone https://github.com/pivetoo/nvim-config.git ~/.config/nvim
nvim   # o lazy.nvim instala tudo no primeiro start
```

## Estrutura

```
init.lua              leader (Espaco) + bootstrap do lazy
lua/config/options    opcoes gerais do editor
lua/config/keymaps    atalhos globais
lua/plugins/          um modulo por area (lsp, dotnet, dap, finder, ui, claudecode...)
```

## Atalhos principais (leader = Espaco)

| Atalho | Acao |
|--------|------|
| `Ctrl+S` | salvar · `Ctrl+Z` desfazer |
| `Ctrl+P` | buscar arquivo · `Espaco f g` buscar texto |
| `Ctrl+B` | explorer (arvore de arquivos) |
| `gd` / `gr` / `K` | definicao / referencias / hover (LSP) |
| `F5` / `F10` / `F11` | debug: continuar / step over / step into |
| `Espaco b` | breakpoint · `Espaco d u` UI de debug |
| `Espaco n r` / `Espaco n t` | .NET: run / test runner |
| `Espaco a c` / `Ctrl+;` | Claude: abrir / alternar foco |

## Notas

- Tema: **moonfly** (editor e statusline). O WezTerm tem config propria (fora deste repo).
- LSP usa a API nativa do Neovim 0.11+ (`vim.lsp.config` / `vim.lsp.enable`).
- C# (Roslyn + netcoredbg) é gerenciado pelo `easy-dotnet`.
