local PANEL = {}

local theme = Diamond.Theme

AccessorFunc(PANEL, "__draggable", "Draggable", FORCE_BOOL)
AccessorFunc(PANEL, "__screenLock", "ScreenLock", FORCE_BOOL)

function PANEL:Init()
	local titleFont = Diamond:Font(20)
	local closeFont = Diamond:Font(20, {
	font = "Font Awesome 5 Free Solid" })

	self:SetDraggable(true)
	self:SetScreenLock(false)

	self:SetAlpha(0)
	self:AlphaTo(255, 0.25, 0)

	self.header = self:Add("Panel")
	self.header:Dock(TOP)
	self.header.Paint = function(this, w, h)
		draw.RoundedBoxEx(theme:get("radius"), 0, 0, w, h, theme:lighten("background", 0.25), true, true, false, false)
	end
	self.header.OnMousePressed = function(this)
		if (not self:GetDraggable()) then return end

		local screenX, screenY = self:LocalToScreen(0, 0)
		self.Dragging = {
			gui.MouseX() - self.x,
			gui.MouseY() - self.y
		}
		this:MouseCapture(true)
	end
	self.header.OnMouseReleased = function(this)
		if (not self:GetDraggable()) then return end

		self.Dragging = nil
		this:MouseCapture(false)
	end
	self.header.Think = function(this)
		if (not self:GetDraggable()) then return end

		local mousex = math.Clamp(gui.MouseX(), 1, ScrW() - 1)
		local mousey = math.Clamp(gui.MouseY(), 1, ScrH() - 1)

		if self.Dragging then
			local x = mousex - self.Dragging[1]
			local y = mousey - self.Dragging[2]


			if self:GetScreenLock() then
				x = math.Clamp(x, 0, ScrW() - self:GetWide())
				y = math.Clamp(y, 0, ScrH() - self:GetTall())
			end

			self:SetPos(x, y)
		end

		if this:IsHovered() then
			this:SetCursor("sizeall")
		else
			this:SetCursor("arrow")
		end
	end

	self.title = self.header:Add("DLabel")
	self.title:Dock(LEFT)
	self.title:DockMargin(16, 0, 0, 0)
	self.title:SetFont(titleFont)
	self.title:SetTextColor(theme:get("text"))
	self:SetTitle("Window")

	self.close = self.header:Add("DButton")
	self.close:Dock(RIGHT)
	self.close:SetText("")
	self.close.colors = {
		i = theme:lighten("text", -0.2),
		o = theme:get("text")
	}
	self.close.buttonColor = self.close.colors.i
	self.close.Paint = function(this, w, h)
		local iconWidth, iconHeight = w / 3.25, h / 3.25
		surface.SetDrawColor(this.buttonColor)
		surface.SetMaterial(Diamond.Core.Settings.Materials.closeButton)
		surface.DrawTexturedRect(w / 2 - iconWidth / 2, h / 2 - iconHeight / 2, iconWidth, iconHeight)
	end
	self.close.OnCursorEntered = function(this)
		Diamond.Animations.LerpColor("buttonColor", self.close.colors.o, this)
	end
	self.close.OnCursorExited = function(this)
		Diamond.Animations.LerpColor("buttonColor", self.close.colors.i, this)
	end
	self.close.DoClick = function()
		self:Close()
	end

	Diamond:on("themeChanged", function(oldTheme, newTheme)
		if (not self or not IsValid(self)) then return end

		self.title:SetTextColor(theme:get("text"))
		self.close.colors = {
			i = theme:lighten("text", -0.2),
			o = theme:get("text")
		}
		self.close.buttonColor = self.close.colors.i
	end)
end

function PANEL:Paint(w, h)
	local x, y = self:LocalToScreen()

	Diamond.Shadows.BeginShadow()
	draw.RoundedBox(theme:get("radius"), x, y, w, h, theme:get("background"))
	Diamond.Shadows.EndShadow(1, 2, 2, 255, 0, 0)
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

function PANEL:Close()
	self:AlphaTo(0, 0.25, 0, function()
		self:Remove()
	end)
end

function PANEL:PerformLayout(w, h)
	local headerHeight = 45

	if self.header then self.header:SetTall(headerHeight)end
	if self.close then self.close:SetWide(headerHeight)end
end

vgui.Register("Diamond:Frame", PANEL, "EditablePanel")

local function openMenu(client)
	local frame = vgui.Create("Diamond:Frame")
	frame:SetSize(900, 600)
	frame:MakePopup()
	frame:Center()

	local sidebar = vgui.Create("Diamond:Sidebar", frame)
	sidebar:Dock(LEFT)
	sidebar:SetWide(250)
	sidebar:AddCard("Diamond:Cards:Player", 70, function(self)
		self.avatar:SetRadius(4)
	end)
	sidebar:AddPanel("Dashboard", utf8.char(0xf3fd), "DPanel", {
	Radius = 4 })
	sidebar:AddPanel("Preferences", utf8.char(0xf085), "Diamond:Tabs:Preferences", {
	Radius = 4 })
	sidebar:SelectPanel(2)





	local button = vgui.Create("Diamond:Button", frame)
	button:Dock(BOTTOM)
	button:DockMargin(16, 16, 16, 16)
	button:SetTall(45)
	button:SetText("Continuer")
	button:SetStyle("colorOnHover")
end
concommand.Add("diamond", openMenu)

RunConsoleCommand("diamond")
