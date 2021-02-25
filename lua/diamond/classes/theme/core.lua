do
  local _class_0
  local _base_0 = {
    __name = "Diamond.Theme.Core",
    getThemes = function(self)
      return self.themes
    end,
    getTheme = function(self, index)
      if index then
        return (function() local __laux_nilish_coalescing_var = self.themes[index]if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return self.themes end end)()
      end

      return (function() local __laux_nilish_coalescing_var = self.themes[self.active]if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return self.themes end end)()
    end,
    getActive = function(self)
      return self.active
    end,
    setActive = function(self, index)
      local __laux_type = (istable(index) and index.__type and index:__type()) or type(index)
      assert(__laux_type == "string" or __laux_type == "number", "Expected parameter `index` to be type `string|number` instead of `" .. __laux_type .. "`")
      Diamond:emit("themeChanged", self.active, index)
      self.active = index
    end,
    get = function(self, index)
      local __laux_type = (istable(index) and index.__type and index:__type()) or type(index)
      assert(__laux_type == "string" or __laux_type == "number", "Expected parameter `index` to be type `string|number` instead of `" .. __laux_type .. "`")
      local theme = (function() local __laux_nilish_coalescing_var = self:getTheme()if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return self.defaultTheme end end)()
      return (function() local __laux_nilish_coalescing_var = theme[index]if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return color_white end end)()
    end,
    register = function(self, index, content)
      local __laux_type = (istable(index) and index.__type and index:__type()) or type(index)
      assert(__laux_type == "string" or __laux_type == "number", "Expected parameter `index` to be type `string|number` instead of `" .. __laux_type .. "`")
      local __laux_type = (istable(content) and content.__type and content:__type()) or type(content)
      assert(__laux_type == "table", "Expected parameter `content` to be type `table` instead of `" .. __laux_type .. "`")
      content = table.Merge(self.defaultTheme, content)
      self.themes[index] = content
    end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, defaultTheme)
      local __laux_type = (istable(defaultTheme) and defaultTheme.__type and defaultTheme:__type()) or type(defaultTheme)
      assert(__laux_type == "table", "Expected parameter `defaultTheme` to be type `table` instead of `" .. __laux_type .. "`")
      self.themes = {}
      self.defaultTheme = defaultTheme

      self.active = "Default"
      self:setActive(self.active)
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
  Diamond.Theme.Core = _class_0
end

do

  Diamond.ThemeHandler = Diamond.Theme.Core({
    primary = Color(24, 26, 32),
    secondary = Color(28, 30, 38),

    text = {
    highlight = Color(255, 255, 255)
    },

    green = Color(0, 168, 107),
    red = Color(237, 41, 57),

    radius = 3
  })

  Diamond.ThemeHandler:register("Default", {})





end
