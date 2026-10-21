local M = {}

local clear_trespass = function ()
  local ws = vim.api.nvim_list_wins()
  for _, window_id in ipairs(ws) do
    local success, result = pcall(
      vim.api.nvim_win_get_var, window_id, "trespass_hl_id"
    )

    if success then
      vim.fn.matchdelete(result, window_id)
      vim.api.nvim_win_del_var(window_id, "trespass_hl_id")
    end
  end

  pcall(vim.api.nvim_del_augroup_by_name, "Trespass")

end

local handle_enabled = function(config)
  clear_trespass()

  vim.api.nvim_set_hl(0, "Trespass", {
    link = config.color,
    default = true
  })

  local rx = string.format("\\%%>%dv.\\+", config.column)

  local apply_match_with_guard = function(window_id)
    local success = pcall(vim.api.nvim_win_get_var, window_id, "trespass_hl_id")
    if not success then
      local match_id = vim.fn.matchadd(
        "Trespass", rx, config.priority, -1,
        { window = window_id }
      )
      vim.api.nvim_win_set_var(window_id, "trespass_hl_id", match_id)
    end
  end

  local group = vim.api.nvim_create_augroup(
    "Trespass",
    { clear = false }
  )

  vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    group = group,
    callback = function()
      apply_match_with_guard(vim.api.nvim_get_current_win())
    end,
  })

  local ws = vim.api.nvim_list_wins()
  for _, window_id in ipairs(ws) do
    apply_match_with_guard(window_id)
  end
end

M.setup = function(opts)
  local config = require("trespass.config").resolve_config(opts)

  if not config.enabled then
    clear_trespass()
  else
    handle_enabled(config)
  end
end

return M
