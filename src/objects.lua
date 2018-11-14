local ObjectClass = {}
local ObjectClassMT = {__index = ObjectClass}

function ObjectClass.new(id,sprite)
	local instance = {}
	instance.id = id
	instance.sprite = sprite
	return setmetatable(instance, ObjectClassMT)
end

return ObjectClass