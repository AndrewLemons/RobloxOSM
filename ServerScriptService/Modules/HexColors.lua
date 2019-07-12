--Full credit for this code goes to Dev_Ryan

--Converts hex color codes to a Color3

local hex2rgb = function (hex)
	hex = hex:gsub("#","")
	local r = tonumber("0x"..hex:sub(1,2))
	local g = tonumber("0x"..hex:sub(3,4))
	local b = tonumber("0x"..hex:sub(5,6))
	return Color3.fromRGB(r,g,b)
end

return hex2rgb
