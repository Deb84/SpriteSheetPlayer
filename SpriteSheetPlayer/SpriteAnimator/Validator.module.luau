local Log = require(script.Parent.Parent.Logs.Init)
local Validator = {}

function Validator.newCheck(name, imageLabel, gridSize, framerate)
	assert(name, Log.get('error', 'SA_INV_NAME', 'nil', 5))
	assert(imageLabel, Log.get('error', 'SA_INV_IMGLB', 'nil', 5))
	assert(gridSize, Log.get('error', 'SA_INV_GRIDSIZE', 'nil', 5))
	assert(framerate, Log.get('error', 'SA_INV_FRATE', 'nil', 5))
	
	local _type
	_type = type(name)
	assert(_type == 'string', Log.get('error', 'SA_INV_NAME', _type, 5))
	
	_type = (typeof(imageLabel) == 'Instance' and imageLabel.ClassName) or type(imageLabel)
	assert(_type == 'ImageLabel', Log.get('error', 'SA_INV_IMGLB', _type, 5))
	
	_type = type(gridSize)
	assert(_type == 'number', Log.get('error', 'SA_INV_GRIDSIZE', _type, 5))
	
	_type = type(framerate)
	assert(_type == 'number', Log.get('error', 'SA_INV_FRATE', _type, 5))
end

function Validator.playCheck(imageSize)
	assert(imageSize, Log.get('error', 'SA_INV_IMGSIZE', 'nil', 5))
	
	local _type = type(imageSize)
	assert(type(imageSize) == 'number', Log.get('error', 'SA_INV_IMGSIZE', _type, 5))
end

function Validator.editCheck(t: {any})
	assert(t, Log.get('error', 'SA_INV_EDIT_T', 'nil', 5))
	
	local _type = type(t)
	assert(_type == 'table', Log.get('error', 'SA_INV_EDIT_T', _type, 5))
	
	local possibleValue = {
		gridSize = 'number',
		framerate = 'number',
		state = 'boolean',
		imageSize = 'boolean',
		mode = 'string'
	}
	
	for k, v in pairs(possibleValue) do
		local validValue = false
		
		local value = t[k]
		if value ~= nil then
			validValue = true
			
			_type = type(value)
			assert(_type == v, Log.get('error', 'SA_INV_EDIT', {k, v, _type}, 5))
		end
		
		assert(validValue, Log.get('error', 'SA_INV_EDIT_V', nil, 4))
	end
end

return Validator
