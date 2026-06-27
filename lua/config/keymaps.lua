-- Keymaps globais (independentes de plugin)
-- Keymaps de plugins (debug, finder, claude, lsp) ficam nos respectivos modulos
local map = vim.keymap.set

-- Limpar realce de busca
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Salvar / sair rapido
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Salvar arquivo" })

-- Ctrl+S salva (normal, insercao e visual), estilo editores comuns
map({ "n", "i", "v" }, "<C-s>", "<cmd>write<CR>", { desc = "Salvar arquivo" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Fechar janela" })

-- Navegacao entre janelas (panes do nvim)
map("n", "<C-h>", "<C-w>h", { desc = "Janela a esquerda" })
map("n", "<C-j>", "<C-w>j", { desc = "Janela abaixo" })
map("n", "<C-k>", "<C-w>k", { desc = "Janela acima" })
map("n", "<C-l>", "<C-w>l", { desc = "Janela a direita" })

-- Redimensionar janelas
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Aumentar altura" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Diminuir altura" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Diminuir largura" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Aumentar largura" })

-- Splits
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split horizontal" })

-- Mover linhas selecionadas (visual)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover selecao abaixo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover selecao acima" })

-- Manter cursor centralizado ao rolar/buscar
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Diagnosticos (LSP)
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Diagnostico anterior" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Proximo diagnostico" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Abrir diagnostico flutuante" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Lista de diagnosticos" })

-- Desfazer/refazer estilo editores comuns (Ctrl+Z / Ctrl+Y)
map("n", "<C-z>", "u", { desc = "Desfazer" })
map("i", "<C-z>", "<C-o>u", { desc = "Desfazer" })
map("v", "<C-z>", "<Esc>u", { desc = "Desfazer" })
map("n", "<C-S-z>", "<C-r>", { desc = "Refazer" })
map("i", "<C-S-z>", "<C-o><C-r>", { desc = "Refazer" })
