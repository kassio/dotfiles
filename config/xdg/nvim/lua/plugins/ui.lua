require('noice').setup({
  routes = {
    {
      view = 'split',
      filter = { event = 'msg_show', min_height = 10 },
    },
    {
      filter = {
        event = 'msg_show',
        kind = 'search_count',
      },
      opts = { skip = true },
    },
  },
})
