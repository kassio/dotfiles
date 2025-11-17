return {
  setup = function()
    require("luasnip").config.setup({ store_selection_keys='<c-s>' })

    require('plugins.completion.snippets.all').setup()
    -- ruby
    require('plugins.completion.snippets.ruby').setup()
    require('plugins.completion.snippets.rails').setup()
    require('plugins.completion.snippets.rspec').setup()
    require('plugins.completion.snippets.gitlab').setup()
    --
  end
}
