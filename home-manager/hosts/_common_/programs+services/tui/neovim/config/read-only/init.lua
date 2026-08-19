--[[
 ___       _ _
|_ _|_ __ (_) |_
 | || '_ \| | __|
 | || | | | | |_
|___|_| |_|_|\__|
--]]

vim.loader.enable()

-- Environment
require("init/filetype")

-- Config
require("init/config")

require("init/autocmds")
require("init/commands")
require("init/functions")
require("init/mappings")

require("init/treesitter")

-- Plugins
require("plugins")

-- LSP last, since its config can depend on plugins
if not _G.__iron_e_startup_for_manpage then
	require("init/diagnostics") -- does not depend on plugins, but at least there's only one branch here now
	require("init/lsp")
end
