local obj = {}
obj.__index = obj

obj.name = 'HSConsole'
obj.version = '0.1'
obj.author = 'kassioborges <kassioborgesm@gmail.com>'
obj.homepage = 'https://github.com/kassio/dotfiles'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

obj.init = function()
  hs.urlevent.bind('hs-console-open', function()
    hs.openConsole()
  end)

  hs.urlevent.bind('hs-console-clear', function()
    hs.console.clearConsole()
  end)
end

return obj
