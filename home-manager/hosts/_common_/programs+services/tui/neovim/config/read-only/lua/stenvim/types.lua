--- @class vim.ui.input.opts
--- @field prompt? string
--- @field _prompt_width integer (for internal use by stenvim)
--- @field default? string
--- @field completion vim.ui.input.completion
--- @field highlight vim.ui.input.highlight

--- @alias vim.ui.input.completion nil|string

--- @alias vim.ui.input.highlight nil|fun(text: string): [integer, integer, string][]

--- @alias vim.ui.input.on_confirm fun(text?: string)
