-- NOTE: msg window is a little awkward right now, since opening the cmd line switches from the popup the pager
require("vim._core.ui2").enable({
	enable = true,
	msg = {
		target = "cmd",
		targets = {
			-- kind
			empty = "cmd",
			bufwrite = "cmd", -- TODO: move to msg after width bug fixed
			confirm = "cmd",
			emsg = "cmd",
			echo = "cmd", -- TODO: move to msg after width bug fixed
			echomsg = "cmd", -- TODO: move to msg after width bug fixed
			echoerr = "cmd",
			completion = "cmd",
			list_cmd = "pager",
			lua_error = "pager",
			lua_print = "cmd", -- TODO: move to msg after width bug fixed
			progress = "cmd", -- TODO: move to msg after width bug fixed
			rpc_error = "cmd",
			quickfix = "cmd",
			search_cmd = "cmd",
			search_count = "cmd",
			shell_cmd = "pager",
			shell_err = "pager",
			shell_out = "pager",
			shell_ret = "cmd", -- TODO: move to msg after width bug fixed
			undo = "cmd",
			verbose = "pager",
			wildlist = "cmd",
			wmsg = "cmd", -- TODO: move to msg after width bug fixed

			-- trigger
			typed_cmd = "cmd",
		},

		msg = {
			height = 0.2,
		},
	},
})
