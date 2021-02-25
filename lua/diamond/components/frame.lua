local PANEL = {}


function PANEL:Init()
  self.theme = Diamond.ThemeHandler:getTheme()

  self.titleFont = Diamond:Font(20)
  self.closeFont = Diamond:Font(20, {
  font = "Font Awesome 5 Pro Light" })

  self.header = self:Add("Panel")
  self.header:Dock(TOP)
  self.header.Paint = function(this, w, h)
    draw.RoundedBoxEx(self.theme.radius, 0, 0, w, h, self.theme.primary, true, true, false, false)
  end

  self.title = self.header:Add("DLabel")
  self.title:Dock(LEFT)
  self.title:DockMargin(16, 0, 0, 0)
  self.title:SetFont(self.titleFont)
  self.title:SetTextColor(self.theme.text.highlight)
  self:SetTitle("Window")

  self.close = self.header:Add("DButton")
  self.close:Dock(RIGHT)


  self.close:SetText("")
  self.close.OnCursorEntered = function(this)
    Diamond.Animations.LerpColor("textColor", self.theme.red, this)
    Diamond.Animations.Lerp("boxOpacity", 255, this)
  end
  self.close.OnCursorExited = function(this)
    Diamond.Animations.LerpColor("textColor", self.theme.text.highlight, this)
    Diamond.Animations.Lerp("boxOpacity", 0, this)
  end
  self.close.Paint = function(this, w, h)
    local icon = utf8.char(0xf00d)
    local color = (function() local __laux_nilish_coalescing_var = this.textColor if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return self.theme.text.highlight end end)()

    local m = h * 0.295

    local boxColor = ColorAlpha(self.theme.secondary, (function() local __laux_nilish_coalescing_var = this.boxOpacity if __laux_nilish_coalescing_var ~= nil then return __laux_nilish_coalescing_var else return 0 end end)())
    draw.RoundedBox(self.theme.radius, m / 2, m / 2, w - m, h - m, boxColor)

    draw.SimpleText(icon, self.closeFont, w / 2, h / 2, color, 1, 1)

  end
  self.close.DoClick = function(this)
    local action = self.CloseAction
    if action then action(self)return end

    self:Remove()
  end
end

function PANEL:GetTitle()
  return self.title:GetText()
end

function PANEL:SetTitle(title)
  local __laux_type = (istable(title) and title.__type and title:__type()) or type(title)
  assert(__laux_type == "string", "Expected parameter `title` to be type `string` instead of `" .. __laux_type .. "`")
  self.title:SetText(title)
  self.title:SizeToContents()
end

function PANEL:Paint(w, h)
  local x, y = self:LocalToScreen()

  Diamond.Shadows.BeginShadow()
  draw.RoundedBox(self.theme.radius, x, y, w, h, self.theme.secondary)
  Diamond.Shadows.EndShadow(1, 2, 2, 255, 0, 0)
end

function PANEL:PerformLayout(w, h)
  local headerHeight = 45

  if self.header then self.header:SetTall(headerHeight)end
  if self.close then self.close:SetWide(headerHeight)end
end

vgui.Register("Diamond.Frame", PANEL, "EditablePanel")

local function openMenu(client)
  local frame = vgui.Create("Diamond.Frame")
  frame:SetSize(800, 600)
  frame:Center()
  frame:MakePopup()
end
concommand.Add("diamond", openMenu)
