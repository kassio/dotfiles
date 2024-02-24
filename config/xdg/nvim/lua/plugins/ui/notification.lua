return {
  'rcarriga/nvim-notify',
  config = function()
    local notify = require('notify')

    notify.setup({
      timeout = 1500,
      top_down = false,
      stages = 'no_animation'
    })

    vim.notify = notify
  end,
}
