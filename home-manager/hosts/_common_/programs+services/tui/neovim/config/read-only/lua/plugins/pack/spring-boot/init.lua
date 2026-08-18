-- DO NOT try to collapse this require into the .setup below.
-- It initializes vim.g.spring_boot, which would override our settings below.
local spring_boot = require("spring_boot")

local path = vim.uv.os_getenv("SPRING_TOOLS_PATH")

local ls_path
if path ~= nil then
	local extension = vim.fs.joinpath(path, "extension")
	ls_path = vim.fs.joinpath(extension, "language-server")
	vim.g.spring_boot.jdt_extensions_path = vim.fs.joinpath(extension, "jars")
end

spring_boot.setup({
	ls_path = ls_path,
})
