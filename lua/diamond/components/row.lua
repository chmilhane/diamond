local PANEL = {}

function PANEL:Init()
    self.label = vgui.Create("DLabel", self)
    self.label:Dock(TOP)
    self:SetFont(Diamond:Font(24))
    self:SetName("Unamed row")

    self.grid = vgui.Create("DIconLayout", self)
    self.grid:Dock(FILL)
end

function PANEL:GetFont()
    return self.label:GetFont()
end

function PANEL:SetFont(font)
    local __laux_type = (istable(font) and font.__type and font:__type()) or type(font)
    assert(__laux_type == "string", "Expected parameter `font` to be type `string` instead of `" .. __laux_type .. "`")
    self.label:SetFont(font)
end

function PANEL:GetName()
    return self.label:GetText()
end

function PANEL:SetName(name)
    local __laux_type = (istable(name) and name.__type and name:__type()) or type(name)
    assert(__laux_type == "string", "Expected parameter `name` to be type `string` instead of `" .. __laux_type .. "`")
    self.label:SetText(name)
    self.label:SizeToContents()
end

function PANEL:GetGrid()
    return self.grid
end

vgui.Register("Diamond:Row", PANEL)
