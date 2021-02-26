Diamond = (function() local __laux_nilish_coalescing_var = Diamond if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()
Diamond.Core = (function() local __laux_nilish_coalescing_var = Diamond.Core if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()
Diamond.Network = (function() local __laux_nilish_coalescing_var = Diamond.Network if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()
Diamond.Theme = (function() local __laux_nilish_coalescing_var = Diamond.Theme if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()
Diamond.Animations = (function() local __laux_nilish_coalescing_var = Diamond.Animations if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()

do
	Diamond.Package = {
		name = "Diamond",
		color = Color(233, 83, 120),
		author = "Brique au Bob & DARZ",
		contact = {
			"http://discord.com/users/709064224252624936",
			"http://discord.com/users/307531336388968458"
		},
		root = "diamond"
	}
end

do
	local __lauxi0 = Diamond.Package
	assert(__lauxi0 ~= nil, "cannot destructure nil value")
	local root = __lauxi0.root

	if SERVER then
		AddCSLuaFile(root .. "/classes/loader.lua")
		AddCSLuaFile(root .. "/classes/emitter.lua")
	end

	include(root .. "/classes/loader.lua")
	include(root .. "/classes/emitter.lua")
end

do
	function Diamond:log(...)
		local __lauxi1 = Diamond.Package
		assert(__lauxi1 ~= nil, "cannot destructure nil value")
		local name, color = __lauxi1.name, __lauxi1.color
		local __lauxi2 = Diamond.Core.Loader.logTheme
		assert(__lauxi2 ~= nil, "cannot destructure nil value")
		local text = __lauxi2.text

		MsgC(color, "[" .. tostring(name) .. "] ", SERVER and Color(137, 222, 255) or Color(255, 222, 102), "(" .. (SERVER and "SERVER" or "CLIENT") .. ") ", text, ...)
		Msg("\n")
	end

	Diamond.Core.Emitter:register(Diamond)
	Diamond:emit("loaded")
end

do
	local loader = Diamond.Core.Loader(Diamond.Package)
	loader:addFile("classes/cache", DIAMOND_SHARED)
	loader:addFile("animations/easing/core", DIAMOND_SHARED)
	loader:addDirectory("core", DIAMOND_SHARED)
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
	loader:addDirectory("utilities", DIAMOND_SHARED, {
	realms = {
	["miscellaneous"] = DIAMOND_CLIENT
	}
	})
	loader:addDirectory("animations", DIAMOND_SHARED)
	loader:addDirectory("components", DIAMOND_CLIENT, {
	recursive = true
	})
	loader:finish()
end
