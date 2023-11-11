---@class LazyPluginSpec
local Plugin = { "mfussenegger/nvim-dap" }

Plugin.dependencies = {
	"rcarriga/nvim-dap-ui",
	"williamboman/mason.nvim",
	"jay-babu/mason-nvim-dap.nvim",
}

function Plugin.config()
	local dap = require("dap")
	local dapui = require("dapui")

	require("mason-nvim-dap").setup({
		automatic_setup = true,
		handlers = {},
		ensure_installed = {
			"codelldb"
		}
	})

	vim.keymap.set("n", "<F1>", dap.step_into, { desc = "DAP: Step Into" })
	vim.keymap.set("n", "<F2>", dap.step_over, { desc = "DAP: Step Over" })
	vim.keymap.set("n", "<F3>", dap.step_over, { desc = "DAP: Step Out" })
	vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
	vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
	vim.keymap.set("n", "<leader>dB", function()
		dap.set_breakpoint(vim.fn.input "Breakpoint condigtion: ")
	end, { desc = "DAP: Toggle Breakpoint" })

	dapui.setup {
		-- Set icons to characters that are more likely to work in every terminal.
		--    Feel free to remove or use ones that you like more! :)
		--    Don't feel like these are good choices.
		icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
		controls = {
			icons = {
				pause = '󰏤 ',
				play = '󰐊 ',
				step_into = '󰆹 ',
				step_over = '󰆷 ',
				step_out = ' ',
				step_back = ' ',
				run_last = '󰈑 ',
				terminate = '󰓛',
				disconnect = '󰇪',
			},
		},
	}

	-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
	vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

	dap.listeners.after.event_initialized['dapui_config'] = dapui.open
	dap.listeners.before.event_terminated['dapui_config'] = dapui.close
	dap.listeners.before.event_exited['dapui_config'] = dapui.close
end

return Plugin
