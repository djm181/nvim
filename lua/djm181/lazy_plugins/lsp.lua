return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp'
  },
  config = function()
    -- NOTE: to make any of this work you need a language server.
    -- If you don't know what that is, watch this 5 min video:
    -- https://www.youtube.com/watch?v=LaS32vctfOY

    -- Reserve a space in the gutter
    vim.opt.signcolumn = 'yes'

    -- Add cmp_nvim_lsp capabilities settings to lspconfig
    -- This should be executed before you configure any language server
    local lspconfig_defaults = require('lspconfig').util.default_config
    lspconfig_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lspconfig_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    -- This is where you enable features that only work
    -- if there is a language server active in the file
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local opts = {buffer = event.buf}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      end,
    })

    local cmp = require('cmp')

    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "solargraph",
        "eslint",
      },
      handlers = {
        function(server_name)
          if server_name == "solargraph" then
            require('lspconfig').solargraph.setup({
              -- cmd = { "nc", "localhost", os.getenv("SOLARGRAPH_PORT") },
              -- settings = {
              --   solargraph = {
              --     externalServer = {
              --       host = "localhost",
              --       port = os.getenv("SOLARGRAPH_PORT")
              --     },
              --     transport = "socket"
              --   }
              -- }
            })
          elseif server_name == "ruby_lsp" then
            require('lspconfig').ruby_lsp.setup {
              mason = false,
              cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") }
            }
          else
            require('lspconfig')[server_name].setup({})
          end
        end,
      }
    })
    cmp.setup({
      sources = {
        {name = 'nvim_lsp'},
      },
      snippet = {
        expand = function(args)
          -- You need Neovim v0.10 to use vim.snippet
          vim.snippet.expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
      }),
    })
  end
}
