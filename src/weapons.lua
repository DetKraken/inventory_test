local Weapon = {}
local WeaponMT = {__index = class}

local weaponArr = {
	pistol = {
		id = 1,
		sprite = love.graphics.newImage('src/weapons/revolver.png'),
		w = 5,
		h = 27,
		name = "Glack 18"
	},
	smg = {
		id = 2
	}
}

local magArr = {
	pistol = {
		id = 1,
		size = 15,
		typeOf = "nineMm"
	},
	smg = {
		id = 2,
		size = 31,
		typeOf = "acp"
	}
}

local shellArr = {
	nineMm = {
		id = 1,
		mass = 7,
		velocity = 200
	},
	acp = {
		id = 1,
		mass = 6,
		velocity = 180
	}
}

function Weapon:new(x,y,weapon)
	local cache = {}
	setmetatable(cache, WeaponMT)
	cache.x = x
	cache.y = y
	cache.w = 5
	cache.h = 27
	cache.name = weaponArr[weapon].name
	cache.sprite = weaponArr[weapon].sprite
	cache.magazine = magArr[weapon].size
	cache.shellType = shellArr[magArr[weapon].typeOf]
	return cache
end

function Weapon:fire()
	print(self.typeOf)
end

return Weapon