function loadFile(dest)
	chunk = love.filesystem.load(dest)
	local cache = chunk()
	for _,v in pairs(cache) do
		if v.texture ~= nil then
			v.texture = love.graphics.newImage(v.texture)
		end
	end
	return cache
end

function getAngle(x1, y1, x2, y2)
  return math.atan2(y2 - y1, x2 - x1)
end

function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end