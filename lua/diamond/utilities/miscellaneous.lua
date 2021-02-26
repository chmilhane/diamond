local __blacklistedPanels = {
    ["DMenuBar"] = true,
    ["DMenu"] = true,
    ["SpawnMenu"] = true,
    ["ContextMenu"] = true,
    ["ControlMenu"] = true,
    ["CGMODMouseInput"] = true,
    ["Panel"] = true
}

local __blacklistedScripts = {
    ["scoreboard"] = true,
    ["menu"] = true,
    ["f1"] = true,
    ["f2"] = true,
    ["f3"] = true,
    ["f4"] = true
}

local function closeAllPanels(client)
    local panels = vgui.GetWorldPanel():GetChildren()

    for i, panel in ipairs(panels or {}) do
        if (not IsValid(panel)) then continue end

        local name = panel:GetName()
        local className = panel:GetClassName()

        if (__blacklistedPanels[name]) then continue end
        if (__blacklistedPanels[className]) then continue end

        if (__blacklistedScripts[name]) then continue end

        Diamond:log("Removing: ", className)
        panel:Remove()
    end
end
concommand.Add("diamond_close_vgui", closeAllPanels)
