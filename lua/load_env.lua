local function load_env_file(env_file)
  local env = {}
  for line in io.lines(env_file) do
    local key, value = line:match("([^=]+)=(.+)")
    if key and value then
      -- Remove quotes if present
      value = value:match("^['\"](.-)['\"]$") or value
      vim.fn.setenv(key, value)
      env[key] = value
      print(vim.fn.getcwd())  -- Shows the current working directory
      print(env_file)  -- Shows the current working directory
    end
  end
  return env
end

