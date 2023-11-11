local Plugin = { "lhKipp/nvim-nu" }

function Plugin.config()
	require("nu").setup({
		use_lsp_features = false,
	})
end

return Plugin
