local ls = require('luasnip')
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

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
      s('it', block(t('it'))),
      s('before', block(t('before do'))),
      s('context', block(t('context '), i(1), t(' do'))),
      s('describe', block(t('describe '), i(1), t(' do'))),
      s('scenario', block(t('scenario '), i(1), t(' do'))),
      s('feature', block(t('feature '), i(1), t(' do'))),
      s('aggregate_failures', { t(':aggregate_failures') }),
      s('sidekiq_inline', { t(':sidekiq_inline') }),
      s('freeze_time', { t(':freeze_time') }),
      s('ssopen', { t('screenshot_and_open_image') }),
      s('sssave', { t('screenshot_and_save_page') }),
      s('parameterized', { t({
        'using RSpec::Parameterized::TableSyntax',
        '',
        'where() do',
        'end',
        '',
        'with_them do',
        'end'
      })}),
    })
  end
}
