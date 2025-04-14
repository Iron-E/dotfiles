--[[
 ___       _ _
|_ _|_ __ (_) |_
 | || '_ \| | __|
 | || | | | | |_
|___|_| |_|_|\__|
--]]

vim.loader.enable()

-- Environment
require 'init/filetype'

-- Config
require 'init/config'

require 'init/diagnostics'
require 'init/lsp'

require 'init/autocmds'
require 'init/commands'
require 'init/functions'

require 'init/mappings'

-- Plugins
require 'init/lazy'
