local luasnip = require('luasnip')

return {
  setup = function()
    luasnip.config.setup({
      store_selection_keys = '<c-s>',
    })

    vim.keymap.set({ 'i', 's' }, '<c-j>', function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      else
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes('<c-j>', true, false, true),
          'n',
          false
        )
      end
    end)

    require('plugins.completion.snippets.all').setup()
    -- ruby
    require('plugins.completion.snippets.ruby').setup()
    require('plugins.completion.snippets.rails').setup()
    require('plugins.completion.snippets.rspec').setup()
    require('plugins.completion.snippets.gitlab').setup()
    -- elixir
    require('plugins.completion.snippets.elixir').setup()
  end,
}
