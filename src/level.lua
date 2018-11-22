require('src/essentials')

level_controller = {}
local starter = "("
local closer = ")"
local separator = ","
local tileArr = {}
tileArr[1] = "floor"
tileArr[2] = "wall"
tileArr[3] = "wall_north"
tileArr[4] = "wall_east"
tileArr[5] = "wall_south"
tileArr[6] = "wall_west"
tileSelect = 1

function level_controller:init(w,h,tile)
	local cache = {}
	local xCount = 0
	local yCount = 0
	for i=0,w do
		for z=0,h do
			table.insert(cache,tileCreate(xCount,yCount,tile))
			xCount = xCount + 32
		end
		xCount = 0
		yCount = yCount + 32
	end
	return cache
end

function level_controller:edit(mX,mY,level,tiles)
	editing = true
	for _,v in pairs(level) do
		if checkCollision(v.x,v.y,32,32,mX,mY,1,1) then
			v.highlight = true
		else
			v.highlight = false
		end
	end
end

function level_controller:save(level)
	local cache = ""
	for _,v in pairs(level) do
		cache = cache..v.id..separator..v.x..separator..v.y..separator..closer
	end
	local levelSave = true
	local levelCount = 0
	while levelSave do
		if love.filesystem.exists("Level "..levelCount..".txt") then
			levelCount = levelCount + 1
		else
			file = love.filesystem.newFile("Level "..levelCount..".txt")
			file:open("w")
			file:write(cache)
			file:close()
			levelSave = false
		end
	end
end

function level_controller:load(level)
	local cache = {}
	local loopCache = {}
	local loopCount = 0
	local file = love.filesystem.newFile(level)
	file:open("r")
	local data = file:read()
	file:close()
	for val in string.gmatch(data,"%w+") do
		loopCount = loopCount + 1
		loopCache[loopCount] = tonumber(val)
		--print("entry # "..loopCount..": "..val)
		if loopCount == 3 then
			loopCount = 0
			print("tile ID : "..loopCache[1].." Tile X : "..loopCache[2].." Tile Y : "..loopCache[3])
			table.insert(cache,tileCreate(loopCache[2],loopCache[3],loopCache[1]))
		end
	end
	return cache
end

function level_controller:draw(level)
	for _,v in pairs(level) do
		if v.sprite ~= nil then
			love.graphics.draw(v.sprite, v.x, v.y)
		end
		if v.highlight then
			love.graphics.rectangle("line", v.x, v.y, 32, 32)
		end
	end
end

function tileReplace(x,y,level,tile)
	for _,v in pairs(level) do
		if checkCollision(v.x,v.y,32,32,x,y,1,1) then
			--fix
			v.id = Tile.tileArr[tileArr[tileSelect]].id
			v.sprite = Tile.tileArr[tileArr[tileSelect]].sprite
			v.collision = Tile.tileArr[tileArr[tileSelect]].collision
			v.w = Tile.tileArr[tileArr[tileSelect]].w
			v.h = Tile.tileArr[tileArr[tileSelect]].h
			v.xOffset = Tile.tileArr[tileArr[tileSelect]].xOffset
			v.yOffset = Tile.tileArr[tileArr[tileSelect]].yOffset
		end
	end
end


function tileCreate(x,y,tileType)
	local cache = {}
	cache.id = Tile.tileArr[tileArr[tileType]].id
	cache.sprite = Tile.tileArr[tileArr[tileType]].sprite
	cache.collision = Tile.tileArr[tileArr[tileType]].collision
	cache.w = Tile.tileArr[tileArr[tileType]].w
	cache.h = Tile.tileArr[tileArr[tileType]].h
	cache.xOffset = Tile.tileArr[tileArr[tileType]].xOffset
	cache.yOffset = Tile.tileArr[tileArr[tileType]].yOffset
	cache.x = x
	cache.y = y
	return cache
end

function love.mousepressed(x, y, button, istouch)
	if editing then
		if button == 1 then
			tileReplace(x,y,level,Tile.tileArr)
		elseif button == 2 then
			level_controller:save(level)
		end
	end
end

function love.keypressed(key, unicode)
    if editing then
    	if tonumber(key) ~= nil then
    		tileSelect = tonumber(key)
    	end
   	end
end