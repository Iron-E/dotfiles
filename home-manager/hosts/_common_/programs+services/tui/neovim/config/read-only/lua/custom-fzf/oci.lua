--- @module 'fzf-lua'

--- @class iron-e.fzf.Oci: fzf-lua.config.Base
--- @field exec_empty_query? boolean
--- @field last_query? string
--- @field image? string
--- @field tags? string[]

--- @alias iron-e.fzf.Oci.Action fun(items: string[], opts: iron-e.fzf.Oci)

local M = {}

--- @param value string
local function yank(value)
	vim.schedule(function()
		vim.fn.setreg("", value)
	end)
end

--- @async
--- @param cmd string[]
local function yank_cmd(cmd)
	vim.system(cmd, {}, function(proc)
		if proc.code ~= 0 then
			vim.notify(proc.stderr, vim.log.levels.WARN)
			return
		end

		yank(vim.trim(proc.stdout))
	end)
end

--- @return nil|string
local function last_yanked()
	local last_yanked = vim.fn.getreg("", nil, true)[1]
	if last_yanked ~= nil then
		return vim.trim(last_yanked)
	end
end

local actions = {
	--- @type iron-e.fzf.Oci.Action
	copy_digest = function(items, opts)
		local tag = items[1]
		local image = (opts.image or opts.last_query) .. ":" .. tag
		yank_cmd({ "crane", "digest", image })
	end,

	--- @type iron-e.fzf.Oci.Action
	copy_tag = function(items, _)
		local tag = items[1]
		yank(tag)
	end,
}

local default_action_bindings = {
	["alt-y"] = actions.copy_tag,
	["alt-Y"] = actions.copy_digest,
}

--- @async
--- @param image_name string
--- @param opts { on_tag: fun(tag: string), on_done: fun(proc: vim.SystemCompleted) }
local function for_each_tag(image_name, opts)
	image_name = vim.fn.shellescape(image_name)
	local cmd = "crane ls --omit-digest-tags " .. image_name .. " | sort -rV"
	vim.system({ "sh", "-c", cmd }, {
		stdout = function(err, data)
			if err ~= nil then
				error(err)
			end

			if data == nil then
				return
			end

			for tag in data:gmatch("(.-)\n") do
				opts.on_tag(tag)
			end
		end,
	}, opts.on_done)
end

--- @async
--- @param image string
--- @param fzf_cb fun(value?: string)
--- @param opts iron-e.fzf.Oci
local function load_fzf_for_each_tag(image, fzf_cb, opts)
	opts.tags = {}
	for_each_tag(image, {
		on_tag = function(tag)
			fzf_cb(tag)
			table.insert(opts.tags, tag)
		end,
		on_done = function()
			fzf_cb()
		end,
	})
end

--- @param opts? iron-e.fzf.Oci
function M.tags(opts)
	opts = opts or {}

	opts.header = "<ctrl-g> to Tag Search"
	opts.winopts = opts.winopts or {}
	opts.winopts.title = " Image Tags "
	opts.actions = vim.tbl_extend("keep", {
		["ctrl-g"] = function(_, _)
			M.live_tags({ image = opts.image, tags = opts.tags })
		end,
	}, default_action_bindings)

	if opts.image == nil or opts.tags == nil then
		--- @param text? string
		local on_confirm = vim.schedule_wrap(function(text)
			if text == nil then
				return
			end

			require("fzf-lua").fzf_exec(function(fzf_cb)
				load_fzf_for_each_tag(text, fzf_cb, opts)
			end, opts)
		end)

		vim.ui.input({ prompt = "Image name", default = last_yanked() }, on_confirm)

		return
	end

	require("fzf-lua").fzf_exec(opts.tags, opts)
end

--- @param opts? iron-e.fzf.Oci
function M.live_tags(opts)
	opts = opts or {}

	local had_tags
	if opts.tags == nil then
		opts.tags = {}
		had_tags = false
	else
		had_tags = true
	end

	if opts.query == nil then
		opts.query = opts.image or last_yanked()
	end

	opts.header = "<ctrl-g> to Fuzzy Search"
	opts.winopts = opts.winopts or {}
	opts.winopts.title = " Image Tags "
	opts.exec_empty_query = false
	opts.actions = vim.tbl_extend("keep", {
		["ctrl-g"] = function(_, o)
			M.tags({ image = o.last_query, tags = opts.tags })
		end,
	}, default_action_bindings)

	require("fzf-lua").fzf_live(
		function(args)
			if had_tags then
				had_tags = false
				return opts.tags
			end

			return function(fzf_cb)
				opts.tags = {}
				load_fzf_for_each_tag(args[1], fzf_cb, opts)
			end
		end,
		--- @diagnostic disable-next-line param-type-mismatch
		opts
	)
end

return M
