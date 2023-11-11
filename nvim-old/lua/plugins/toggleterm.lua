---@class LazyPluginSpec
local Plugin = { "akinsho/toggleterm.nvim" }

Plugin.name = "toggleterm"

Plugin.keys = { "<C-g>" }

---@type ToggleTermConfig
Plugin.opts = {
	open_mapping = "<C-g>",
	direction = "horizontal",
	shade_terminals = true
}

return Plugin
