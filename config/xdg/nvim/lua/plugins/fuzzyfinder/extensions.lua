return {
  setup = function(telescope)
    local function load(ext)
      pcall(telescope.load_extension, ext)
    end

    -- extension from plugins
    load('refactoring')
    load('fzf')
    load('notify')
    load('recent_files')
    load('live_grep_args')

    -- local extensions from
    -- lua/telescope/_extensions
    load('ext')
    load('rails')
  end,
}
