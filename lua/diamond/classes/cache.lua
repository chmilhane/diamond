local __cache = {}

do
    local _class_0
    local _base_0 = {
        __name = "Diamond.Cache",
        has = function(self, key)
            return __cache[self.name][key] and true or false
        end,
        get = function(self, key)
            if (not key) then
                return __cache[self.name]
            end

            return __cache[self.name][key]
        end,
        store = function(self, key, value)
            __cache[self.name][key] = value
            return self
        end,
        update = function(self, key, value)
            __cache[self.name][key] = value
            return self
        end,
        delete = function(self, key)
            __cache[self.name][key] = nil
            return self
        end,
        __type = function(self)
            return self.__name
        end
    }
    _base_0.__index = _base_0
    _class_0 = setmetatable({
        __init = function(self, name)
            local __laux_type = (istable(name) and name.__type and name:__type()) or type(name)
            assert(__laux_type == "string", "Expected parameter `name` to be type `string` instead of `" .. __laux_type .. "`")
            self.name = name
            __cache[self.name] = (function() local __laux_nilish_coalescing_var = __cache[self.name]if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()
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
    Diamond.Cache = _class_0
end
