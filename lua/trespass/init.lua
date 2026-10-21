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
  vim.api.nvim_set_hl(0, "Trespass", { link = "ErrorMsg", default = true })

  local group = vim.api.nvim_create_augroup(
    "Trespass",
    { clear = false }
  )

  local rx = string.format("\\%%>%dv.\\+", config.column)
  vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    group = group,
    callback = function()
      if not vim.w.trespass_hl_id then
        vim.w.trespass_hl_id = vim.fn.matchadd("Trespass", rx, -1)
      end
    end,
  })
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
