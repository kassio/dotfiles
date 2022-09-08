local api = vim.api
local fn = vim.fn
local M = {}

M.setup = function()
  local repo = 'https://github.com/wbthomason/packer.nvim'
  local path = string.format('%s/site/pack/packer/opt/packer.nvim', fn.stdpath('data'))

  if fn.empty(fn.glob(path)) > 0 then
    fn.system(string.format('git clone %s %s', repo, path))

    M.upgrade_and_close()

    return
  end

  api.nvim_create_user_command('Upgrade', require('plugins').upgrade, {})
  api.nvim_create_user_command('UpgradeAndClose', require('plugins').upgrade_and_close, {})
end

M.upgrade_and_close = function()
  local group = api.nvim_create_augroup('user:packing', { clear = false })
  api.nvim_create_autocmd({ 'User' }, {
    group = group,
    pattern = 'PackerComplete',
    command = 'MasonToolsUpdate',
  })

  api.nvim_create_autocmd({ 'User' }, {
    group = group,
    pattern = 'MasonToolsUpdateCompleted',
    command = 'quitall!',
  })

  M.load().sync()
end

M.upgrade = function()
  local group = api.nvim_create_augroup('user:packing', { clear = false })
  api.nvim_create_autocmd({ 'User' }, {
    group = group,
    pattern = 'PackerComplete',
    command = 'MasonToolsUpdate',
  })

  M.load().sync()
end

M.load = function()
  vim.cmd('packadd packer.nvim')

  local packer = require('packer')

  packer.init({ compile_path = fn.stdpath('data') .. '/site/plugin/packer.vim' })

  return packer.startup({
    function(use)
      -- Packer can manage itself
      use({ 'wbthomason/packer.nvim', opt = true })

      -- fix CursorHold
      use({ 'antoinemadec/FixCursorHold.nvim' })

      -- Statusline
      use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
      })

      -- Project management
      use({ 'tpope/vim-projectionist' })

      -- Load configs from .editorconfig
      use({ 'gpanders/editorconfig.nvim' })

      -- Restore last position
      use({ 'farmergreg/vim-lastplace' })

      -- Open file with file_path:line:path
      use({ 'wsdjeg/vim-fetch' })

      -- Comment management
      use({ 'numToStr/Comment.nvim' })

      -- Replace variantions of a word
      use({ 'tpope/vim-abolish' })

      -- Surround chars handling
      use({ 'kylechui/nvim-surround' })

      use({ 'wellle/targets.vim' })
      use({ 'tpope/vim-repeat' }) -- Enables repeat surround movements

      -- text aligning
      use({ 'junegunn/vim-easy-align' })

      -- list continuation
      use({ 'gaoDean/autolist.nvim' })

      -- File tree
      use({
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
      })

      -- Icons
      use({ 'kyazdani42/nvim-web-devicons' })

      -- Fuzzy Finder
      use({
        {
          'nvim-telescope/telescope.nvim',
          requires = { 'nvim-lua/plenary.nvim' },
        },
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'make',
        },
        'nvim-telescope/telescope-ui-select.nvim',
      })

      -- Treesitter
      use({
        { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/playground',
        'lewis6991/spellsitter.nvim',
        'SmiteshP/nvim-gps',
        'theHamsta/nvim-treesitter-pairs',
      })

      -- LSP/DAP installer
      use({
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
      })

      -- LSP
      use({
        'neovim/nvim-lspconfig',
        'jose-elias-alvarez/null-ls.nvim', -- generic LSP for diagnostic, formatting, etc
        'simrat39/symbols-outline.nvim', -- symbols navigator
        'ThePrimeagen/refactoring.nvim', -- required for null-ls refactoring module
      })

      -- Git
      use({ 'lewis6991/gitsigns.nvim', 'emmanueltouzery/agitator.nvim' })

      -- Completion
      use({
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'f3fora/cmp-spell',
        'onsails/lspkind-nvim',
        'ray-x/cmp-treesitter',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        -- snippets
        'dcampos/nvim-snippy',
        'dcampos/cmp-snippy',
      })

      use({ 'folke/todo-comments.nvim' })

      -- fancy notification
      use({ 'rcarriga/nvim-notify' })

      -- terminal handling
      use({ 'kassio/neoterm' })

      -- Split/Join commands
      use({ 'AndrewRadev/splitjoin.vim' })

      -- Better pairs matching
      use({ 'andymass/vim-matchup' })

      -- Test runner
      use({ 'vim-test/vim-test' })

      -- Debugger Tooling
      use({
        'mfussenegger/nvim-dap',
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
        'leoluz/nvim-dap-go', -- go debugger integration
      })

      -- Theme
      use({ 'catppuccin/nvim', as = 'catppuccin' })

      -- Colors
      use({ 'NvChad/nvim-colorizer.lua' }) -- Highlight color strings
      use({ 'norcalli/nvim-terminal.lua' }) -- Fix terminal colors
      use({ 'https://gitlab.com/yorickpeterse/nvim-pqf.git' }) -- Prettier qf/loc windows

      -- Better language support
      use({ 'euclidianAce/BetterLua.vim' }) -- Lua
      use({ 'google/vim-jsonnet' }) -- Jsonnet
      use({ 'jparise/vim-graphql' }) -- Graphql
      use({ 'stephenway/postcss.vim' }) -- Postcss
      use({ 'tpope/vim-git' }) -- Postcss
      use({ 'fladson/vim-kitty' }) -- kitty terminal config
    end,
    config = {
      autoremove = true,
      log = { level = 'trace' },
    },
  })
end

return M
