---@class LazyPluginSpec
local Plugin = { "lewis6991/gitsigns.nvim" }

Plugin.name = "gitsigns"

Plugin.event = { "BufReadPre", "BufNewFile" }

---@type Gitsigns.Config
Plugin.opts = {
	signs = {
		add = { text = '▎' },
		change = { text = '▎' },
		delete = { text = '➤' },
		topdelete = { text = '➤' },
		changedelete = { text = '▎' },
	}
}

return Plugin
