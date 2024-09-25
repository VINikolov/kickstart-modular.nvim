-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Custom remaps
-- vim.keymap.set('v', '<leader>p', "\"_dP")

-- Copy & Paste
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
vim.keymap.set({ 'n', 'v' }, 'p', '"0p')
vim.keymap.set({ 'n', 'v' }, 'P', '"0P')

vim.keymap.set({ 'n', 'v' }, 'd', '"0d')
vim.keymap.set('n', 'D', '"0D')

vim.keymap.set('n', 'x', '"0x')
vim.keymap.set('n', 'X', '"0X')

vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')

-- Moving around
vim.keymap.set('n', 'J', '20j')
vim.keymap.set('n', 'K', '20k')

-- LazyGit
vim.keymap.set('n', '<leader>gs', '<Cmd>LazyGit<CR>')

-- Move lines in view mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")

-- Keep screen centered
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '{', '{zz')
vim.keymap.set('n', '}', '}zz')
vim.keymap.set('n', 'G', 'Gzz')
vim.keymap.set('n', 'gg', 'ggzz')
vim.keymap.set('n', '*', '*zz')

-- Multiple windows navigation
vim.keymap.set('n', 'mh', '<C-w>h')
vim.keymap.set('n', 'mj', '<C-w>j')
vim.keymap.set('n', 'mk', '<C-w>k')
vim.keymap.set('n', 'ml', '<C-w>l')
vim.keymap.set('n', 'MH', '<C-w>H')
vim.keymap.set('n', 'ML', '<C-w>L')
vim.keymap.set('n', 'MM', '<C-w>_')

-- Replace text in buffer
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Quickfix list
vim.keymap.set('n', ']t', ':cn<CR>')
vim.keymap.set('n', '[t', ':cp<CR>')

-- File formatting
vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, { desc = 'Format file' })

-- React specific keymaps
vim.keymap.set('n', '<leader>ir', "iimport * as React from 'react'<Esc>", { desc = 'Import react snippet' })
vim.keymap.set('n', '<leader>wf', 'i{return }<Esc>x%p%a<CR><CR><Esc>kO', { desc = 'Wrap function return statement into body block' })

-- vim: ts=2 sts=2 sw=2 e
