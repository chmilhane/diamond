function Diamond.Network:CalculateRequiredBits(value, signed)
	if signed == nil then signed = false
	end
	local __laux_type = (istable(value) and value.__type and value:__type()) or type(value)
	assert(__laux_type == "number", "Expected parameter `value` to be type `number` instead of `" .. __laux_type .. "`")
	local __laux_type = (istable(signed) and signed.__type and signed:__type()) or type(signed)
	assert(__laux_type == "boolean", "Expected parameter `signed` to be type `boolean` instead of `" .. __laux_type .. "`")
	return math.max(math.ceil(math.log(value) / math.log(2)) + (signed and 1 or 0), 1)
end

function Diamond.Network:WriteTable(content)
	if content == nil then content = {}
	end
	local __laux_type = (istable(content) and content.__type and content:__type()) or type(content)
	assert(__laux_type == "table", "Expected parameter `content` to be type `table` instead of `" .. __laux_type .. "`")
	local data = util.Compress(util.TableToJSON(content))
	local length = #data
	net.WriteUInt(length, 32)
	net.WriteData(data, length)
end

function Diamond.Network:ReadTable()
	local length = net.ReadUInt(32)
	return util.JSONToTable(util.Decompress(net.ReadData(length)))
end
