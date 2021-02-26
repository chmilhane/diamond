function Diamond:MaskStencil(mask, rendering, invert)
    if invert == nil then invert = false
    end
    local __laux_type = (istable(invert) and invert.__type and invert:__type()) or type(invert)
    assert(__laux_type == "boolean", "Expected parameter `invert` to be type `boolean` instead of `" .. __laux_type .. "`")
    render.ClearStencil()
    render.SetStencilEnable(true)

    render.SetStencilWriteMask(1)
    render.SetStencilTestMask(1)

    render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
    render.SetStencilPassOperation(invert and STENCILOPERATION_REPLACE or STENCILOPERATION_KEEP)
    render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
    render.SetStencilReferenceValue(1)

    mask()

    render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
    render.SetStencilPassOperation(invert and STENCILOPERATION_REPLACE or STENCILOPERATION_KEEP)
    render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
    render.SetStencilReferenceValue(invert and 0 or 1)

    rendering(self, w, h)

    render.SetStencilEnable(false)
    render.ClearStencil()
end

local cache = Diamond.Cache("Circles")
function Diamond:DrawCircle(x, y, radius, color, angleStart, angleEnd, shouldDraw)
    if x == nil then x = 0
    end
    if y == nil then y = 0
    end
    if radius == nil then radius = 0
    end
    if angleStart == nil then angleStart = 0
    end
    if angleEnd == nil then angleEnd = 360
    end
    if shouldDraw == nil then shouldDraw = false
    end
    local __laux_type = (istable(x) and x.__type and x:__type()) or type(x)
    assert(__laux_type == "number", "Expected parameter `x` to be type `number` instead of `" .. __laux_type .. "`")
    local __laux_type = (istable(y) and y.__type and y:__type()) or type(y)
    assert(__laux_type == "number", "Expected parameter `y` to be type `number` instead of `" .. __laux_type .. "`")
    local __laux_type = (istable(radius) and radius.__type and radius:__type()) or type(radius)
    assert(__laux_type == "number", "Expected parameter `radius` to be type `number` instead of `" .. __laux_type .. "`")
    local __laux_type = (istable(angleStart) and angleStart.__type and angleStart:__type()) or type(angleStart)
    assert(__laux_type == "number", "Expected parameter `angleStart` to be type `number` instead of `" .. __laux_type .. "`")
    local __laux_type = (istable(angleEnd) and angleEnd.__type and angleEnd:__type()) or type(angleEnd)
    assert(__laux_type == "number", "Expected parameter `angleEnd` to be type `number` instead of `" .. __laux_type .. "`")
    local __laux_type = (istable(shouldDraw) and shouldDraw.__type and shouldDraw:__type()) or type(shouldDraw)
    assert(__laux_type == "boolean", "Expected parameter `shouldDraw` to be type `boolean` instead of `" .. __laux_type .. "`")
    local cachePath = x .. y .. radius .. angleStart .. angleEnd
    if shouldDraw and cache:has(cachePath) then
        local poly = cache:get(cachePath)

        draw.NoTexture()
        surface.SetDrawColor(color)
        surface.DrawPoly(poly)
        return
    end

    local poly = {}
    poly[1] = {
        x = x,
        y = y
    }
    for i = math.min(angleStart, angleEnd), math.max(angleStart, angleEnd) do
        local a = math.rad(i)
        if angleStart < 0 then
            poly[#poly + 1] = {
                x = x + math.cos(a) * radius,
                y = y + math.sin(a) * radius
            }
        else
            poly[#poly + 1] = {
                x = x - math.cos(a) * radius,
                y = y - math.sin(a) * radius
            }
        end
    end
    poly[#poly + 1] = {
        x = x,
        y = y
    }

    if shouldDraw then
        cache:store(cachePath, poly)
        draw.NoTexture()
        surface.SetDrawColor(color)
        surface.DrawPoly(poly)
    end

    return poly
end

function Diamond:DrawRoundedRect(radius, x, y, w, h, color)
    surface.SetDrawColor(color)
    surface.DrawRect(x + radius, y, w - radius * 2, h)
    surface.DrawRect(x, y + radius, radius, h - radius * 2)
    surface.DrawRect(x + w - radius, y + radius, radius, h - radius * 2)

    self:DrawCircle(x + radius, y + radius, radius, color, -180, -90, true)
    self:DrawCircle(x + w - radius, y + radius, radius, color, -90, 0, true)
    self:DrawCircle(x + radius, y + h - radius, radius, color, -270, -180, true)
    self:DrawCircle(x + w - radius, y + h - radius, radius, color, 270, 180, true)
end

function Diamond:DrawRoundedOutlinedRect(radius, x, y, w, h, thickness, color)
    if radius == 0 then
        for i = 0, thickness / 2 - 1 do
            surface.SetDrawColor(color)
            surface.DrawOutlinedRect(i, i, w - i * 2, h - i * 2)
        end
        return
    end

    self:MaskStencil(function()
        self:DrawRoundedRect(radius, x + thickness / 2, y + thickness / 2, w - thickness, h - thickness, color)
    end, function()
        self:DrawRoundedRect(radius + 2, x, y, w, h, color)
    end, true)
end

function Diamond:DrawRoundedTexturedRect(radius, x, y, w, h, mat, color)
    self:MaskStencil(function()
        self:DrawRoundedRect(radius, x, y, w, h, color)
    end, function()
        surface.SetDrawColor(color)
        surface.SetMaterial(mat)
        surface.DrawTexturedRect(x, y, w, h)
    end)
end
