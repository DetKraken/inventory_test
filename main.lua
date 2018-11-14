Weapon = require 'src/weapons'
require('src/player')
require('src/essentials')

function love.load()
	player = player_controller:init(200,200)
	objectArr = {}
	table.insert(objectArr,Weapon:new(100,300,"pistol"))
	table.insert(objectArr,Weapon:new(100,100,"pistol"))
	table.insert(objectArr,Weapon:new(100,500,"pistol"))
end

function love.update(dt)
	player_controller:update(player,dt, objectArr)
end

function love.draw()
	for _,v in pairs(objectArr) do
		love.graphics.draw(v.sprite, v.x, v.y)
	end
	player_controller:draw(player)
end