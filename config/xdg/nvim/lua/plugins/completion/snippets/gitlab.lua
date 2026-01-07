local utils = require('plugins.completion.snippets.utils')
local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt
local c = ls.choice_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

local function category_options()
  return c(1, {
    t(':team_planning'),
    t(':shared'),
    t(':portfolio_management'),
    t(':pages'),
    t(':wiki'),
  })
end

return {
  setup = function()
    ls.add_snippets('ruby', {
      s('include_strong_memoize', { t('include ::Gitlab::Utils::StrongMemoize') }),
      s('strong_memoize_attr', { t('strong_memoize_attr :') }),
      s('include_override', { t('extend ::Gitlab::Utils::Override') }),
      s('override', { t('override :') }),
      s('redis_shared_state', { t(':clean_gitlab_redis_shared_state') }),
      s('redis_cache', { t(':clean_gitlab_redis_cache') }),
      s('redis_rate_limit', { t(':clean_gitlab_redis_rate_limiting') }),
      s(
        'stub_feature_flags',
        fmt('stub_feature_flags({cursor}){after}', {
          cursor = i(1),
          after = i(0),
        })
      ),
      s('prep', {
        utils.ruby.type_inline('::', '.prepend_mod'),
      }),
      s('feature_category_values', {
        category_options(),
      }),
      s('feature_category', {
        t('feature_category: '),
        category_options(),
      }),
    })
  end,
}
