-- see if the file exists
local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
local function line_from(file)
  if not file_exists(file) then return {} end
  local f = io.open(file) -- 'r' is unnecessary because it's a default value.
  local line = f:read() -- '*l' is unnecessary because it's a default value.
  f:close()
  return line;
end

local filePath = os.getenv("HOME").."/.cache/dark-mode";
local function updateTheme()
  local line = line_from(filePath);
  if line then
    local dark = string.find(line, "dark");
    if dark then
      vim.cmd("colorscheme nightfox")
    else
      vim.cmd("colorscheme dayfox")
    end
  end
end



updateTheme()
local w = vim.loop.new_fs_event()
w:start(filePath, {}, vim.schedule_wrap(updateTheme))