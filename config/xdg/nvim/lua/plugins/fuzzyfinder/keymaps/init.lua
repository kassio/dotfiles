return {
  setup = function(ffinder)
    require('plugins.fuzzyfinder.keymaps.file').setup(ffinder)
    require('plugins.fuzzyfinder.keymaps.buffer').setup(ffinder)
    require('plugins.fuzzyfinder.keymaps.grep').setup(ffinder)
    require('plugins.fuzzyfinder.keymaps.git').setup(ffinder)
    require('plugins.fuzzyfinder.keymaps.rails').setup(ffinder)
    require('plugins.fuzzyfinder.keymaps.others').setup(ffinder)
  end
}
