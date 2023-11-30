local cmp = require("cmp")

local Plugins = {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"rust-analyzer",
				"taplo",
				-- Python
				"pyright",
				"ruff-lsp",
				"mypy",
				"debugpy",
				-- Lua
				"stylua",
				-- random
				"efm",
				"ltex-ls",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"bash",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"json",
				"json5",
				"lua",
				"markdown",
				"markdown_inline",
				"nix",
				"python",
				"regex",
				"rust",
				"org",
			},
		},
	},
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g", "," },
	},
	{
		"folke/todo-comments.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"creativenull/efmls-configs-nvim",
		},
		config = function()
			require("custom.configs.lspconfig")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local default = require("plugins.configs.telescope")
			require("telescope").setup(default)
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = "neovim/nvim-lspconfig",
		opts = function()
			return require("custom.configs.rust-tools")
		end,
		config = function(_, opts)
			require("rust-tools").setup(opts)
		end,
	},
	{
		"saecki/crates.nvim",
		ft = { "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
			-- cmp.setup.buffer({
			--   sources = { { name = "crates" } },
			-- })
			crates.show()
			require("core.utils").load_mappings("crates")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("core.utils").load_mappings("dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function(_, _)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
			require("core.utils").load_mappings("dap_python")
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = false,
		config = function(_, opts)
			require("nvim-dap-virtual-text").setup(opts)
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local M = require("plugins.configs.cmp")
			M.completion.completeopt = "menu,menuone,noselect"
			M.mapping["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = false,
			})
			M.view = {
				docs = {
					auto_open = false,
				},
			}
			table.insert(M.sources, { name = "crates" })
			return M
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"NeogitOrg/neogit",
		keys = { "<leader>gg" },
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = function()
			require("neogit").setup()
			require("core.utils").load_mappings("neogit")
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		config = function()
			require("git-conflict").setup()
		end,
	},
	{
		"sindrets/diffview.nvim", -- optional
		lazy = false,
	},
	{
		"LhKipp/nvim-nu",
		lazy = false,
		build = "TSInstall nu",
		config = function()
			require("nu").setup({
				use_lsp_features = false,
			})
		end,
	},
	{
		"nvim-orgmode/orgmode",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		event = "VeryLazy",
		config = function()
			require("orgmode").setup_ts_grammar()

			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "org" },
				},
			})

			local org_root = "~/org/"

			require("orgmode").setup({
				org_agenda_files = "~/org/**/*",
				org_default_notes_file = org_root .. "/refile.org",

				org_capture_templates = {
					w = {
						description = "Work",
						subtemplates = {
							j = {
								description = "journal",
								template = "\n*** %<%T>\n\n%?",
								target = org_root .. "work/journal/%<%Y-%m-%d>.org",
							},
							t = {
								description = "todo",
								template = "\n*** TODO %?\n%a",
								target = org_root .. "work/todo.org",
							},
						},
					},
					p = {
						description = "Personal",
						subtemplates = {
							j = {
								description = "journal",
								template = "\n*** %<%T>\n\n%?",
								target = org_root .. "journal/%<%Y-%m-%d>.org",
							},
							t = {
								description = "todo",
								template = "\n*** TODO %?\n%a",
								target = org_root .. "todo.org",
							},
						},
					},
				},
			})
		end,
	},
}

return Plugins
