return {
  setup = function()
    require('plugins.completion.snippets.all').setup()
    require('plugins.completion.snippets.ruby').setup()
    require('plugins.completion.snippets.rails').setup()
    require('plugins.completion.snippets.rspec').setup()
    require('plugins.completion.snippets.gitlab').setup()
  end
}
