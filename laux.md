# LAUX

```lua
local hello, world = "Hello", "World"
local message = `${hello} ${world}!`

local prefix = "BobLib"
local x = `[${prefix}] ` --> "[" .. tostring(prefix) .. "]"
```

```lua
class Users
  static async find(id)
    return { money = 500 }
  end
end

local async function hasMoney(id, amt)
  local { money } = Users.find(id)
  return money ?? 0 > amt
end

--[[
  x ??= {} --> if (x == nil) then x = {} end
  x ||= {} --> x = x or {}
]]
```

```lua
local a = { 2, 3 }
local b = { 1, ...a, 4 }
PrintTable(b) -- { 1, 2, 3, 4 }
```

```lua
local Animations = {}

public class AnimationBase
  constructor()

  end
end

public class Animations.Lerp extends AnimationBase
  constructor(...)
    super(...)
  end
end

public class Animations.LerpColor extends AnimationBase
  constructor(...)
    super(...)
  end
end

import
  Lerp,
  LerpColor
from Animations

Lerp(...)
--> Animations.Lerp(...)
```

```lua
--[[
  Les classes publiques disposent d'un type détérminé par son nom :
]]

public class Test

end

--[[
  Son type sera "Test",
  en revanche si la fonction type(Test()) est utilisée,
  cela renvera "table", le type est utilisable uniquement dans les fonctions :
]]

local function HelloWorld(content: Test)

end
```