Diamond.Core.Emitter = (function() local __laux_nilish_coalescing_var = Diamond.Core.Emitter if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()

local Emitter = {}
do
	function Emitter:emit(event, ...)
		local __laux_type = (istable(event) and event.__type and event:__type()) or type(event)
		assert(__laux_type == "string" or __laux_type == "number", "Expected parameter `event` to be type `string|number` instead of `" .. __laux_type .. "`")
		if (not self.events[event]) then return end

		local t = self.events[event]
		for i, e in ipairs(t or {}) do
			e(...)
		end
	end

	function Emitter:on(event, action)
		local __laux_type = (istable(event) and event.__type and event:__type()) or type(event)
		assert(__laux_type == "string" or __laux_type == "number", "Expected parameter `event` to be type `string|number` instead of `" .. __laux_type .. "`")
		if (not self.events[event]) then
			self.events[event] = {}
		end





		self.events[event][#self.events[event] + 1] = action
	end

	Emitter.__index = Emitter
end

function Diamond.Core.Emitter:register(t)
	if t == nil then t = {}
	end
	local __laux_type = (istable(t) and t.__type and t:__type()) or type(t)
	assert(__laux_type == "table", "Expected parameter `t` to be type `table` instead of `" .. __laux_type .. "`")
	setmetatable(t, Emitter)
	t.events = (function() local __laux_nilish_coalescing_var = t.events if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()

	return t
end
