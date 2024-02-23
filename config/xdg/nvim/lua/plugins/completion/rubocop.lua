local M = {
  rules = {
    loaded = false,
    list = {},
    error = '',
  },
}

local function build_rules_list()
  if M.rules.loaded then
    return
  end

  local function parser(obj)
    if obj.code ~= 0 or obj.stderr ~= '' then
      M.rules.loaded = true
      M.rules.error = obj.stderr
      return
    end

    local list = {}
    for _, row in ipairs(vim.split(obj.stdout, '\n')) do
      if string.match(row, '^%w') ~= nil then
        local name = string.gsub(row, ':$', '')
        table.insert(list, { label = name })
      end
    end

    M.rules.list = list
    M.rules.loaded = true
  end

  vim.system({ 'bundle', 'exec', 'rubocop', '--show-cops' }, { text = true }, parser)
end

function M.is_available()
  return vim.bo.filetype == 'ruby' and M.rules.loaded
end

function M.get_debug_name()
  return 'rubocop'
end

function M.get_keyword_pattern()
  return [[\(\k\|\/\)\+]]
end

function M.get_trigger_characters()
  return { '/' }
end

function M.complete(_params, callback)
  callback(M.rules.list)
end

return {
  setup = function()
    build_rules_list() -- async
    require('cmp').register_source('rubocop', M)
  end,
}
