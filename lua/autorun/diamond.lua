Diamond = (function() local __laux_nilish_coalescing_var = Diamond if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()
Diamond.root = "diamond"

Diamond.Core = (function() local __laux_nilish_coalescing_var = Diamond.Core if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()
Diamond.Network = (function() local __laux_nilish_coalescing_var = Diamond.Network if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()
Diamond.Theme = (function() local __laux_nilish_coalescing_var = Diamond.Theme if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()
Diamond.Animations = (function() local __laux_nilish_coalescing_var = Diamond.Animations if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()

do
	assert(Diamond ~= nil, "cannot destructure nil value")
	local root = Diamond.root

	if SERVER then
		AddCSLuaFile(root .. "/classes/loader.lua")
		AddCSLuaFile(root .. "/classes/emitter.lua")
	end

	include(root .. "/classes/loader.lua")
	include(root .. "/classes/emitter.lua")
end

Diamond.Core.Emitter:register(Diamond)
Diamond:emit("loaded")

do
	local loader = Diamond.Core.Loader()
	loader:addDirectory("core", DIAMOND_SHARED, {
	realms = {
	["resources"] = DIAMOND_SERVER
	}
	})
	loader:addDirectory("classes", DIAMOND_SHARED, {
		recursive = true,
		filesToIgnore = {
			["loader"] = true,
			["emitter"] = true
		}
	})
	loader:addDirectory("libraries", DIAMOND_SHARED, {
	realms = {
	["shadows"] = DIAMOND_CLIENT
	}
	})
	loader:addDirectory("utilities", DIAMOND_SHARED)
	loader:addDirectory("animations", DIAMOND_SHARED)
	loader:addDirectory("components", DIAMOND_CLIENT)
	loader:finish()
end
