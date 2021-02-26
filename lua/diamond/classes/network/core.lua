do
	local _class_0
	local _base_0 = {
		__name = "Diamond.Core.Network",
		setIndex = function(self, index)
			self.index = index
			return self
		end,
		getIndex = function(self)
			return self.index
		end,
		initialize = function(self)
			local index = self:getIndex()
			if SERVER then
				util.AddNetworkString(index)
			end

			local function networkHandler(len, client)
				local key = net.ReadUInt(6)
				local callback = self.cache:get(key)

				client = client or CLIENT and LocalPlayer()
				callback(len, client)
			end
			net.Receive(index, networkHandler)
		end,
		register = function(self, key, callback)
			local __laux_type = (istable(key) and key.__type and key:__type()) or type(key)
			assert(__laux_type == "number", "Expected parameter `key` to be type `number` instead of `" .. __laux_type .. "`")
			self.cache:store(key, callback)
		end,
		send = function(self, key, callback, receiver)
			local __laux_type = (istable(key) and key.__type and key:__type()) or type(key)
			assert(__laux_type == "number", "Expected parameter `key` to be type `number` instead of `" .. __laux_type .. "`")
			local index = self:getIndex()
			net.Start(index)
			net.WriteUInt(key, 6)

			callback(self)

			if SERVER then
				net.Send(receiver)
			else
				net.SendToServer()
			end
		end,
		__type = function(self)
			return self.__name
		end
	}
	_base_0.__index = _base_0
	_class_0 = setmetatable({
		__init = function(self, index)
			local __laux_type = (istable(index) and index.__type and index:__type()) or type(index)
			assert(__laux_type == "string", "Expected parameter `index` to be type `string` instead of `" .. __laux_type .. "`")
			self:setIndex(index)
			self:initialize()

			self.cache = Diamond.Cache("Network." .. tostring(index))
		end,
		__base = _base_0
	}, {
		__index = _base_0,
		__call = function(cls, ...)
			local _self_0 = setmetatable({}, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	Diamond.Core.Network = _class_0
end
