return function()
	local pairs = require("mini.pairs")
	if _G.MiniPairs == nil then
		_G.MiniPairs = pairs
	end

	pairs.map_buf(0, "i", "(", { action = "open", pair = "()", neigh_pattern = "^[^\\]" })
	pairs.map_buf(0, "i", ")", { action = "close", pair = "()", neigh_pattern = "^[^\\]" })

	pairs.map_buf(0, "i", "[", { action = "open", pair = "[]", neigh_pattern = "^[^\\]" })
	pairs.map_buf(0, "i", "]", { action = "close", pair = "[]", neigh_pattern = "^[^\\]" })

	pairs.map_buf(0, "i", "{", { action = "open", pair = "{}", neigh_pattern = "^[^\\]" })
	pairs.map_buf(0, "i", "}", { action = "close", pair = "{}", neigh_pattern = "^[^\\]" })
end
