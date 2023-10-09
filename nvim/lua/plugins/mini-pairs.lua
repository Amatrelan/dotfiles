local Plugin = { 'echasnovski/mini.pairs' }

Plugin.version = false

function Plugin.config()
	require("mini.pairs").setup()
end

return Plugin
