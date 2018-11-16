local Tile = {}
local TileMT = {__index = class}


local tileArr = {
	grass = {
		id = 1,
		sprite = love.graphics.newImage('src/tiles/grass.png'),
		collision = false,
	},
	wall = {
		id = 2,
		sprite = love.graphics.newImage('src/tiles/wall.png'),
		collision = true
	}
}

function Tile:new(tileType)
	local cache = {}
	setmetatable(cache, TileMT)
	cache.id = tileArr[tileType].id
	cache.sprite = tileArr[tileType].sprite
	cache.collision = tileArr[tileType].collision
	cache.highlight = false
	return cache
end

return Tile