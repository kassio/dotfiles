return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
  },
  keys = {
    { '<leader>dbt', vim.cmd.DBUIToggle, desc = 'database: toggle sidebar' },
    { '<leader>dbs', '<Plug>(DBUI_SaveQuery)', desc = 'database: save query' },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_use_nvim_notify = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_win_position = 'right'
    vim.g.db_ui_save_location = '~/.local/share/db_ui'
    vim.g.db_ui_tmp_query_location = '~/.local/share/db_ui'
  end,
}
