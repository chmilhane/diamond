local __cache = {}

local DEFAULT_FONT = "Montserrat Medium"

function Diamond:Font(size, content)
  local __laux_type = (istable(size) and size.__type and size:__type()) or type(size)
  assert(__laux_type == "number", "Expected parameter `size` to be type `number` instead of `" .. __laux_type .. "`")
  local t = {
    font = DEFAULT_FONT,
    size = size,
    weight = 500,
    extended = true
  }

  if (content and istable(content)) then
    t = table.Merge(t, content)
  end

  local name = string.format("%s.%s.%s", "Diamond", size, t.font)

  if __cache[name] then
    return name
  end

  surface.CreateFont(name, t)
  __cache[name] = true

  return name
end
