local SETTINGS = {}

SETTINGS.DefaultAnimationLength = 0.5

SETTINGS.DefaultAnimationEase = function(x)
  return x end

Diamond.Core.Settings = (function() local __laux_nilish_coalescing_var = Diamond.Core.Settings if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return SETTINGS end end)()
