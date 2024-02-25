local function load(telescope, ext)
  pcall(telescope.load_extension, ext)
end

return {
  setup = function(telescope)
    load(telescope, 'refactoring')
    load(telescope, 'fzf')
    load(telescope, 'notify')
    load(telescope, 'ext')
    load(telescope, 'rails')
  end,
}
