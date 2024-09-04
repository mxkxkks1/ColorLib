local colorlib = {}

function colorlib.rgb(r, g, b)
    return Color3.new(r/255, g/255, b/255)
end

function colorlib.hex(hex)
    hex = hex:gsub("#","")
    return Color3.fromRGB(tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6)))
end

function colorlib.tohex(color)
    return string.format("#%02X%02X%02X", color.R * 255, color.G * 255, color.B * 255)
end

function colorlib.hsl(h, s, l)
    h = h / 360
    local r, g, b
    if s == 0 then
        r, g, b = l, l, l
    else
        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q
        r = colorlib.hue2rgb(p, q, h + 1/3)
        g = colorlib.hue2rgb(p, q, h)
        b = colorlib.hue2rgb(p, q, h - 1/3)
    end
    return Color3.new(r, g, b)
end

function colorlib.hue2rgb(p, q, t)
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < 1/6 then return p + (q - p) * 6 * t end
    if t < 1/2 then return q end
    if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
    return p
end

function colorlib.lerp(c1, c2, t)
    return Color3.new(
        c1.R + (c2.R - c1.R) * t,
        c1.G + (c2.G - c1.G) * t,
        c1.B + (c2.B - c1.B) * t
    )
end

function colorlib.invert(color)
    return Color3.new(1 - color.R, 1 - color.G, 1 - color.B)
end

function colorlib.darken(color, amount)
    return Color3.new(
        math.max(color.R - amount, 0),
        math.max(color.G - amount, 0),
        math.max(color.B - amount, 0)
    )
end

function colorlib.lighten(color, amount)
    return Color3.new(
        math.min(color.R + amount, 1),
        math.min(color.G + amount, 1),
        math.min(color.B + amount, 1)
    )
end

return colorlib
