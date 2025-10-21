local utils = require('plugins.git.utils')

local function keymap(mode, keys, cb, desc)
  vim.keymap.set(mode, keys, cb, { desc = 'git: ' .. desc })
end

return {
  setup = function()
    keymap('n', ']g', utils.next_hunk, 'next hunk')
    keymap('n', '[g', utils.prev_hunk, 'previous hunk')

    keymap('n', '<c-g><c-l>', utils.blame, 'blame current file')
    keymap('n', '<c-g><c-d>', utils.preview_hunk, 'preview hunk (diff)')
    keymap('n', '<c-g><c-w>', utils.stage_hunk, 'stage hunk (add)')
    keymap('n', '<c-g><c-u>', utils.reset_hunk, 'reset hunk (undo)')
    keymap('n', '<c-g><c-c>', utils.reset_buffer, 'reset buffer')
  end,
}
