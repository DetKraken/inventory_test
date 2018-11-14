local pistol = {}
local pistolMT = {__index = class}
local pistolSprite = love.graphics.newImage('src/weapons/revolver.png')

function pistol:new(x,y)
	local instance = {}
	setmetatable(instance, pistolMT)
	instance.x = x
	instance.y = y
	instance.w = 5
	instance.h = 27
	instance.name = "Glack 18"
	instance.sprite = pistolSprite
	return instance
end

function pistol:fire()
	print("bang")
end

return pistol