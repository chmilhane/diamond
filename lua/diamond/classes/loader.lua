DIAMOND_SERVER = 1
DIAMOND_CLIENT = 2
DIAMOND_SHARED = 3

local __cache = {}

do
  local _class_0
  local _base_0 = {
    __name = "Diamond.Core.Loader",
    log = function(self, ...)
      local __lauxi0 = self.package
      assert(__lauxi0 ~= nil, "cannot destructure nil value")
      local color, name = __lauxi0.color, __lauxi0.name
      local __lauxi1 = Diamond.Core.Loader.logTheme
      assert(__lauxi1 ~= nil, "cannot destructure nil value")
      local text = __lauxi1.text

      MsgC(color, "[" .. tostring(name) .. "] ", SERVER and Color(137, 222, 255) or Color(255, 222, 102), "(" .. (SERVER and "SERVER" or "CLIENT") .. ") ", text, ...)
      Msg("\n")
    end,
    addFile = function(self, path, realm)
      local __laux_type = (istable(path) and path.__type and path:__type()) or type(path)
      assert(__laux_type == "string", "Expected parameter `path` to be type `string` instead of `" .. __laux_type .. "`")
      local __laux_type = (istable(realm) and realm.__type and realm:__type()) or type(realm)
      assert(__laux_type == "number", "Expected parameter `realm` to be type `number` instead of `" .. __laux_type .. "`")
      local __lauxi2 = self.package
      assert(__lauxi2 ~= nil, "cannot destructure nil value")
      local root = __lauxi2.root

      local filename = string.StripExtension(root .. "/" .. path)
      local action = (function() local __laux_nilish_coalescing_var = Diamond.Core.Loader.realms[realm]if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return Diamond.Core.Loader.realms[DIAMOND_SHARED]end end)()

      local __lauxi3 = Diamond.Core.Loader.logTheme
      assert(__lauxi3 ~= nil, "cannot destructure nil value")
      local skipped, success = __lauxi3.skipped, __lauxi3.success

      if self.loadedFiles[filename] then
        return self:log("\t", "- " .. tostring(filename) .. ": ", skipped, "SKIPPED")
      end
      self.loadedFiles[filename] = true

      action(Diamond.Core.Loader.realms, filename .. ".lua")
      self:log("\t", "- " .. tostring(filename) .. ": ", success, "LOADED")
    end,
    addDirectory = function(self, path, realm, options)
      if options == nil then options = {}
      end
      local __laux_type = (istable(path) and path.__type and path:__type()) or type(path)
      assert(__laux_type == "string", "Expected parameter `path` to be type `string` instead of `" .. __laux_type .. "`")
      local __laux_type = (istable(realm) and realm.__type and realm:__type()) or type(realm)
      assert(__laux_type == "number", "Expected parameter `realm` to be type `number` instead of `" .. __laux_type .. "`")
      local __laux_type = (istable(options) and options.__type and options:__type()) or type(options)
      assert(__laux_type == "table", "Expected parameter `options` to be type `table` instead of `" .. __laux_type .. "`")
      options = table.Merge(Diamond.Core.Loader.defaultOptions, options)

      local __lauxi4 = self.package
      assert(__lauxi4 ~= nil, "cannot destructure nil value")
      local root = __lauxi4.root


      if string.EndsWith(path, "/") then
        local len = #path
        path = string.sub(path, len - 1, len)
      end

      local a, b = file.Find(root .. "/" .. path .. "/*", "LUA")

      for i, v in ipairs(a or {}) do
        local filename = string.StripExtension(v)

        local shouldIgnore = options.filesToIgnore[filename] or options.filesToIgnore[v]
        if (shouldIgnore) then continue end

        local newRealm = options.realms[filename] or options.realms[v]


        self:addFile(path .. "/" .. filename, (function() local __laux_nilish_coalescing_var = newRealm if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return realm end end)())
      end

      for i, v in ipairs(b or {}) do
        if (not options.recursive) then continue end
        self:addDirectory(path .. "/" .. v, realm, options)
      end
    end,
    finish = function(self)
      local __lauxi5 = Diamond.Core.Loader.logTheme
      assert(__lauxi5 ~= nil, "cannot destructure nil value")
      local text, success = __lauxi5.text, __lauxi5.success

      local loadedFiles = table.Count(self.loadedFiles)
      self.endTime = SysTime() - self.startTime

      self:log("Loaded ", success, loadedFiles .. " files ", text, "in ", success, math.Round(self.endTime * 1000, 3) .. " ms", text, ".")
      __cache[#__cache + 1] = self
    end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, package)
      if package == nil then package = {}
      end
      local __laux_type = (istable(package) and package.__type and package:__type()) or type(package)
      assert(__laux_type == "table", "Expected parameter `package` to be type `table` instead of `" .. __laux_type .. "`")
      self.package = table.Merge(Diamond.Core.Loader.defaultPackage, package)
      self.loadedFiles = {}

      self.startTime = SysTime()
      self.endTime = 0

      self:log("Loader initialized, waiting for instructions...")
    end,
    __base = _base_0,
    defaultPackage = {
      name = "Diamond",
      color = Color(233, 83, 120),
      author = "darz.",
      contact = "http://discord.com/users/709064224252624936",
      root = "diamond"
    },
    defaultOptions = {
      recursive = false,
      filesToIgnore = {},
      realms = {}
    },
    logTheme = {
      text = Color(225, 225, 225),

      success = Color(61, 255, 135),
      skipped = Color(231, 128, 124)
    },
    realms = {
      [DIAMOND_SERVER] = function(this, path)
        if SERVER then
          include(path)
        end
      end,

      [DIAMOND_CLIENT] = function(this, path)
        if SERVER then
          AddCSLuaFile(path)
        else
          include(path)
        end
      end,

      [DIAMOND_SHARED] = function(this, path)
        this[DIAMOND_SERVER](this, path)
        this[DIAMOND_CLIENT](this, path)
      end
    },
    getCache = function()
      return __cache
    end
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  Diamond.Core.Loader = _class_0
end
