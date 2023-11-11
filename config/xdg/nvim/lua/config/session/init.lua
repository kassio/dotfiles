local session = require('config.session.utils')

local function defaults(desc, opts)
  return vim.tbl_extend('force', { desc = 'session: ' .. desc }, opts or {})
end

local function keymap_and_coammand(desc, cmd, key, fn, opts)
  vim.api.nvim_create_user_command(cmd, fn, defaults(desc, opts))
  vim.keymap.set('n', key, fn, defaults(desc))
end

return {
  setup = function()
    keymap_and_coammand('save', 'SessionSave', '<leader>ss', session.save, { nargs = '?' })
    keymap_and_coammand('load', 'SessionLoad', '<leader>sl', session.load)
    keymap_and_coammand('destry', 'SessionDestroy', '<leader>sd', session.destroy)
    keymap_and_coammand(
      'destroy all sessions',
      'SessionDestroyAll',
      '<leader>sD',
      session.destroy_all
    )
  end,
}
