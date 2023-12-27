local on_attach = require("custom.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local options = {
	server = {
		on_attach = on_attach,
		capabilities = capabilities,

		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					allFeatures = true,
					overrideCommand = {
						"cargo",
						"clippy",
						"--workspace",
						"--message-format=json",
						"--all-targets",
						"--all-features",
					},
				},
			},
		},
	},
}

return options
