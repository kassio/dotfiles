local utils = require('utils.ruby')
local ls = require('luasnip')
local c = ls.choice_node
local f = ls.function_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

return {
  setup = function()
    ls.add_snippets('ruby', {
      s('stub_feature_flags', { t('stub_feature_flags('), i(1), t(')') }),
      s('include_strong_memoize', { t('include ::Gitlab::Utils::StrongMemoize') }),
      s('strong_memoize_attr', { t('strong_memoize_attr :') }),
      s('include_override', { t('extend ::Gitlab::Utils::Override') }),
      s('override', { t('override :') }),
      s('redis_shared_state', { t(':clean_gitlab_redis_shared_state') }),
      s('redis_cache', { t(':clean_gitlab_redis_cache') }),
      s('redis_rate_limit', { t(':clean_gitlab_redis_rate_limiting') }),
      s('prep', {
        f(function()
          return utils.file_namespace() .. '.prepend_mod'
        end)
      }),
      s('feature_category_values', {
        c(1, {
          t('team_planning'),
          t('shared'),
          t('portfolio_management'),
          t('pages'),
          t('wiki')
        }),
      }),
      s('feature_category', {
        t('feature_category: '),
        c(1, {
          t('team_planning'),
          t('shared'),
          t('portfolio_management'),
          t('pages'),
          t('wiki')
        }),
      }),
    })
  end
}
