local utils = require('my.utils')

return {
  on_click = function(_bufnr, _clicks, _button, mods)
    utils.to_clipboard(utils.treesitter.location(), vim.fn.stridx(mods, 'c') ~= -1)
  end,
  render = function()
    local bufnr = vim.api.nvim_get_current_buf()

    return string.format(
      " %%%d@v:lua.require'plugins.statusline.components.code-location'.on_click@%s%%X ",
      bufnr,
      utils.treesitter.location()
    )
  end,
}
