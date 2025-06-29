--- @class stenvim.Math
local Math = {}

--- @param n number
--- @return integer rounded `n` to the nearest whole number
function Math.round(n)
	return math.floor(n + 0.5)
end

return Math
