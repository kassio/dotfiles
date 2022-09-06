require('nvim-surround').buffer_setup({
  surrounds = {
    ['$'] = {
      add = { '${', '}' },
      find = '(${)[^}]-(})',
      delete = '(${)()[^}]-(})()',
    },
  },
})
