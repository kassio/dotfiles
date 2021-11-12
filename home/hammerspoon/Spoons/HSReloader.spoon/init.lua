local obj = {}
obj.__index = obj

obj.name = 'HSReloader'
obj.version = '0.1'
obj.author = 'kassioborges <kassioborgesm@gmail.com>'
obj.homepage = 'https://github.com/kassio/dotfiles'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

local function reloadConfig()
  hs.reload()
  hs.console.clearConsole()
end

obj.init = function()
  hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/',  reloadConfig):start()

  hs.urlevent.bind('hs-reload', function()
    reloadConfig()
  end)
end

return obj
