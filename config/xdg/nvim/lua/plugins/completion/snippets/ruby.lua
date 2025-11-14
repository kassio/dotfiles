local utils = require('utils.ruby')
local ls = require('luasnip')
local f = ls.function_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

return {
  setup = function()
    ls.add_snippets('ruby', {
      s('#f', { t('# frozen_string_literal: true') }),
      s('aa', { t('attr_accessor ') }),
      s('ar', { t('attr_reader ') }),
      s('aw', { t('attr_writer ') }),
      s('pry', { t('binding.pry') }),
      s('prys', { t('binding.pry_shell') }),
      --
      s('begin', {
        t({'begin do', ''}),
        i(0),
        t({'', 'end'})
      }),
      s('def', {
        t('def '), i(1), t({'', ''}),
        i(0),
        t({'', 'end'})
      }),
      s('do', {
        t({'do', ''}),
        i(0),
        t({'', 'end'})
      }),
      s('dop', {
        t('do |'), i(1), t({'|', ''}),
        i(0),
        t({'', 'end'})
      }),
      s('class', {
        f(function() return utils.file_namespace('class') end), i(1), t({'', ''}),
        i(0),
        t({'', 'end'})
      }),
      s('module', {
        f(function() return utils.file_namespace('module') end), i(1), t({'', ''}),
        i(0),
        t({'', 'end'})
      }),
    })
  end
}
