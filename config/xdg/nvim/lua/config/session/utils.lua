local M = {
  session_dir = string.format('%s/sessions', vim.fn.stdpath('state')),
  path_replacer = '_',
}

local escaped_file_path = string.gsub(vim.fn.getcwd(), '[/%.]', M.path_replacer)

local function notify(msg, level)
  vim.notify(msg, level, { title = 'Session Manager' })
end

local function info(msg)
  notify(msg, vim.log.levels.INFO)
end

local function warn(msg)
  notify(msg, vim.log.levels.WARN)
end

local function error(msg)
  notify(msg, vim.log.levels.ERROR)
end

local function prefix_from(session)
  session = vim.fn.split(session or '', '/')

  if #session > 0 then
    session = session[#session]

    return vim.fn.split(session, '+')[1]
  else
    return ''
  end
end

local function session_for(prefix)
  return string.format('%s/%s+%s', M.session_dir, prefix, escaped_file_path)
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

-- returns: session file, ok
-- session file: string
-- ok: if a session was selected
local function select_session(title, callback)
  local sessions = session_list()

  if #sessions <= 0 then
    return
  end

  local options = session_options(sessions)

  vim.ui.select(options, { prompt = title }, function(_choice, index)
    -- confirm returns 0 for <esc>
    -- and the chose choice indexed on 1
    if index == nil or index <= 0 then
      return nil, false
    end

    local file = sessions[index]
    if vim.fn.filereadable(file) then
      callback(file)

      return file, true
    end
  end)
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
    info(string.format('Session "%s" created', prefix))
  else
    error('Session prefix required!')
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
  local session, ok = select_session('Available sessions', function(session)
    vim.cmd(string.format('silent! source %s | redraw!', session))
    info(string.format('Session "%s" loaded', prefix_from(session)))
  end)

  if not ok then
    return
  end

  if not session then
    warn('No sessions available!')
  end
end

function M.destroy()
  return select_session('Existing sessions', function(session)
    delete_session(session)
    error(string.format('Session "%s" deleted', prefix_from(session)))
  end)
end

function M.destroy_all()
  for _, session in ipairs(session_list()) do
    delete_session(session)
  end
end

return M
