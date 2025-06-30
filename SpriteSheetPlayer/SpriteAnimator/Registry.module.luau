--!strict
local Registry = {}

local animations = {}

function Registry.add(name: string, co: thread)
	animations[name] = co
end

function Registry.exist(name: string)
	return animations[name] ~= nil
end

function Registry.get(name: string)
	return animations[name]
end

-- DEBUG ONLY
function Registry.getCache()
	return animations
end

function Registry.remove(name: string)
	animations[name] = nil
end

return Registry
