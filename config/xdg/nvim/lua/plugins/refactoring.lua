return {
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      local refactoring = require('refactoring')

      local refactoring_cmd = function(name)
        local cmd_name = 'Refactoring' .. string.gsub(name, '%s', '')

        vim.api.nvim_create_user_command(cmd_name, function()
          refactoring.refactor(name)
        end, { range = true })
      end

      refactoring_cmd('Extract Function')
      refactoring_cmd('Extract Function To File')
      refactoring_cmd('Extract Variable')
      refactoring_cmd('Inline Variable')
      refactoring_cmd('Extract Block')
      refactoring_cmd('Extract Block To File')
      refactoring_cmd('Inline Variable')
    end,
  },
}
