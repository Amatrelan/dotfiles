---@class LazyPluginSpec
local Plugin = { "NeogitOrg/neogit" }

Plugin.dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"sindrets/diffview.nvim",
	"ibhagwan/fzf-lua",
}

Plugin.keys = {
	{ "<leader>gg", function() require("neogit").open() end, desc = "NeoGit" }
}

Plugin.opts = true

return Plugin
