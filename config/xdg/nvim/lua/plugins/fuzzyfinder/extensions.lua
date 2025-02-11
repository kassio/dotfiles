local function load(telescope, ext)
  pcall(telescope.load_extension, ext)
end

return {
  setup = function(telescope)
    -- extension from plugins
    load(telescope, 'refactoring')
    load(telescope, 'fzf')
    load(telescope, 'notify')
    load(telescope, 'recent_files')

    -- local extensions from
    -- lua/telescope/_extensions
    load(telescope, 'ext')
    load(telescope, 'rails')
  end,
}
