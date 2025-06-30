local Validator = {}

function Validator.newCheck(name, imageLabel, gridSize, framerate)
	assert(name)
	assert(imageLabel)
	assert(gridSize)
	assert(framerate)
	
	assert(type(name) == 'string')
	assert(imageLabel:IsA('ImageLabel'))
	assert(type(gridSize) == 'number')
	assert(type(framerate) == 'number')
end

function Validator.playCheck(imageSize)
	assert(imageSize)
	assert(type(imageSize) == 'number')
end

function Validator.editCheck(t: {any})
	assert(t)
	assert(type(t) == 'table')
	
	local possibleValue = {
		gridSize = 'number',
		framerate = 'number',
		state = 'boolean',
		imageSize = 'boolean',
		mode = 'string'
	}
	
	for k, v in pairs(possibleValue) do
		local value = t[k]
		if value ~= nil then
			assert(type(value) == v, 'err')
		end
	end
end

return Validator
