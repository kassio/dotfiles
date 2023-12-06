local rules = {
  loaded = false,
  list = {},
}
local M = {}

local function build_rules_list()
  if rules.loaded then
    return
  end

  local function handler(obj)
    local list = {}
    for _, row in ipairs(vim.split(obj.stdout, '\n')) do
      if string.match(row, '^%w') ~= nil then
        local name = string.gsub(row, ':$', '')
        table.insert(list, { label = name })
      end
    end

    rules.list = list
    rules.loaded = true
  end

  vim.system({ 'bundle', 'exec', 'rubocop', '--show-cops' }, { text = true }, handler)
end

function M:is_available()
  return vim.bo.filetype == 'ruby' and rules.loaded
end

function M:get_debug_name()
  return 'rubocop'
end

function M:get_keyword_pattern()
  return [[\k\+\/\?\k*]]
end

function M:get_trigger_characters()
  return { '/' }
end

function M:complete(_params, callback)
  callback(rules.list)
end

return {
  rules = function()
    return rules
  end,
  setup = function()
    build_rules_list() -- async
    require('cmp').register_source('rubocop', M)
  end,
}
