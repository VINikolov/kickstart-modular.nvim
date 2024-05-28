return {
  'nvimtools/none-ls.nvim',

  -- dependencies = {
  --   "nvimtools/none-ls-extras.nvim",
  -- },

  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        -- require("none-ls.code_actions.eslint_d"),
        -- require("none-ls.diagnostics.eslint_d"),

        -- formatting
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd.with {
          filetypes = { 'html', 'json', 'js', 'ts', 'jsx', 'tsx', 'yaml', 'markdown' },
        },
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.csharpier,

        -- diagnostics
        -- null_ls.builtins.diagnostics.eslint_d.with {
        --   condition = function(utils)
        --     return utils.root_has_file { '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', 'eslint.config.js' }
        --   end,
        -- },

        -- code_actions
        -- null_ls.builtins.code_actions.eslint_d.with {
        --   condition = function(utils)
        --     return utils.root_has_file { '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', 'eslint.config.js' }
        --   end,
        -- },
      },
    }

    vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
  end,
}
