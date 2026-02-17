--[[
 __  __ _             _____             __ _
|  \/  (_)           / ____|           / _(_)
| \  / |_ ___  ___  | |     ___  _ __ | |_ _  __ _
| |\/| | / __|/ __| | |    / _ \| '_ \|  _| |/ _` |
| |  | | \__ \ (__  | |___| (_) | | | | | | | (_| |
|_|  |_|_|___/\___|  \_____\___/|_| |_|_| |_|\__, |
                                              __/ |
                                             |___/
--]]

vim.api.nvim_set_option_value("background", "dark", {}) -- Use a dark background
vim.api.nvim_set_option_value("breakindent", true, {}) -- Preserve tabs when wrapping lines.
vim.opt.completeopt = { "menuone", "noinsert", "noselect" } -- Completion visual settings
vim.api.nvim_set_option_value("concealcursor", "nc", {}) -- Don't unconceal in normal or command mode
vim.api.nvim_set_option_value("cursorline", true, {}) -- Highlight current line
vim.opt.diffopt:append({ "algorithm:histogram", "linematch:60" }) -- Highlight inline diffs
vim.api.nvim_set_option_value("exrc", true, {}) -- Allow project-local config
vim.opt.fillchars = { fold = " ", msgsep = "▔" } -- Set folds to not trail dots
vim.api.nvim_set_option_value("foldlevelstart", 99, {}) -- starting fold level
vim.api.nvim_set_option_value("foldmethod", "indent", {}) -- Set folding to occur from a marker
vim.api.nvim_set_option_value("foldtext", "v:lua.NeatFoldText()", {}) -- Set text of folds
vim.api.nvim_set_option_value("ignorecase", true, {}) -- Case insensitive search by default
vim.api.nvim_set_option_value("inccommand", "split", {}) -- Show regular expression previews in a split
vim.api.nvim_set_option_value("laststatus", 3, {}) -- Only show a statusline at the bottom of the screen
vim.api.nvim_set_option_value("lazyredraw", true, {}) -- Redraw screen less often
vim.api.nvim_set_option_value("linebreak", true, {}) -- Break lines at whole words
vim.api.nvim_set_option_value("number", true, {}) -- Show the current line number
vim.api.nvim_set_option_value("relativenumber", true, {}) -- Line numbers relative to current line
vim.api.nvim_set_option_value("shiftwidth", 0, {}) -- Use tabstop
vim.api.nvim_set_option_value("showmode", false, {}) -- Don't show the mode name under the statusline
vim.api.nvim_set_option_value("showtabline", 0, {}) -- Don't show the tabline until tabline plugins load
vim.api.nvim_set_option_value("smartcase", true, {}) -- Case sensitive when a capital is provided
vim.api.nvim_set_option_value("smartindent", true, {}) -- More intelligent 'autoindent' preset
vim.api.nvim_set_option_value("smoothscroll", true, {}) -- Scroll virtual lines, not logical lines
vim.api.nvim_set_option_value("softtabstop", -1, {}) -- Use shiftwidth
vim.api.nvim_set_option_value("spell", true, {}) -- Check spelling
vim.api.nvim_set_option_value("splitbelow", true, {}) -- Splits open below
vim.api.nvim_set_option_value("splitright", true, {}) -- Splits open to the right
vim.api.nvim_set_option_value("tabstop", 3, {}) -- How many spaces a tab is worth
vim.api.nvim_set_option_value("termguicolors", true, {}) -- Set color mode
vim.api.nvim_set_option_value("undodir", vim.fn.stdpath("state") .. "/undodir", {}) -- Put undo history in the state dir
vim.api.nvim_set_option_value("undofile", true, {}) -- Persist undo history
vim.opt.viewoptions = { "cursor", "folds" } -- Save cursor position and folds in `:mkview`
vim.api.nvim_set_option_value("visualbell", true, {}) -- Disable beeping
vim.opt.wildignore = { "*.bak", "*.cache", "*/.git/**/*", "*.min.*", "*/node_modules/**/*", "*.pyc", "*.swp" }
vim.api.nvim_set_option_value("wildignorecase", true, {}) -- Ignore case for command completions
vim.opt.wildmode = { "longest:full", "full" } -- Command completion mode
vim.api.nvim_set_option_value("winborder", "rounded", {}) -- Use rounded borders

-- WARN: Providers (MUST be `0`, not `false`)
vim.g.loaded_node_provider = 0 -- disable JavaScript
vim.g.loaded_perl_provider = 0 -- disable Perl
vim.g.loaded_python3_provider = 0 -- disable Python 3
vim.g.loaded_ruby_provider = 0 -- disable Ruby
