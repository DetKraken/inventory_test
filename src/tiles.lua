local Tile = {}
local TileMT = {__index = class}


Tile.tileArr = {
	floor = {
		id = 1,
		sprite = love.graphics.newImage('src/tiles/floor.png'),
		collision = false,
	},
	wall = {
		id = 2,
		sprite = love.graphics.newImage('src/tiles/wall.png'),
		collision = true,
		w = 32,
		h = 32,
		xOffset = 0,
		yOffset = 0
	},
	wall_north = {
		id = 3,
		sprite = love.graphics.newImage('src/tiles/wall_north.png'),
		collision = true,
		w = 32,
		h = 16,
		xOffset = 0,
		yOffset = 0
	},
	wall_east = {
		id = 4,
		sprite = love.graphics.newImage('src/tiles/wall_east.png'),
		collision = true,
		w = 16,
		h = 32,
		xOffset = 16,
		yOffset = 0
	},
	wall_south = {
		id = 5,
		sprite = love.graphics.newImage('src/tiles/wall_south.png'),
		collision = true,
		w = 32,
		h = 16,
		xOffset = 0,
		yOffset = 16
	},
	wall_west = {
		id = 6,
		sprite = love.graphics.newImage('src/tiles/wall_west.png'),
		collision = true,
		w = 16,
		h = 32,
		xOffset = 0,
		yOffset = 0
	},
}

function Tile:new(tileType)
	local cache = {}
	setmetatable(cache, TileMT)
	cache.id = Tile.tileArr[tileType].id
	cache.sprite = Tile.tileArr[tileType].sprite
	cache.collision = Tile.tileArr[tileType].collision
	cache.highlight = false
	return cache
end

return Tile