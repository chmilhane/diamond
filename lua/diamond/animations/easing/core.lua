local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local pow = math.pow





local c1 = 1.70158
local c3 = c1 + 1
local c2 = c1 * 1.525
local c4 = (2 * pi) / 3
local c5 = (2 * pi) / 4.5
local n1 = 7.5625
local d1 = 2.75





local cache = Diamond.Cache("Easing")

cache:store("linear", function(x)
    return x
end)

cache:store("inSine", function(x)
    return 1 - cos((x * pi) / 2)
end)

cache:store("outSine", function(x)
    return sin((x * pi) / 2)
end)

cache:store("inOutSine", function(x)
    return -(cos(pi * x) - 1) / 2
end)

cache:store("inQuad", function(x)
    return x * x
end)

cache:store("outQuad", function(x)
    return 1 - (1 - x) * (1 - x)
end)

cache:store("inOutQuad", function(x)
    return x < 0.5 and 2 ^ 3 or 1 - pow(-2 * x + 2, 2) / 2
end)

cache:store("inCubic", function(x)
    return x * x * x
end)

cache:store("outCubic", function(x)
    return 1 - pow(1 - x, 3)
end)

cache:store("inOutCubic", function(x)
    return x < 0.5 and 4 * x * x * x or 1 - pow(-2 * x + 2, 3) / 2
end)

cache:store("inQuart", function(x)
    return x * x * x * x
end)

cache:store("outQuart", function(x)
    return 1 - pow(1 - x, 4)
end)

cache:store("inOutQuart", function(x)
    return x < 0.5 and 8 * x * x * x * x or 1 - pow(-2 * x + 2, 4) / 2
end)

cache:store("inQuint", function(x)
    return x * x * x * x * x
end)

cache:store("outQuint", function(x)
    return 1 - pow(1 - x, 5)
end)

cache:store("inOutQuint", function(x)
    return x < 0.5 and 16 * x * x * x * x * x or 1 - pow(-2 * x + 2, 5) / 2
end)

cache:store("inExpo", function(x)
    return x == 0 and 0 or pow(2, 10 * x - 10)
end)

cache:store("outExpo", function(x)
    return x == 1 and 1 or 1 - pow(2, -10 * x)
end)

cache:store("inOutExpo", function(x)
    return x == 0 and 0 or x == 1 and 1 or x < 0.5 and pow(2, 20 * x - 10) / 2 or (2 - pow(2, -20 * x + 10)) / 2
end)

cache:store("inCirc", function(x)
    return 1 - sqrt(1 - pow(x, 2))
end)

cache:store("outCirc", function(x)
    return sqrt(1 - pow(x - 1, 2))
end)

cache:store("inOutCirc", function(x)
    return x < 0.5 and (1 - sqrt(1 - pow(2 * x, 2))) / 2 or (sqrt(1 - pow(-2 * x + 2, 2)) + 1) / 2
end)

cache:store("inBack", function(x)
    return c3 * x * x * x - c1 * x * x
end)

cache:store("outBack", function(x)
    return 1 + c3 * pow(x - 1, 3) + c1 * pow(x - 1, 2)
end)

cache:store("inOutBack", function(x)
    return x < 0.5 and (pow(2 * x, 2) * ((c2 + 1) * 2 * x - c2)) / 2 or (pow(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2
end)

cache:store("inElastic", function(x)
    return x == 0 and 0 or x == 1 and 1 or -pow(2, 10 * x - 10) * sin((x * 10 - 10.75) * c4)
end)

cache:store("outElastic", function(x)
    return x == 0 and 0 or x == 1 and 1 or pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1
end)

cache:store("inOutElastic", function(x)
    return x == 0 and 0 or x == 1 and 1 or x < 0.5 and -(pow(2, 20 * x - 10) * sin((20 * x - 11.125) * c5)) / 2 or (pow(2, -20 * x + 10) * sin((20 * x - 11.125) * c5)) / 2 + 1
end)

local function outBounce(x)
    if (x < 1 / d1) then
        return n1 * x * x
    elseif (x < 2 / d1) then
        return n1 * (x - 1.5 / d1) * x + 0.75
    elseif (x < 2.5 / d1) then
        return n1 * (x - 2.25 / d1) * x + 0.9375
    else
        return n1 * (x - 2.625 / d1) * x + 0.984375
    end
end
cache:store("outBounce", outBounce)

cache:store("inBounce", function(x)
    return 1 - outBounce(1 - x)
end)

cache:store("inOutBounce", function(x)
    return x < 0.5 and (1 - outBounce(1 - 2 * x)) / 2 or (1 + outBounce(2 * x - 1)) / 2
end)

Diamond.Animations.Ease = cache
