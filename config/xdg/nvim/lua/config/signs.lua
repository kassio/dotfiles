local utils = require('utils')

for name, symbol in pairs(utils.symbols.diagnostics) do
  vim.fn.sign_define(name, {
    text = symbol,
    texthl = utils.string.camelcase(name),
  })
end
