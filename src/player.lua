player_controller = {}
playerPickup = ""

function player_controller:init(x,y)
	local player = {
		x = x,
		y = y,
		xVel = 0,
		yVel = 0,
		w = 32,
		h = 32,
		inventory = {0,0},
		equipped = 1,
		speed = 8,
		friction = 2,
		cooldown = 1,
		cCooldown = 1,
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
			table.insert(objectArr,player.inventory[object])
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
	love.graphics.print(player.cCooldown, player.x, player.y+50)
	love.graphics.print(playerPickup, player.x, player.y-30)
	love.graphics.print(tostring(player.inventory[1]).."/"..tostring(player.inventory[2]), player.x, player.y+30)
	love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
end

function player_controller:update(player,dt,objArr)
	playerPickup = ""
	if player.cCooldown > 0 then
		player.cCooldown = player.cCooldown - 1 * dt
	end
	for i,v in ipairs(objArr) do
		if checkCollision(v.x,v.y,v.w,v.h, player.x,player.y,player.w,player.h) then
			playerPickup = v.name
			if love.keyboard.isDown("e") then
				if pickup(v) then
					table.remove(objArr,i)
				end
			end
		end
	end
	player_move(player,dt)

end

function player_move(player,dt)
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
    elseif love.keyboard.isDown("w") then
        player.yVel = player.yVel - player.speed * dt
    end
    if love.keyboard.isDown("d") then
    	player.xVel = player.xVel + player.speed * dt
    elseif love.keyboard.isDown("a") then
    	player.xVel = player.xVel - player.speed * dt
    end
    playerVelocity(player,dt)
end

function playerVelocity(player,dt)
	player.y = player.y + player.yVel
	player.x = player.x + player.xVel
	player.yVel = player.yVel * (1 - math.sin(dt * player.friction, 1))
	player.xVel = player.xVel * (1 - math.sin(dt * player.friction, 1))
end