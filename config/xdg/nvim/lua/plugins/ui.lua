require('noice').setup({
  views = {
    virtualtext = false,
  },
  routes = {
    {
      view = 'split',
      filter = { event = 'msg_show', min_height = 10 },
    },
  },
})
