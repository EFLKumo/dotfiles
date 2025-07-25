G = {}

G.keymap_opt = { noremap = true, silent = true }

function G.close_empty_buffer()
  local flag = false
  local cleaned = true
  local empties = {}
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    local info = vim.fn.getbufinfo(b)[1]
    if info.loaded == 1 and info.listed == 1 and info.name ~= "" then
      flag = true
    elseif info.loaded == 1 and info.name == "" and info.changed == 0 then
      if flag and not cleaned then
        for e in table do
          G.buf_kill("bd", e, false)
        end
        cleaned = true
      elseif cleaned then
        G.buf_kill("bd", b, false)
      else
        table.insert(empties, b)
      end
    end
  end
  if not flag and #empties == 0 then
    vim.cmd("enew")
  end
end

function G.switch_input_method(req)
  local input_status = tonumber(vim.fn.system("fcitx5-remote"))
  if input_status ~= req then
    vim.fn.system("fcitx5-remote -t")
  end
  return input_status
end

function G.buf_kill(kill_command, bufnr, force)
  kill_command = kill_command or "bd"

  local bo = vim.bo
  local api = vim.api
  local fmt = string.format
  local fn = vim.fn

  if bufnr == 0 or bufnr == nil then
    bufnr = api.nvim_get_current_buf()
  end

  local bufname = api.nvim_buf_get_name(bufnr)

  if not force then
    local choice
    if bo[bufnr].modified then
      choice = fn.confirm(fmt([[Save changes to "%s"?]], bufname), "&Yes\n&No\n&Cancel")
      if choice == 1 then
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("w")
        end)
      elseif choice == 2 then
        force = true
      else
        return
      end
    elseif api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then
      choice = fn.confirm(fmt([[Close "%s"?]], bufname), "&Yes\n&No\n&Cancel")
      if choice == 1 then
        force = true
      else
        return
      end
    end
  end

  -- Get list of windows IDs with the buffer to close
  local windows = vim.tbl_filter(function(win)
    return api.nvim_win_get_buf(win) == bufnr
  end, api.nvim_list_wins())

  if force then
    kill_command = kill_command .. "!"
  end

  -- Get list of active buffers
  local buffers = vim.tbl_filter(function(buf)
    return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
  end, api.nvim_list_bufs())

  -- If there is only one buffer (which has to be the current one), vim will
  -- create a new buffer on :bd.
  -- For more than one buffer, pick the previous buffer (wrapping around if necessary)
  if #buffers > 1 and #windows > 0 then
    for i, v in ipairs(buffers) do
      if v == bufnr then
        local prev_buf_idx = i == 1 and #buffers or (i - 1)
        local prev_buffer = buffers[prev_buf_idx]
        for _, win in ipairs(windows) do
          api.nvim_win_set_buf(win, prev_buffer)
        end
      end
    end
  end

  -- Check if buffer still exists, to ensure the target buffer wasn't killed
  -- due to options like bufhidden=wipe.
  if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
    vim.cmd(string.format("%s %d", kill_command, bufnr))
  end
  return true
end

return G
