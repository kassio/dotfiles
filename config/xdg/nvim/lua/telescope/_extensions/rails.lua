return require('telescope').register_extension({
  exports = {
    rails = require('plugins.fuzzyfinder.rails').find,
  },
})
