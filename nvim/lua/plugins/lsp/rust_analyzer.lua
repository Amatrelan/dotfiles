local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup({
	settings = {
		rust_analyzer = {
			checkOnSave = {
				command = "clippy"
			}
		}
	}
})
