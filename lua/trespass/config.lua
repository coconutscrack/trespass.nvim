local M = {}

local default_config = {
  enabled = true,
  column = 80,
}

M.resolve_config = function(opts)
  local resolved_config = {}

  for key, value in pairs(default_config) do
    resolved_config[key] = value
  end

  if type(opts) == "table" then
    for key, value in pairs(opts) do
      resolved_config[key] = value
    end
  end

  return resolved_config
end

return M
