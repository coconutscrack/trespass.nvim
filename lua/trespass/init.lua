local M = {}

M.setup = function()
  vim.api.nvim_set_hl(0, "Trespass", { link = "ErrorMsg", default = true })

  local group = vim.api.nvim_create_augroup(
    "Trespass",
    { clear = true }
  )
  vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    group = group,
    callback = function()
      if not vim.w.trespass_hl_id then
        vim.w.trespass_hl_id = vim.fn.matchadd("Trespass", '\\%>80v.\\+', -1)
      end
    end,
  })
end

return M
