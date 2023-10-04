---@class LazyPluginSpec
local Plugin = { "hrsh7th/nvim-cmp" }

Plugin.dependencies = {
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-nvim-lsp-signature-help' },
	{ 'L3MON4D3/LuaSnip' },
	{ 'rafamadriz/friendly-snippets' },
	{ 'onsails/lspkind.nvim' },
}

Plugin.event = "InsertEnter"

function Plugin.config()
	vim.opt.completeopt = { "menu", "menuone", "noselect" }

	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local lspkind = require("lspkind")

	require("luasnip.loaders.from_vscode").lazy_load()

	local select_opts = { behaviour = cmp.SelectBehavior.Select }

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end
		},

		preselect = cmp.PreselectMode.None,

		sources = {
			{ name = "path" },
			{ name = "nvim_lsp" },
			{ name = "buffer",                     keyword_length = 3 },
			{ name = "luasnip",                    keyword_length = 2 },
			{ name = "cmp-nvim-lsp-signature-help" },
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		formatting = {
			fields = { "abbr", "menu", "kind" },
			format = lspkind.cmp_format({
				mode = "symbol",
				maxwidth = 25,
				ellipsis_char = "…"
				--- before = function(entry, vim_item)
				--- end
			})
		},

		mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
			["<C-n>"] = cmp.mapping.select_next_item(select_opts),

			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<CR>"] = cmp.mapping.confirm({select = false}),
			["<Tab>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(1) then
					luasnip.jump(1)
				elseif cmp.visible() then
					cmp.complete({ select = true })
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}
	})
end

return Plugin
