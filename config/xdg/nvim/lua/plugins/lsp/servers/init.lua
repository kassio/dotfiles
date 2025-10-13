return {
  cmd = { 'bundle', 'exec', 'ruby-lsp' },
  settings = {
    init_options = {
      enabled_features = {
        code_actions = true,
        code_lens = true,
        completion = true,
        definition = true,
        diagnostics = true,
        document_highlights = true,
        document_link = true,
        document_symbols = true,
        folding_ranges = true,
        formatting = true,
        hover = true,
        inlay_hint = true,
        on_type_formatting = true,
        selection_ranges = true,
        semantic_highlighting = true,
        signature_help = true,
        type_hierarchy = true,
        workspace_symbol = true,
      },
      features_configuration = {
        inlay_hint = {
          implicit_hash_value = true,
          implicit_rescue = true,
        },
      },
      -- indexing = {
      --   excluded_patterns = { 'path/to/excluded/file.rb' },
      --   included_patterns = { 'path/to/included/file.rb' },
      --   excluded_gems = { 'gem1', 'gem2', 'etc.' },
      --   excluded_magic_comments = { 'compiled:true' },
      -- },
      formatter = 'auto',
      linters = {},
      experimental_features_enabled = true,
    },
  },
}
