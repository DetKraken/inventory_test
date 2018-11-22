Weapon = require 'src/weapons'
Tile = require 'src/tiles'

require('src/player')
require('src/essentials')
require('src/level')

function love.load()
	love.graphics.setBackgroundColor(255,255,255)
	player = player_controller:init(200,200)
	--level = level_controller:init(10,10,Tile:new("floor"))
	level = level_controller:load("level 2.txt")
	objectArr = {}
	objectArr.active = {}
	objectArr.bullets = {}
	--table.insert(objectArr.active,Weapon:new(100,300,"shotgun"))
	--table.insert(objectArr.active,Weapon:new(300,100,"revolver"))
end

function love.update(dt)
	mX, mY = love.mouse.getPosition()
	level_controller:edit(mX,mY,level,Tile.tileArr)
	player_controller:update(player,dt,objectArr,level,mX,mY)
end

function love.draw()
	level_controller:draw(level)
	for _,v in pairs(objectArr.active) do
		love.graphics.draw(v.sprite, v.x, v.y, v.r)
	end
	player_controller:draw(player)
end