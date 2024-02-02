local M = {}
local action_state = require('telescope.actions.state')
local action_set = require('telescope.actions.set')

-- If the selected entry is a directory, search inside of it
function M.navigate_or_select(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local path = entry[1]

  if vim.fn.isdirectory(path) > 0 then
    require('plugins.fuzzyfinder.commands').current_dir({
      search_dirs = { path },
    })
  else
    action_set.select(prompt_bufnr, 'default')
  end
end

return M
