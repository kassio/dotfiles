return {
  'andymass/vim-matchup',
  config = function()
    -- vim-matchup plugin, uses treesitter
    -- Do not show the not visible matching context on statusline
    vim.g.matchup_matchparen_offscreen = {}
    vim.g.no_plugin_maps = true
  end
}
