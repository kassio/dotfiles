return {
  { -- Show LSP loading information
    'j-hui/fidget.nvim',
    tag = 'legacy',
    opts = {
      text = { spinner = 'dots' },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- General purpose Language Server
      'creativenull/efmls-configs-nvim',
    },
    config = function()
      require('plugins.lsp.handlers').setup()
      require('plugins.lsp.servers').setup()
      require('plugins.lsp.autoformat').setup()
      require('plugins.lsp.keymaps').setup()
    end
  },
}
