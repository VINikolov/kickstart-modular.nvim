return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,

    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },

    config = function()
      require('nvim-tree').setup {
        sort = {
          sorter = 'case_sensitive',
        },
        view = {
          width = 40,
          side = 'left',
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      }

      local pass_args = function(func, ...)
        local args = { ... }
        return function()
          func(unpack(args))
        end
      end

      vim.keymap.set(
        'n',
        '<Leader>tf',
        pass_args(require('nvim-tree.api').tree.find_file, { update_root = true, open = true, focus = true }),
        { desc = 'Open nvim-[T]ree [F]ind file' }
      )
      vim.keymap.set('n', '<Leader>ts', require('nvim-tree.api').tree.open, { desc = 'Open nvim-[T]ree Focu[S]' })
      vim.keymap.set('n', '<Leader>tc', require('nvim-tree.api').tree.close, { desc = 'Open nvim-[T]ree [C]lose' })
    end,
  },
}
