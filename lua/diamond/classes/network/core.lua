local __cache = {}

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
      if SERVER then util.AddNetworkString(index)end

      local function networkHandler(len, client) end
      net.Receive(index, networkHandler)
    end,
    writeInt = function(self, x)
      local __laux_type = (istable(x) and x.__type and x:__type()) or type(x)
      assert(__laux_type == "number", "Expected parameter `x` to be type `number` instead of `" .. __laux_type .. "`")
      local bits = Diamond.Network:calculateRequiredBits(x, true)
      net.WriteInt(x, bits)
    end,
    writeUInt = function(self, x)
      local __laux_type = (istable(x) and x.__type and x:__type()) or type(x)
      assert(__laux_type == "number", "Expected parameter `x` to be type `number` instead of `" .. __laux_type .. "`")
      local bits = Diamond.Network:calculateRequiredBits(x, false)
      net.WriteUInt(x, bits)
    end,
    register = function(self, index, action)
      local __laux_type = (istable(index) and index.__type and index:__type()) or type(index)
      assert(__laux_type == "number", "Expected parameter `index` to be type `number` instead of `" .. __laux_type .. "`")
    end,
    send = function(self) end,
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
