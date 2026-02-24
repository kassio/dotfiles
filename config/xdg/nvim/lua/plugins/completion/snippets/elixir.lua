local utils = require('plugins.completion.snippets.utils')
local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

return {
  setup = function()
    ls.add_snippets('elixir', {
      s(
        'def',
        fmt(
          [[
          def {name} do
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
    })
  end,
}
