local M = {}
local action_state = require('telescope.actions.state')

-- If multiple entries are selected, open using given command tabs
function M.open(cmd)
  return function(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local tabpage = vim.api.nvim_get_current_tabpage()

    local selected = picker:get_multi_selection()
    if #selected == 0 then
      selected = { picker:get_selection() }
    end

    for _, entry in ipairs(selected) do
      vim.cmd[cmd](entry[1])
    end

    vim.api.nvim_set_current_tabpage(tabpage)
    vim.cmd.stopinsert()
  end
end

return M
