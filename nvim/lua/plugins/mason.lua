---@class LazyPluginSpec
local Plugin = { "williamboman/mason.nvim" }

Plugin.lazy = false

--- @class MasonSettings
Plugin.opts = {
	ui = { border = "rounded" }
}

return Plugin
