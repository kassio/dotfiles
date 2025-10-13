local languages = require('efmls-configs.defaults').languages()

return {
  cmd = { 'efm-langserver' },
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}
