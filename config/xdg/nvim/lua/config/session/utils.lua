local M = {
  session_dir = string.format('%s/sessions', vim.fn.stdpath('state')),
  path_replacer = '_',
}

local logger = require('utils').logger('session')

local function format_session_name(str)
  return string.gsub(str, '[/%.]', M.path_replacer)
end

local function escaped_file_path()
  return format_session_name(vim.fn.getcwd())
end

local function prefix_from(path)
  if #path > 0 then
    local filename = string.gsub(path, M.session_dir .. '/', '')
    return vim.split(filename, '+')[1]
  else
    local branch = vim.g['gitsigns_head']
    return format_session_name(vim.fn.fnamemodify(branch, ':t'))
  end
end

local function session_for(prefix)
  return string.format('%s/%s+%s', M.session_dir, prefix, escaped_file_path())
end

local function session_list()
  return vim.fn.glob(session_for('*'), false, true)
end

local function session_options(list)
  local options = {}

  for i, path in ipairs(list) do
    local split = vim.fn.split(path, '/')
    local session = split[#split]
    local prefix = prefix_from(session)
    split = string.format('%s » %s', i, prefix)

    table.insert(options, 1, split)
  end

  table.sort(options)

  return options
end

--- @return string|nil session, boolean exists
local function select_session(title, callback)
  local sessions = session_list()

  if #sessions <= 0 then
    logger.info('no sessions available')
    return nil, false
  end

  local options = session_options(sessions)

  local selected = nil
  vim.ui.select(options, { prompt = title }, function(_choice, index)
    -- confirm returns 0 for <esc>
    -- and the chose choice indexed on 1
    if index == nil or index <= 0 then
      return
    end

    local file = sessions[index]
    if vim.fn.filereadable(file) then
      callback(file)

      selected = file
    end
  end)

  return selected, selected ~= nil
end

local function delete_session(session)
  vim.fn.delete(session, 'rf')
end

local function save_session(prefix, default)
  if string.len(prefix or '') == 0 and string.len(default or '') > 0 then
    prefix = default
  end

  -- All sessions require a prefix
  if string.len(prefix or '') > 0 then
    vim.fn.mkdir(M.session_dir, 'p')

    local session = session_for(prefix)

    vim.api.nvim_set_vvar('this_session', session)

    vim.cmd(string.format('silent! mksession! %s | redraw!', session))
    logger.info(string.format('"%s" saved', prefix))
  else
    logger.error('prefix required!')
  end
end

function M.save()
  local default = prefix_from(vim.api.nvim_get_vvar('this_session'))

  vim.ui.input({
    prompt = 'Choose the session name: ',
    default = default,
  }, function(input)
    if input ~= nil then
      save_session(input, default)
    end
  end)
end

function M.load()
  local session, ok = select_session('Choose a session to load', function(session)
    vim.cmd(string.format('silent! source %s | redraw!', session))
    logger.info(string.format('"%s" loaded', prefix_from(session)))
  end)

  if not ok then
    return
  end

  if not session then
    logger.warn('No sessions available!')
  end
end

function M.destroy()
  return select_session('Choose a session to delete', function(session)
    delete_session(session)
    logger.info(string.format('"%s" deleted', prefix_from(session)))
  end)
end

function M.destroy_all()
  for _, session in ipairs(session_list()) do
    delete_session(session)
  end
end

return M
