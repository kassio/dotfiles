local ls = require('luasnip')
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

local function selected_text(_, p)
  return p.env.TM_SELECTED_TEXT
end

return {
  setup = function()
    ls.add_snippets('ruby', {
      s('aggregate_failures', { t(':aggregate_failures') }),
      s('sidekiq_inline', { t(':sidekiq_inline') }),
      s('freeze_time', { t(':freeze_time') }),
      s('ssopen', { t('screenshot_and_open_image') }),
      s('sssave', { t('screenshot_and_save_page') }),
      --
      s('after', fmt([[
          after
            {body}
          end
        ]], {
          body = f(selected_text)
        })),
      --
      s('before', fmt([[
          before
            {body}
          end
        ]], {
          body = f(selected_text)
        })),
      --
      s('context', fmt([[
          context {desc} do
            {body}
          end
        ]], {
          desc = i(1),
          body = f(selected_text)
        })),
      --
      s('describe', fmt([[
          describe {desc} do
            {body}
          end
        ]], {
          desc = i(1),
          body = f(selected_text)
        })),
      --
      s('feature', fmt([[
          feature {desc} do
            {body}
          end
        ]], {
          desc = i(1),
          body = f(selected_text)
        })),
      --
      s('scenario', fmt([[
          scenario {desc} do
            {body}
          end
        ]], {
          desc = i(1),
          body = f(selected_text)
        })),
      --
      s('it', fmt([[
          it {desc} do
            {body}
          end
        ]], {
          desc = i(1),
          body = f(selected_text)
        })),
      --
      s('parameterized', fmt([[
          using RSpec::Parameterized::TableSyntax

          where({fields}) do
            {values}
          end

          with_them do
            {tests}
          end
        ]], {
          fields = i(1),
          values = i(2),
          tests = i(3),
        })),
    })
  end
}
