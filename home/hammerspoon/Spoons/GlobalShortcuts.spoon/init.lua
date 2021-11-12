local obj = {}
obj.__index = obj

obj.name = 'GlobalShortcuts'
obj.version = '0.1'
obj.author = 'kassioborges <kassioborgesm@gmail.com>'
obj.homepage = 'https://github.com/kassio/dotfiles'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

local hotkey = function(modifiers, char, callback)
  return hs.hotkey.new(modifiers, char, nil, function()
    local app = hs.application.frontmostApplication()

    callback(app, modifiers, char)
  end, nil, nil)
end

local app_hotkey = function(title, keymap)
  local filter = hs.window.filter.new(title)
  local focused_window = hs.window.focusedWindow()

  if focused_window and focused_window:application():name() == title then
    keymap:enable()
  end

  filter:subscribe(hs.window.filter.windowFocused, function()
    keymap():enable()
  end)
  filter:subscribe(hs.window.filter.windowUnfocused, function()
    keymap():disable()
  end)
end

function obj:init()
  -- Global Menu Hotkey
  hotkey({ 'cmd', 'alt', 'ctrl' }, 'm', function(app)
    app:selectMenuItem({ 'Window', 'Merge All Windows' })
  end):enable()

  -- App Specific Menu Hotkeys
  app_hotkey('Notes', function()
    return hotkey({ 'cmd', 'shift' }, 'S', function(app)
      local hide_path = { 'View', 'Hide Folders' }
      local hide_menu = app:findMenuItem(hide_path)

      if hide_menu and hide_menu.enabled then
        app:selectMenuItem(hide_path)
      else
        app:selectMenuItem({ 'View', 'Show Folders' })
      end
    end)
  end)

  app_hotkey('Preview', function()
    return hotkey({ 'cmd', 'alt', 'ctrl' }, 'i', function(app)
      app:selectMenuItem({ 'Tools', 'Adjust Size...' })
    end)
  end)

  -- Diable cmd+i on Safari
  app_hotkey('Safari', function()
    return hotkey({ 'cmd' }, 'i', function()
      -- no-op
    end)
  end)

  -- Make it harder to quit these apps by requiring a double cmd+q
  local hard_quit_apps = {
    'Safari',
    'iTerm2',
    'Slack'
  }

  for _, title in ipairs(hard_quit_apps) do
    local counter = 0

    local keymap = hotkey({ 'cmd' }, 'q', function(app)
      if counter < 1 then
        hs.alert.show('Press cmd+q again to close '..app:title())
        counter = counter + 1

        -- reset counter after 2 seconds
        hs.timer.doAfter(2, function()
          if counter <= 1 then
            counter = 0
          end
        end)
      else
        counter = 0
        app:kill()
      end
    end)

    app_hotkey(title, function()
      return {
        enable = function()
          counter = 0
          keymap:enable()
        end,
        disable = function()
          counter = 0
          keymap:disable()
        end
      }
    end)
  end
end

return obj
