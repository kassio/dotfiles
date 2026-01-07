local utils = require('plugins.completion.snippets.utils')
local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt
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
      s('class', utils.ruby.type_block('class')),
      s('module', utils.ruby.type_block('module')),
      --
      s(
        'begin',
        fmt(
          [[
          begin do
            {body}{cursor}
          end
        ]],
          {
            body = utils.selected_text(),
            cursor = i(0),
          }
        )
      ),
      --
      s(
        'def',
        fmt(
          [[
          def {name}
            {body}{cursor}
          end
        ]],
          {
            name = i(1),
            body = utils.selected_text(),
            cursor = i(0),
          }
        )
      ),
      --
      s(
        'do',
        fmt(
          [[
          do
            {body}{cursor}
          end
        ]],
          {
            body = utils.selected_text(),
            cursor = i(0),
          }
        )
      ),
      --
      s(
        'dop',
        fmt(
          [[
          do |{args}|
            {body}{cursor}
          end
        ]],
          {
            args = i(1),
            body = utils.selected_text(),
            cursor = i(0),
          }
        )
      ),
    })
  end,
}
