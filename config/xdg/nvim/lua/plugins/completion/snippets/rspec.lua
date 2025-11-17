local utils = require('plugins.completion.snippets.utils')
local ls = require('luasnip')
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

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
          after do
            {body}{cursor}
          end
        ]], {
          body = utils.selected_text(),
          cursor = i(0)
        })),
      --
      s('before', fmt([[
          before do
            {body}{cursor}
          end
        ]], {
          body = utils.selected_text(),
          cursor = i(0)
        })),
      --
      s('context', fmt([[
          context {desc} do
            {body}{cursor}
          end
        ]], {
          desc = i(1),
          body = utils.selected_text(),
          cursor = i(0)
        })),
      --
      s('describe', fmt([[
          describe {desc} do
            {body}{cursor}
          end
        ]], {
          desc = i(1),
          body = utils.selected_text(),
          cursor = i(0)
        })),
      --
      s('feature', fmt([[
          feature {desc} do
            {body}{cursor}
          end
        ]], {
          desc = i(1),
          body = utils.selected_text(),
          cursor = i(0)
        })),
      --
      s('scenario', fmt([[
          scenario {desc} do
            {body}{cursor}
          end
        ]], {
          desc = i(1),
          body = utils.selected_text(),
          cursor = i(0)
        })),
      --
      s('it', fmt([[
          it {desc} do
            {body}{cursor}
          end
        ]], {
          desc = i(1),
          body = utils.selected_text(),
          cursor = i(0)
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
          tests = i(0),
        })),
    })
  end
}
