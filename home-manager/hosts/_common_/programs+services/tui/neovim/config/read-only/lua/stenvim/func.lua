--- @class stenvim.Func
local Func = {}

--- @generic T
--- @generic U
--- @param fn fun(...: any): T
--- @param cb fun(t: T): U
--- @return fun(...: any): U
function Func.map(fn, cb)
	return function(...)
		local result = fn(...)
		return cb(result)
	end
end

return Func
