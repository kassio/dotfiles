local utils = require('utils.snippets')
local ls = require('luasnip')
local c = ls.choice_node
local f = ls.function_node
local s = ls.snippet
local t = ls.text_node

return {
  setup = function()
    ls.add_snippets('all', {
      s('#!', {
        t('#!/usr/bin/env '),
        c(1, {
          t('zsh'),
          t('ruby'),
          t('sh'),
        })
      }),
      s('hri', {
        t('--------------------------------------------------------------------------------'),
      }),
      s('fname', {
        f(function()
          return utils.filename()
        end)
      }),
      s('fname:camelcase', {
        f(function()
          return utils.filename({case = 'camelcase'})
        end)
      }),
      s('fname:camelcase:noprefixnumbers', {
        f(function()
          return utils.filename({remove = '^%d*_', case = 'camelcase'})
        end)
      }),
    })
  end
}
