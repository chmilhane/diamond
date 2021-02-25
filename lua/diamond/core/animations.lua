do
  local _class_0
  local _base_0 = {
    __name = "Diamond.AnimationBase",
    setPanel = function(self, panel)
      self.panel = panel
      return self
    end,
    getPanel = function(self)
      return self.panel
    end,
    onThink = function(self) end,
    onEnd = function(self) end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, panel, duration, callback, easeFunction)
      local __laux_type = (istable(panel) and panel.__type and panel:__type()) or type(panel)
      assert(__laux_type == "Panel", "Expected parameter `panel` to be type `Panel` instead of `" .. __laux_type .. "`")
      duration = (function() local __laux_nilish_coalescing_var = duration if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return Diamond.Core.Settings.DefaultAnimationLength end end)()
      easeFunction = (function() local __laux_nilish_coalescing_var = easeFunction if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return Diamond.Core.Settings.DefaultEaseFunction end end)()

      local anim = panel:NewAnimation(duration)
      self:setPanel(panel)

      anim.Think = function(anim, panel, fraction)
        if (easeFunction and isfunction(easeFunction)) then
          fraction = easeFunction(fraction)
        end

        self:onThink(anim, panel, fraction)
      end

      anim.OnEnd = function(...)
        if (callback and isfunction(callback)) then
          callback(...)
        end

        self:onEnd(...)
      end
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
  Diamond.AnimationBase = _class_0
end
