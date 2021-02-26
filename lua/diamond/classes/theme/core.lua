local Theme
do
    local _class_0
    local _base_0 = {
        __name = "Theme",
        getCurrentColor = function(self)
            return self.currentColor
        end,
        getCurrentTheme = function(self)
            return self.currentTheme
        end,
        get = function(self, color)
            return self.COLORS[color] or self.THEMES[self:getCurrentTheme()][color] or IsColor(color) and color or self.COLORS[self:getCurrentColor()]
        end,
        lighten = function(self, color, fraction, alpha)
            local col = self:get(color)
            return Color(col.r + col.r * fraction, col.g + col.g * fraction, col.b + col.b * fraction, alpha and col.a + col.a * fraction or col.a)
        end,
        lerp = function(self, ft, f, t)
            return Color(Lerp(ft, f.r, t.r), Lerp(ft, f.g, t.g), Lerp(ft, f.b, t.b))
        end,
        alpha = function(self, color, alpha)
            local col = self:get(color)
            return Color(col.r, col.g, col.b, alpha)
        end,
        setCurrentColor = function(self, color)
            if (not self.COLORS[color]) then return end

            local oldPreference = self.currentColor

            self.currentColor = color
            self:save()

            Diamond:emit("colorChanged", oldPreference, color)

            return self
        end,
        setCurrentTheme = function(self, theme)
            if (not self.THEMES[theme]) then return end

            local oldTheme = self.currentTheme

            self.currentTheme = theme
            self:save()

            Diamond:emit("themeChanged", oldTheme, theme)

            return self
        end,
        getActiveTheme = function(self)
            return self.THEMES[self:getCurrentTheme()]
        end,
        save = function(self)
            local __lauxi0 = Diamond.Package
            assert(__lauxi0 ~= nil, "cannot destructure nil value")
            local root = __lauxi0.root

            if not file.IsDir(root, "DATA") then
                file.CreateDir(root)
            end

            file.Write(self.path, util.TableToJSON({
                theme = self:getCurrentTheme(),
                color = self:getCurrentColor()
            }, true))
        end,
        list = function(self)
            return {
                ["modes"] = self.THEMES,
                ["colors"] = self.COLORS
            }
        end,
        __type = function(self)
            return self.__name
        end
    }
    _base_0.__index = _base_0
    _class_0 = setmetatable({
        __init = function(self)
            self.THEMES = {
                light = {
                    background = Color(212, 212, 212),
                    text = Color(12, 12, 12),
                    radius = 8,
                    text = Color(0, 0, 0)
                },
                dark = {
                    background = Color(32, 32, 32),
                    text = Color(255, 255, 255),
                    radius = 8,
                    text = Color(255, 255, 255)
                },
                night = {
                    background = Color(46, 49, 56),
                    text = Color(255, 255, 255),
                    radius = 8,
                    text = Color(255, 255, 255)
                }
            }
            self.COLORS = {
                red = Color(237, 41, 57),
                orange = Color(255, 105, 0),
                yellow = Color(255, 191, 0),
                purple = Color(106, 79, 236),
                blue = Color(14, 87, 196),
                green = Color(0, 168, 107),
                cyan = Color(32, 174, 150),
                pink = Color(247, 106, 140),

                white = Color(255, 255, 255),
                black = Color(0, 0, 0)
            }
            local __lauxi1 = Diamond.Package
            assert(__lauxi1 ~= nil, "cannot destructure nil value")
            local root = __lauxi1.root
            self.path = tostring(root) .. "/theme.json"

            local content = util.JSONToTable(file.Read(self.path, "DATA") or "{}")
            self:setCurrentTheme(content.theme or "dark")
            self:setCurrentColor(content.color or "blue")
        end,
        __base = _base_0
    }, {
        __index = _base_0,
        __call = function(cls, ...)
            local _self_0 = setmetatable({}, _base_0)
            cls.__init(_self_0, ...)
            return _self_0
        end
    })
    Theme = _class_0
end

Diamond.Theme = Theme()
