---@class LazyPluginSpec
local Plugin = { "nvim-treesitter/nvim-treesitter" }

Plugin.dependencies = {
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{
		"luckasRanarison/tree-sitter-hypr",
		config = function()
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.hypr = {
				install_info = {
					url = "https://github.com/luckasRanarison/tree-sitter-hypr",
					files = { "src/parser.c" },
					branch = "master",
				},
				filetype = "hypr",
			}
		end
	}
}

Plugin.opts = {
	highlight = {
		enable = true
	},

	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ai"] = "@class.inner",
			}
		}
	},
	ensure_installed = {
		"javascript",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"rust",
		"toml",
		"vim",
		"vimdoc",
		"yuck",
	}
}

function Plugin.config(name, opts)
	require("nvim-treesitter.configs").setup(opts)
end

return Plugin
