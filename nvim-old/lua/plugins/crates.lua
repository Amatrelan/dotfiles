local Plugin = { "saecki/crates.nvim" }

Plugin.dependencies = { "nvim-lua/plenary.nvim" }

Plugin.opts = {
	src = {
		cmp = {
			enabled = true
		}
	}
}

function Plugin.config(_, opts)
	require("crates").setup(opts)
end

return Plugin
