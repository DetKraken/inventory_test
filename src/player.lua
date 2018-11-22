player_controller = {}
playerPickup = ""

function player_controller:init(x,y)
	local player = {
		x = x,
		y = y,
		xVel = 0,
		yVel = 0,
		w = 28,
		h = 28,
		r = 0,
		sprite = love.graphics.newImage('src/player.png'),
		inventory = {0,0},
		equipped = 1,
		speed = 8,
		friction = 2,
		cooldown = 1,
		cCooldown = 1,
		collision = {
			north = false,
			east = false,
			south = false,
			west = false
		}
	}
	function pickup(object)
		if player.inventory[1] == 0 then
			player.inventory[1] = object
			return true
		elseif player.inventory[2] == 0 then
			player.inventory[2] = object
			return true
		end
	end
	function drop(object)
		if player.inventory[object] ~= 0 then
			player.inventory[object].x = player.x
			player.inventory[object].y = player.y
			table.insert(objectArr.active,player.inventory[object])
			player.inventory[object] = 0
		end
	end
	function attack()
		print("bang")
		if player.inventory[player.equipped] ~= 0 then
			print(player.inventory[player.equipped].magazine)
			player.inventory[player.equipped].magazine = player.inventory[player.equipped].magazine - 1
			player.cCooldown = player.cooldown
		end
	end
	function throw()
		print("weee")
	end
	return player
end

function player_controller:draw(player)
	love.graphics.draw(player.sprite, player.x+14, player.y+14, player.r, 1 ,1, 14,14)
	if player.inventory[player.equipped] ~= 0 then
		love.graphics.draw(player.inventory[player.equipped].sprite, player.inventory[player.equipped].x, player.inventory[player.equipped].y, player.r, 1, 1, 1, 1, kx, ky)
	end
end

function player_controller:update(player,dt,objArr,level,mX,mY)
	for _,v in pairs(player.inventory) do
		if v ~= 0 then
			v.x = player.x + 14
			v.y = player.y + 14
			v.r = player.r
		end
	end
	player.r = math.atan2(mX - (player.x + 14), (player.y + 14) - mY ) - math.pi / 2
	playerPickup = ""
	if player.cCooldown > 0 then
		player.cCooldown = player.cCooldown - 1 * dt
	end
	playerCollision(player,objArr,level)
	playerMove(player,dt)
end

function playerMove(player,dt)
	if love.keyboard.isDown("q") and player.cCooldown < 0 then
		if player.equipped == 1 then
			player.equipped = 2
		elseif player.equipped == 2 then
			player.equipped = 1
		end
		player.cCooldown = player.cooldown
	end
	if love.keyboard.isDown("t") and player.inventory[player.equipped] ~= 0 then
		drop(player.equipped)
	end
	if love.keyboard.isDown("space") and player.cCooldown < 0 then
		attack()
	end
	if love.keyboard.isDown("s") then
        player.yVel = player.yVel + player.speed * dt
    elseif love.keyboard.isDown("w") and player.collision.north == false then
        player.yVel = player.yVel - player.speed * dt
    end
    if love.keyboard.isDown("d") and player.collision.east == false then
    	player.xVel = player.xVel + player.speed * dt
    elseif love.keyboard.isDown("a") and player.collision.west == false then
    	player.xVel = player.xVel - player.speed * dt
    end
    playerVelocity(player,dt)
end

function playerCollision(player,objArr,level)
	for i,v in ipairs(objArr.active) do
		if checkCollision(v.x,v.y,v.w,v.h, player.x,player.y,player.w,player.h) then
			playerPickup = v.name
			if love.keyboard.isDown("e") then
				if pickup(v) then
					table.remove(objArr.active,i)
				end
			end
		end
	end

	for _,v in pairs(level) do
		if v.collision then
			if checkCollision(v.x+v.xOffset,v.y+v.yOffset,v.w,v.h, player.x,player.y+1,player.w,player.h) and player.yVel > 0 then
				player.yVel = 0
				player.collision.north = true
				player.y = player.y - 1
			else
				player.collision.north = false
			end
			if checkCollision(v.x+v.xOffset,v.y+v.yOffset,v.w,v.h, player.x,player.y-1,player.w,player.h) and player.yVel < 0 then
				player.yVel = 0
				player.collision.south = true
				player.y = player.y + 1
			else
				player.collision.south = false
			end
			if checkCollision(v.x+v.xOffset,v.y+v.yOffset,v.w,v.h, player.x+1,player.y,player.w,player.h) then
				player.xVel = 0
				player.collision.east = true
				player.x = player.x - 1
			else
				player.collision.east = false
			end
			if checkCollision(v.x+v.xOffset,v.y+v.yOffset,v.w,v.h, player.x-1,player.y,player.w,player.h) then
				player.xVel = 0
				player.collision.west = true
				player.x = player.x + 1
			else
				player.collision.west = false
			end
		end
	end
end

function playerVelocity(player,dt)
	player.y = player.y + player.yVel
	player.x = player.x + player.xVel
	player.yVel = player.yVel * (1 - math.sin(dt * player.friction, 1))
	player.xVel = player.xVel * (1 - math.sin(dt * player.friction, 1))
end