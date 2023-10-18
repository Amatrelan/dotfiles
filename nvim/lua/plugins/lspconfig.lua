---@class LazyPluginSpec
local Plugin = { "neovim/nvim-lspconfig" }
local user = {}

Plugin.dependencies = {
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ "folke/neodev.nvim",                opts = {} },
	{ "nvim-telescope/telescope.nvim" },
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup()
		end
	},
}

Plugin.cmd = {
	"LspInfo", "LspInstall", "LspUninstall"
}

Plugin.event = {
	"BufReadPre", "BufNewFile"
}

function Plugin.init()
	local sign = function(opts)
		vim.fn.sign_define(opts.name, {
			texthl = opts.name,
			text = opts.text,
			numhl = ''
		})
	end

	sign({ name = 'DiagnosticSignError', text = '✘' })
	sign({ name = 'DiagnosticSignWarn', text = '▲' })
	sign({ name = 'DiagnosticSignHint', text = '⚑' })
	sign({ name = 'DiagnosticSignInfo', text = '»' })

	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
		float = {
			border = "rounded",
			source = "always",
		},
	})

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
		vim.lsp.handlers.hover,
		{ border = 'rounded' }
	)

	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = 'rounded' }
	)
end

function Plugin.config()
	local lspconfig = require("lspconfig")
	local lsp_defaults = lspconfig.util.default_config

	lsp_defaults.capabilities = vim.tbl_deep_extend(
		"force",
		lsp_defaults.capabilities,
		require("cmp_nvim_lsp").default_capabilities()
	)

	local group = vim.api.nvim_create_augroup('lsp_cmds', { clear = true })
	vim.api.nvim_create_autocmd('LspAttach', {
		group = group,
		desc = 'LSP actions',
		callback = user.on_attach
	})

	require('mason-lspconfig').setup({
		ensure_installed = {
			"bashls",
			"eslint",
			"html",
			"ltex",
			"lua_ls",
			"pyright",
			"rnix",
			"rust_analyzer",
			"tailwindcss",
			"taplo",
		},

		handlers = {
			function(server)
				lspconfig[server].setup({})
			end,
			["lua_ls"] = function()
				require("plugins.lsp.lua_ls")
			end,
			rust_analyzer = function()
				require("plugins.lsp.rust_analyzer")
			end,
		}
	})
end

function user.on_attach()
	local bufmap = function(mode, lhs, rhs, desc)
		local opts = { buffer = true, desc = "LSP: " .. desc }
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	local builtin = require("telescope.builtin")
	bufmap("n", "gd", builtin.lsp_definitions, "Definitions")
	bufmap("n", "gi", builtin.lsp_implementations, "Implementations")
	bufmap("n", "go", builtin.lsp_type_definitions, "Type definitions")
	bufmap("n", "gr", builtin.lsp_references, "References")
	bufmap("n", "gs", builtin.lsp_document_symbols, "Doc Symbols")
	bufmap("n", "gS", builtin.lsp_workspace_symbols, "Workspace Symbols")
	bufmap("n", "<localleader>d", builtin.diagnostics, "Tele Diagnostics")

	bufmap("n", "K", function() vim.lsp.buf.hover() end, "Hover")
	bufmap("n", "gD", function() vim.lsp.buf.declaration() end, "Declaration")
	bufmap("n", "<localleader>r", function() vim.lsp.buf.rename() end, "Rename")
	bufmap("n", "<localleader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")
	bufmap("n", "<localleader>a", function() vim.lsp.buf.code_action() end, "Code Action")
	bufmap("n", "cd", function() vim.diagnostic.open_float() end, "Diagnostics")
	bufmap("n", "]d", function() vim.diagnostic.goto_next() end, "Next Diagnostic")
	bufmap("n", "[d", function() vim.diagnostic.goto_prev() end, "Prev Diagnostic")
end

return Plugin
