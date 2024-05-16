return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = {
    'Outline',
    'OutlineOpen',
  },
  keys = {
    { 'go', vim.cmd.Outline, silent = true, desc = 'outline: toggle' },
  },
  config = function()
    require('outline').setup({
      width = 25,
    })
  end,
}
