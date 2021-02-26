local PANEL = {}

local theme = Diamond.Theme

AccessorFunc(PANEL, "__backgroundColor", "BackgroundColor")
AccessorFunc(PANEL, "__radius", "Radius", FORCE_NUMBER)
AccessorFunc(PANEL, "__style", "Style", FORCE_STRING)
AccessorFunc(PANEL, "__thickness", "Thickness", FORCE_NUMBER)
AccessorFunc(PANEL, "__checked", "Checked", FORCE_BOOL)
AccessorFunc(PANEL, "_lblPos", "LabelPosition", FORCE_NUMBER)
AccessorFunc(PANEL, "_Icon", "Icon")

function PANEL:Init()
    self:SetBackgroundColor(theme:get("blue"))
    self:SetTextColor(theme:get("white"))
    self:SetFont(Diamond:Font(18), {
    weight = 1000 })
    self:SetLabelPosition(TEXT_ALIGN_CENTER)
    self:SetCursor("hand")
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetRadius(theme:get("radius"))
    self:SetText("")
    self:SetThickness(4)
    self:SetChecked(false)





    self.SetText = function(self, text)
        self.text = text
    end

    self.GetText = function()
        return self.text
    end
end

function PANEL:IsDown()
    return self.Depressed
end

function PANEL:CalculateLabelPosition(w, h)
    local x, y = w / 2, h / 2
    local icon = self:GetIcon()

    if self:GetLabelPosition() == TEXT_ALIGN_LEFT then
        x = h / 2
    end
    if self:GetLabelPosition() == TEXT_ALIGN_RIGHT then
        x = w - 16
    end
    if icon then
        x = self:GetLabelPosition() == TEXT_ALIGN_RIGHT and x - 20 or self:GetLabelPosition() == TEXT_ALIGN_LEFT and x + 16 or x + 10
    end

    return x, y
end

local styles = {
    default = function(self, w, h)
        self.background = theme:lerp(FrameTime() * 8, self.background or self:GetBackgroundColor(), (self:IsDown() or self:GetChecked()) and theme:lighten(self:GetBackgroundColor(), 0.4) or self:IsHovered() and theme:lighten(self:GetBackgroundColor(), 0.2) or self:GetBackgroundColor())

        draw.RoundedBox(self:GetRadius(), 0, 0, w, h, self.background)
    end,
    outlined = function(self, w, h)
        self.alpha = Lerp(FrameTime() * 8, self.alpha or 0, (self:IsDown() or self:GetChecked()) and 50 or self:IsHovered() and 25 or 0)
        Diamond:DrawRoundedOutlinedRect(self:GetRadius(), 0, 0, w, h, self:GetThickness(), self:GetBackgroundColor())
        Diamond:DrawRoundedRect(self:GetRadius(), self:GetThickness() / 2, self:GetThickness() / 2, w - self:GetThickness(), h - self:GetThickness(), theme:alpha(self:GetBackgroundColor(), self.alpha))
    end,
    colorOnHover = function(self, w, h)
        self.alpha = Lerp(FrameTime() * 8, self.alpha or 0, (self:IsDown() or self:GetChecked()) and 255 or self:IsHovered() and 125 or 0)
        draw.RoundedBox(self:GetRadius(), 0, 0, w, h, theme:alpha(self:GetBackgroundColor(), self.alpha))
    end,
    gradient = function(self, w, h)
        self.alpha = Lerp(FrameTime() * 8, self.alpha or 0, (self:IsDown() or self:GetChecked()) and 255 or self:IsHovered() and 125 or 0)
        draw.RoundedBox(self:GetRadius(), 0, 0, w, h, theme:alpha(self:GetBackgroundColor(), self.alpha))
        Diamond:DrawRoundedTexturedRect(self:GetRadius() - 1, 0, 0, w, h, Diamond.Core.Settings.Materials["gradient"], theme:lighten(theme:alpha(self:GetBackgroundColor(), self.alpha), 0.5))
    end
}
function PANEL:Paint(w, h)
    local style = styles[self:GetStyle()] or styles["default"]
    style(self, w, h)

    local x, y = self:CalculateLabelPosition(w, h)
    local icon = self:GetIcon()
    draw.SimpleText(self:GetText(), self:GetFont(), x + (icon and 12 or 0), y, theme:get("white"), self:GetLabelPosition(), 1)

    if icon then
        draw.SimpleText(icon.icon, icon.font, self:GetLabelPosition() == TEXT_ALIGN_RIGHT and x + 20 or self:GetLabelPosition() == TEXT_ALIGN_LEFT and x - 20 or x - 50, y, theme:get("white"), self:GetLabelPosition(), 1)
    end
end

vgui.Register("Diamond:Button", PANEL, "DLabel")

RunConsoleCommand('diamond')
