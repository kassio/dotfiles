local utils = require('utils')

local api = vim.api
local ts = vim.treesitter
local ts_parsers = require('nvim-treesitter.parsers')
local ts_query = require('nvim-treesitter.query')
local ts_utils = require('nvim-treesitter.ts_utils')
local processors = require('config.hbar.components.treesitter-location.processors')

return {
  on_click = function(msg, opts)
    utils.to_clipboard(vim.trim(msg), opts.mouse_btn ~= 'l')
  end,
  render = function()
    local bufnr = api.nvim_get_current_buf()
    local filetype = api.nvim_buf_get_option(bufnr, 'filetype')

    local processor = processors[filetype]
    if not processor then
      return ''
    end

    local query = ts_query.get_query(ts_parsers.ft_to_lang(filetype), 'location')
    if not query then
      return ''
    end

    local current_node = ts_utils.get_node_at_cursor()
    local node = current_node
    local nodes = {}

    while node do
      local iter = query:iter_captures(node, 0)
      local id, captured = iter()

      if query.captures[id] == nil then
        node = node:parent()
        iter = query:iter_captures(node, 0)
        id, captured = iter()
      end

      if captured == node and query.captures[id] == 'root' then
        while captured == node do
          id, captured = iter()
        end
        local capture_name = query.captures[id]

        table.insert(nodes, 1, {
          capture_name,
          ts.query.get_node_text(captured, 0),
        })
      end

      node = node:parent()
    end

    if #nodes == 0 then
      return ''
    end

    return ' ' .. processor(nodes) .. ' '
  end,
}
