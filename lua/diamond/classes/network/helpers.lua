function Diamond.Network:calculateRequiredBits(value, signed)
	if signed == nil then signed = false
	end
	local __laux_type = (istable(value) and value.__type and value:__type()) or type(value)
	assert(__laux_type == "number", "Expected parameter `value` to be type `number` instead of `" .. __laux_type .. "`")
	local __laux_type = (istable(signed) and signed.__type and signed:__type()) or type(signed)
	assert(__laux_type == "boolean", "Expected parameter `signed` to be type `boolean` instead of `" .. __laux_type .. "`")
	return math.max(math.ceil(math.log(value) / math.log(2)) + (signed and 1 or 0), 1)
end
