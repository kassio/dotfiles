return require('telescope').register_extension({
  exports = {
    ext = require('plugins.fuzzyfinder.commands').find_by_ext,
  },
})
