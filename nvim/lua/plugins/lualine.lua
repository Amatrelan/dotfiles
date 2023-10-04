---@class LazyPluginSpec
local Plugin = { "nvim-lualine/lualine.nvim" }

Plugin.name = "lualine"

Plugin.event = "VeryLazy"

Plugin.opts = {
	options = {
		-- theme = "catppuccin",
		icons_enabled = true,
		component_seperators = "|",
		section_separators = "",
		disabled_filetypes = {
			statusline = { "NvimTree" }
		}
	}
}

function Plugin.init()
	vim.opt.showmode = false
end

return Plugin
