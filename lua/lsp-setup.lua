vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'

      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>rr', vim.lsp.buf.rename, '[R]e[n]ame')

    map('<leader>ca', function()
      vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
    end, '[C]ode [A]ction')

    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    map('<C-.>', vim.lsp.buf.hover, 'Hover Documentation')
    map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    map('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    map('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).

    -- vim.api.nvim_create_autocmd('LspDetach', {
    --   group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
    --   callback = function()
    --     vim.lsp.buf.clear_references()
    --   end,
    -- })
  end
})

vim.api.nvim_create_autocmd('CursorHold', {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})


local which_key = require 'which-key'

-- document existing key chains
which_key.add {
  { '<leader>c',  group = '[C]ode' },
  { '<leader>c_', hidden = true },
  { '<leader>d',  group = '[D]ocument' },
  { '<leader>d_', hidden = true },
  { '<leader>g',  group = '[G]it' },
  { '<leader>g_', hidden = true },
  { '<leader>h',  group = 'Git [H]unk' },
  { '<leader>h_', hidden = true },
  { '<leader>r',  group = '[R]ename' },
  { '<leader>r_', hidden = true },
  { '<leader>s',  group = '[S]earch' },
  { '<leader>s_', hidden = true },
  { '<leader>t',  group = '[T]oggle' },
  { '<leader>t_', hidden = true },
  { '<leader>w',  group = '[W]orkspace' },
  { '<leader>w_', hidden = true },
}

-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
which_key.add({
  { '<leader>',  group = 'VISUAL <leader>', mode = 'v' },
  { '<leader>h', desc = 'Git [H]unk',       mode = 'v' },
}, { mode = 'v' })

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  rust_analyzer = {},
  ts_ls = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  csharp_ls = { filetypes = { 'cs' } },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = false,
  handlers = {
    function(server_name)
      print("🔧 Handlers", server_name)

      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
      }
    end,
  }
}

-- vim: ts=2 sts=2 sw=2 et
