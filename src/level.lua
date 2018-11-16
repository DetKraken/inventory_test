require('src/essentials')


level_controller = {}



function level_controller:init(w,h,tile)
	local cache = {}
	xCount = 0
	yCount = 0
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

function level_controller:edit(mX,mY,level)
	for _,v in pairs(level) do
		if checkCollision(v.x,v.y,32,32,mX,mY,1,1) then
			v.highlight = true
		else
			v.highlight = false
		end
	end









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


function tileCreate(x,y,tileType)
	print("creating tile at "..x.."/"..y)
	print(tileType.sprite)
	local cache = {}
	cache.sprite = tileType.sprite
	cache.x = x
	cache.y = y
	return cache
end