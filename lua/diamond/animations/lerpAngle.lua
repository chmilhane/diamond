do
  local _class_0
  local _parent_0 = Diamond.AnimationBase
  local _base_0 = {
    __name = "Diamond.Animations.LerpAngle",
    __base = Diamond.AnimationBase.__base,
    onThink = function(self, anim, panel, fraction)
      local __lauxi0 = self.animData
      assert(__lauxi0 ~= nil, "cannot destructure nil value")
      local index, goal = __lauxi0.index, __lauxi0.goal

      local value = (function() local __laux_nilish_coalescing_var = panel[index]if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return Angle()end end)()
      panel[index] = LerpAngle(fraction, value, goal)
    end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__index)
  _class_0 = setmetatable({
    __init = function(self, index, goal, ...)
      local __laux_type = (istable(index) and index.__type and index:__type()) or type(index)
      assert(__laux_type == "string" or __laux_type == "number", "Expected parameter `index` to be type `string|number` instead of `" .. __laux_type .. "`")
      local __laux_type = (istable(goal) and goal.__type and goal:__type()) or type(goal)
      assert(__laux_type == "number", "Expected parameter `goal` to be type `number` instead of `" .. __laux_type .. "`")
      Diamond.Animations.LerpAngle.__parent.__init(self, ...)

      self.animData = {
        index = index,
        goal = goal
      }
    end,
    __base = _base_0,
    __parent = _parent_0
  }, {
    __index = function(cls, parent)
      local val = rawget(_base_0, parent)
      if val == nil then local _parent = rawget(cls, "__parent")
        if _parent then return _parent[parent]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  if _parent_0.__inherited then _parent_0.__inherited(_parent_0, _class_0)
  end
  Diamond.Animations.LerpAngle = _class_0
end
