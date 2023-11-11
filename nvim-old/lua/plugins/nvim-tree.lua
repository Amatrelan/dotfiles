---@class LazyPluginSpec
local Plugin = { 'kyazdani42/nvim-tree.lua' }

Plugin.name = 'nvim-tree'

Plugin.cmd = { 'NvimTreeToggle' }

Plugin.opts = {
	actions = {
		open_file = {
			quit_on_open = true,
		}
	},
	hijack_cursor = false,
}

function Plugin.init()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
	vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
end

return Plugin
