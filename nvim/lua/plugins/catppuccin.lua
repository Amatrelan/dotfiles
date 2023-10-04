---@class LazyPluginSpec
local Plugin = { "catppuccin/nvim" }
Plugin.priority = 1000
Plugin.name = "catppuccin"

---@type CatppuccinOptions
Plugin.opts = {
	-- transparent_background = true,
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		markdown = true,
		mason = true,
		dap = {
			enabled = true,
			enable_ui = true
		},
	}
}

return Plugin
