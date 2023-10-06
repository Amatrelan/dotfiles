
local load  = function(mod)
	package.loaded[mod] = nil
	require(mod)
end

load("config.keymaps")
load("config.options")
load("config.commands")
require("config.lazy")


pcall(vim.cmd.colorscheme, "gruvbox")
