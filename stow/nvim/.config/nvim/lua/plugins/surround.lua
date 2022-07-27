require('nvim-surround').setup({
  delimiters = {
    pairs = {
      ['*'] = { '*', '*' },
      ['_'] = { '_', '_' },
      ['-'] = { '-', '-' },
      ['`'] = { '`', '`' },
      ['='] = { '=', '=' },
      ['|'] = { '|', '|' },
    },
    invalid_key_behavior = function(char)
      vim.api.nvim_err_writeln(string.format('Error: Invalid character: "%s"', char))
    end,
  },
})
