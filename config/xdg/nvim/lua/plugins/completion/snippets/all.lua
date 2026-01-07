local utils = require('plugins.completion.snippets.utils')
local ls = require('luasnip')
local c = ls.choice_node
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
        }),
      }),
      s('hri', {
        t('--------------------------------------------------------------------------------'),
      }),
      s('fname', {
        utils.filename(),
      }),
      s('fname:camelcase', {
        utils.filename({ case = 'camelcase' }),
      }),
      s('fname:camelcase:noprefixnumbers', {
        utils.filename({ remove = '^%d*_', case = 'camelcase' }),
      }),
    })
  end,
}
