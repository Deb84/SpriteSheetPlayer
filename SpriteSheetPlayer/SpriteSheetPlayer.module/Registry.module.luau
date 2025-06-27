local Registry = {}

local cache = {}

function Registry.add(name: string, obj: table)
	cache[name] = obj
end

function Registry.get(name: string)
	return cache[name]
end

-- DEBUG ONLY
function Registry.getCache()
	return cache
end

function Registry.remove(name: string)
	cache[name] = nil
end

return Registry
