--- @class iron-e.plugins.tabline.Highlights
local M = {
	--- @type { [iron-e.plugins.tabline.activity]: { [boolean|'sign']: string } }
	by_activity = {
		Alternate = {
			[false] = "BufferAlternate",
			[true] = "BufferAlternateMod",
			["sign"] = "BufferAlternateSign",
		},
		Current = {
			[false] = "BufferCurrent",
			[true] = "BufferCurrentMod",
			["sign"] = "BufferCurrentSign",
		},
		Inactive = {
			[false] = "BufferInactive",
			[true] = "BufferInactiveMod",
			["sign"] = "BufferInactiveSign",
		},
		Visible = {
			[false] = "BufferVisible",
			[true] = "BufferVisibleMod",
			["sign"] = "BufferVisibleSign",
		},
	},
}

return M
