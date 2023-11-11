---@class LazyPluginSpec
local Plugin = { "echasnovski/mini.surround" }

Plugin.opts = {
	mappings = {
		add       = "sa",
		delete    = "sd",
		find      = "sf",
		find_left = "sF",
		highlight = "sh",
		replace   = "sr",
	}
}

return Plugin
