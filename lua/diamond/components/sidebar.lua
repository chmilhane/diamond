local PANEL = {}


local theme = Diamond.Theme

function PANEL:Init()
    self:SetContainer(self:GetParent())

    self.active = -1

    self.buttons = {}
    self.panels = {}
    self.cards = {}
end

function PANEL:GetContainer()
    return self.__container
end

function PANEL:SetContainer(container, margin)
    if margin == nil then margin = 12
    end
    local __laux_type = (istable(container) and container.__type and container:__type()) or type(container)
    assert(__laux_type == "Panel", "Expected parameter `container` to be type `Panel` instead of `" .. __laux_type .. "`")
    local __laux_type = (istable(margin) and margin.__type and margin:__type()) or type(margin)
    assert(__laux_type == "number", "Expected parameter `margin` to be type `number` instead of `" .. __laux_type .. "`")
    local panel = vgui.Create("Panel", container)
    panel:Dock(FILL)
    panel:DockMargin(margin, margin, margin, margin)

    self.__container = panel
end

function PANEL:AddCard(panel, tall, custom)
    if panel == nil then panel = "Panel"
    end
    if tall == nil then tall = 60
    end
    if custom == nil then custom = function() end
    end
    local __laux_type = (istable(panel) and panel.__type and panel:__type()) or type(panel)
    assert(__laux_type == "string" or __laux_type == "Panel", "Expected parameter `panel` to be type `string|Panel` instead of `" .. __laux_type .. "`")
    local card = self:Add(panel)
    card:Dock(TOP)
    card:DockMargin(12, 12, 12, 0)
    card:SetTall(type(panel) == 'Panel' and panel:GetTall() or tall)
    custom(card)

    self.cards[#self.cards + 1] = card
    return card
end

function PANEL:AddPanel(text, icon, panel, options)
    if panel == nil then panel = "Panel"
    end
    if options == nil then options = {}
    end
    local __laux_type = (istable(text) and text.__type and text:__type()) or type(text)
    assert(__laux_type == "string", "Expected parameter `text` to be type `string` instead of `" .. __laux_type .. "`")
    local __laux_type = (istable(panel) and panel.__type and panel:__type()) or type(panel)
    assert(__laux_type == "string", "Expected parameter `panel` to be type `string` instead of `" .. __laux_type .. "`")
    local __laux_type = (istable(options) and options.__type and options:__type()) or type(options)
    assert(__laux_type == "table", "Expected parameter `options` to be type `table` instead of `" .. __laux_type .. "`")
    local button = vgui.Create("Diamond:Button", self)
    button:Dock(TOP)
    button:SetTall(45)
    button:SetText(text)
    button:DockMargin(12, 12, 12, 0)
    button:SetLabelPosition(TEXT_ALIGN_LEFT)
    button:SetStyle("gradient")

    if (not options.BackgroundColor) then
        options.BackgroundColor = theme:getCurrentColor()

        Diamond:on("colorChanged", function(oldColor, newColor)
            if (not self or not IsValid(self)) then return end
            local buttons = (function() local __laux_nilish_coalescing_var = self.buttons if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return {}end end)()

            for i, v in pairs(buttons) do
                v:SetBackgroundColor(theme:get(theme:getCurrentColor()))
            end
        end)
    end

    for i, v in pairs(options) do
        if (not button["Set" .. i]) then return end
        button["Set" .. i](button, v)
    end

    if icon then
        button:SetIcon({
            icon = icon,
            font = Diamond:Font(18, {
            font = "Font Awesome 5 Free Solid" })
        })
    end

    local index = #self.buttons + 1
    button.DoClick = function(this)
        self:SelectPanel(index)
    end

    self.panels[#self.panels + 1] = panel
    self.buttons[index] = button
end

function PANEL:SelectPanel(index)
    local __laux_type = (istable(index) and index.__type and index:__type()) or type(index)
    assert(__laux_type == "number", "Expected parameter `index` to be type `number` instead of `" .. __laux_type .. "`")
    if (index == self.active) then return end

    local container = self:GetContainer()
    container:AlphaTo(0, 0.15, 0, function()
        container:Clear()

        local panel = vgui.Create((function() local __laux_nilish_coalescing_var = self.panels[index]if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return self.panels[1]end end)(), container)
        panel:Dock(FILL)
        container:AlphaTo(255, 0.15)
    end)

    local button = self.buttons[index]
    local activeButton = (function() local __laux_nilish_coalescing_var = self.buttons[self.active]if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return self.buttons[1]end end)()
    activeButton:SetChecked(false)
    button:SetChecked(true)

    self.active = index
end

function PANEL:Paint(w, h)
    draw.RoundedBoxEx(theme:get("radius"), 0, 0, w, h, theme:lighten("background", -0.1), false, false, true, false)
end

vgui.Register("Diamond:Sidebar", PANEL)


RunConsoleCommand("diamond")
