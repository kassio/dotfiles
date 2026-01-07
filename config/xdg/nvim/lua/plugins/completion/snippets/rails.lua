local ls = require('luasnip')
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

return {
  setup = function()
    ls.add_snippets('ruby', {
      s('pa', { t('params['), i(0), t(']') }),
      s('anaf', { t('accepts_nested_attributes_for ') }),
      s('bt', { t('belongs_to ') }),
      s('habtm', { t('has_and_belongs_to_many ') }),
      s('hmany', { t('has_many ') }),
      s('hone', { t('has_one ') }),
      s('active_record_logger', { t('ActiveRecord::Base.logger = Logger.new($stdout)') }),
      s('extend_concern', { t('extend ActiveSupport::Concern') }),
    })
  end,
}
