local Weapon = {}
local WeaponMT = {__index = class}

local weaponArr = {
	revolver = {
		id = 1,
		sprite = love.graphics.newImage('src/weapons/revolver.png'),
		w = 5,
		h = 27,
		name = "Smath & Wassan .357"
	},
	smg = {
		id = 2
	},
	shotgun = {
		id = 3,
		sprite = love.graphics.newImage('src/weapons/shotgun.png'),
		w = 10,
		h = 10,
		name = "Banelli 12 gauge"
	}
}

local magArr = {
	revolver = {
		id = 1,
		size = 15,
		typeOf = "threeFiveSeven"
	},
	smg = {
		id = 2,
		size = 31,
		typeOf = "acp"
	},
	shotgun = {
		id = 3,
		size = 8,
		typeOf = "buckshot"
	}
}

local shellArr = {
	threeFiveSeven = {
		id = 1,
		mass = 7,
		velocity = 200
	},
	acp = {
		id = 1,
		mass = 6,
		velocity = 180
	},
	buckshot = {
		id = 3,
		mass = 1,
		velocity = 200
	}
}

function Weapon:new(x,y,weapon)
	local cache = {}
	setmetatable(cache, WeaponMT)
	cache.x = x
	cache.y = y
	cache.xVel = 0
	cache.yVel = 0
	cache.w = 5
	cache.h = 27
	cache.name = weaponArr[weapon].name
	cache.sprite = weaponArr[weapon].sprite
	cache.magazine = magArr[weapon].size
	cache.shellType = shellArr[magArr[weapon].typeOf]
	return cache
end

return Weapon