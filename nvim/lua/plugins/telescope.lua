---@class LazyPluginSpec
local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.branch = "0.1.x"

Plugin.dependencies = {
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}

Plugin.cmd = { "Telescope" }

function Plugin.init()
	local map = function(mode, lhs, rhs, desc)
		local opts = { desc = "Tele: " .. desc }
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	local builtin = require("telescope.builtin")
	map("n", "<leader>ff", builtin.find_files, "Find Files")
	map("n", "<leader><space>", builtin.buffers, "Find Buffers")
	map("n", "<leader>/", builtin.live_grep, "Live Grep")
	map("n", "<localleader>d", builtin.diagnostics, "Diagnostics")
	map("n", "<leader>fs", builtin.current_buffer_fuzzy_find, "Fuzzy Find (buffer)")
	map("n", "<leader>fh", builtin.help_tags, "Help Tags")
end

function Plugin.config()
	require("telescope").load_extension("fzf")
end

return Plugin
