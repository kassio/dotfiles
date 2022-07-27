local M = {}

M.setup = function()
  local fn = vim.fn
  local repo = 'https://github.com/wbthomason/packer.nvim'
  local path = string.format('%s/site/pack/packer/opt/packer.nvim', fn.stdpath('data'))

  if fn.empty(fn.glob(path)) > 0 then
    P('Installing packer, after restarting nvim run :Upgrade')
    fn.system(string.format('git clone %s %s', repo, path))

    M.sync()
    vim.cmd('qall!')
  end

  vim.api.nvim_create_user_command('Upgrade', require('plugins').upgrade, { bang = true })
  vim.api.nvim_create_user_command('UpgradeSync', require('plugins').sync, {})
end

M.sync = function()
  M.load().sync()
end

M.upgrade = function(cmd)
  local post_upgrade = {
    {
      events = { 'User' },
      pattern = 'PackerComplete',
      command = 'LspInstallInfo',
    },
  }

  if cmd.bang then
    table.insert(post_upgrade, {
      events = { 'User' },
      pattern = 'PackerComplete',
      command = 'quitall!',
    })
  end

  vim.my.utils.augroup('user:packing', post_upgrade)

  M.sync()
end

M.load = function()
  vim.cmd('packadd packer.nvim')

  local packer = require('packer')

  packer.init({ compile_path = vim.fn.stdpath('data') .. '/site/plugin/packer.vim' })

  return packer.startup({
    function(use)
      -- Packer can manage itself
      use({ 'wbthomason/packer.nvim', opt = true })

      -- Statusline
      use('nvim-lualine/lualine.nvim')

      -- Project management
      use('tpope/vim-projectionist')

      -- Load configs from .editorconfig
      use('gpanders/editorconfig.nvim')

      -- Restore last position
      use('farmergreg/vim-lastplace')

      -- Open file with file_path:line:path
      use('wsdjeg/vim-fetch')

      -- Comment management
      use('numToStr/Comment.nvim')

      -- Replace variantions of a word
      use('tpope/vim-abolish')

      -- Surround chars handling
      use('kylechui/nvim-surround')
      use('wellle/targets.vim')
      use('tpope/vim-repeat') -- Enables repeat surround movements

      -- text aligning
      use('junegunn/vim-easy-align')

      -- File tree
      use({
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
      })

      -- Icons
      use('kyazdani42/nvim-web-devicons')

      -- Fuzzy Finder
      use({
        'junegunn/fzf',
        run = ':call fzf#install()',
        requires = { 'junegunn/fzf.vim' },
      })

      use({ 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } })
      use('nvim-lua/popup.nvim')
      use('nvim-lua/plenary.nvim')
      use('nvim-telescope/telescope-ui-select.nvim')
      use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

      -- Treesitter
      use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
      use('nvim-treesitter/nvim-treesitter-textobjects')
      use('nvim-treesitter/nvim-treesitter-refactor')
      use('nvim-treesitter/playground')
      use('lewis6991/spellsitter.nvim')
      use('SmiteshP/nvim-gps')

      -- LSP
      use('neovim/nvim-lspconfig')
      use('williamboman/nvim-lsp-installer')
      -- generic LSP for diagnostic, formatting, etc
      use('jose-elias-alvarez/null-ls.nvim')
      -- symbols navigator
      use('simrat39/symbols-outline.nvim')

      -- Git
      use('lewis6991/gitsigns.nvim')
      use('emmanueltouzery/agitator.nvim')

      -- Completion
      use('hrsh7th/nvim-cmp')
      use('hrsh7th/cmp-nvim-lsp')
      use('hrsh7th/cmp-buffer')
      use('hrsh7th/cmp-path')
      use('hrsh7th/cmp-nvim-lua')
      use('f3fora/cmp-spell')
      use('onsails/lspkind-nvim')
      use('ray-x/cmp-treesitter')
      use('hrsh7th/cmp-nvim-lsp-signature-help')
      -- snippets
      use('dcampos/nvim-snippy')
      use('dcampos/cmp-snippy')

      use('folke/todo-comments.nvim')

      -- fancy notification
      use('rcarriga/nvim-notify')

      -- terminal handling
      use('kassio/neoterm')

      -- Split/Join commands
      use('AndrewRadev/splitjoin.vim')

      -- Better pairs matching
      use('andymass/vim-matchup')

      -- Test runner
      use('vim-test/vim-test')

      -- Debugger Tooling
      use('mfussenegger/nvim-dap') -- debugger
      use('rcarriga/nvim-dap-ui')
      use('theHamsta/nvim-dap-virtual-text')
      use('leoluz/nvim-dap-go') -- go debugger integration

      -- Theme
      use({ 'catppuccin/nvim', as = 'catppuccin' })

      -- Colors
      use('norcalli/nvim-colorizer.lua') -- Highlight color strings
      use('norcalli/nvim-terminal.lua') -- Fix terminal colors
      use('https://gitlab.com/yorickpeterse/nvim-pqf.git') -- Prettier qf/loc windows

      -- Better language support
      use('euclidianAce/BetterLua.vim') -- Lua
      use('google/vim-jsonnet') -- Jsonnet
      use('jparise/vim-graphql') -- Graphql
      use('stephenway/postcss.vim') -- Postcss
      use('tpope/vim-git') -- Postcss
      use('fladson/vim-kitty') -- kitty terminal config
    end,
    config = {
      autoremove = true,
      log = { level = 'trace' },
    },
  })
end

return M
