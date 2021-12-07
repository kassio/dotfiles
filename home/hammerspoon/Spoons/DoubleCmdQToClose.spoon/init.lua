local obj = {}
obj.__index = obj

obj.name = 'DoubleCmdQToClose'
obj.version = '0.1'
obj.author = 'kassioborges <kassioborgesm@gmail.com>'
obj.homepage = 'https://github.com/kassio/dotfiles'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

local quitModal = hs.hotkey.modal.new('cmd', 'q')

function quitModal:entered()
  local app = hs.application.frontmostApplication()

  hs.alert.show('Press Cmd+Q again to quit ' .. app:title(), 1)
  hs.timer.doAfter(1, function()
    quitModal:exit()
  end)
end

local doQuit = function()
  hs.application.frontmostApplication():kill()
  quitModal:exit()
end

obj.init = function()
  quitModal:bind('cmd', 'q', doQuit)

  quitModal:bind('', 'escape', function()
    quitModal:exit()
  end)
end

return obj
