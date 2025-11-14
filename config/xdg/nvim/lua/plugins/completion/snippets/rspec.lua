local ls = require('luasnip')
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
      s('after', {
        t({'after do', ''}),
        i(0),
        t({'', 'end'})
      }),
      s('before', {
        t({'before do', ''}),
        i(0),
        t({'', 'end'})
      }),
      s('context', {
        t('context '), i(1), t({' do', ''}),
        i(0),
        t({'', 'end'})
      }),
      s('describe', {
        t('describe '), i(1), t({' do', ''}),
        i(0),
        t({'', 'end'})
      }),
      s('feature', {
        t('feature '), i(1), t({' do', ''}),
        i(0),
        t({'', 'end'})
      }),
      s('scenario', {
        t('scenario '), i(1), t({' do', ''}),
        i(0),
        t({'', 'end'})
      }),
      s('it', {
        t('it '), i(1), t({' do', ''}),
        i(0),
        t({'', 'end'})
      }),
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
