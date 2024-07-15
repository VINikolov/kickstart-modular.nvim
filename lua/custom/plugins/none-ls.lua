return {
  'nvimtools/none-ls.nvim',

  config = function()
    local null_ls = require 'null-ls'
    local builtins = null_ls.builtins

    null_ls.setup {
      sources = {
        -- formatting
        builtins.formatting.stylua,
        builtins.formatting.prettierd.with {
          filetypes = { 'html', 'json', 'js', 'ts', 'jsx', 'tsx', 'yaml', 'markdown' },
        },
        builtins.formatting.black,
        builtins.formatting.csharpier,
      },
    }

    vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
  end,
}
