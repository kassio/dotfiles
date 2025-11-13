local utils = require('utils.ruby')
local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

local function block(...)
  return {
    ...,
    t({'', ''}),
    i(0),
    t({'', 'end'})
  }
end

return {
  setup = function()
    ls.add_snippets('ruby', {
      s('#f', { t('# frozen_string_literal: true') }),
      s('aa', { t('attr_accessor ') }),
      s('aw', { t('attr_writer ') }),
      s('ar', { t('attr_reader ') }),
      s('begin', block(t('begin'))),
      s('def', block(t('def'))),
      s('do', block(t('do'))),
      s('class', block(
        f(function()
          return utils.file_namespace('class')
        end)
      )),
      s('module', block(
        f(function()
          return utils.file_namespace('module')
        end)
      )),
    })
  end
}
