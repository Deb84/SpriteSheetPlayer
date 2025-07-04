local Log = require(script.Parent.Parent.Logs.Init)

local Validator = {}

function Validator.newCheck(name, imageLabel, gridSize, framerate)
	local debugLevel = 6

	assert(name, Log.get('error', 'SA_INV_NAME', 'nil', debugLevel))
	assert(imageLabel, Log.get('error', 'SA_INV_IMGLB', 'nil', debugLevel))
	assert(gridSize, Log.get('error', 'SA_INV_GRIDSIZE', 'nil', debugLevel))
	assert(framerate, Log.get('error', 'SA_INV_FRATE', 'nil', debugLevel))
	
	local _type
	_type = type(name)
	assert(_type == 'string', Log.get('error', 'SA_INV_NAME', _type, debugLevel))
	
	_type = (typeof(imageLabel) == 'Instance' and imageLabel.ClassName) or type(imageLabel)
	assert(_type == 'ImageLabel', Log.get('error', 'SA_INV_IMGLB', _type, debugLevel))
	
	_type = type(gridSize)
	assert(_type == 'number', Log.get('error', 'SA_INV_GRIDSIZE', _type, debugLevel))
	
	_type = type(framerate)
	assert(_type == 'number', Log.get('error', 'SA_INV_FRATE', _type, debugLevel))
end


function Validator.playCheck(imageSize)
	local debugLevel = 5

	assert(imageSize, Log.get('error', 'SA_INV_IMGSIZE', 'nil', debugLevel))
	
	local _type = type(imageSize)
	assert(type(imageSize) == 'number', Log.get('error', 'SA_INV_IMGSIZE', _type, debugLevel))
end


function Validator.pauseCheck(pauseTime)
	local debugLevel = 5

	assert(pauseTime, Log.get('error', 'SA_INV_TIMEPAUSE', 'nil', debugLevel))

	local _type = type(pauseTime)
	assert(_type == 'number', Log.get('error', 'SA_INV_TIMEPAUSE', _type, debugLevel))
end

function Validator.editCheck(t: {any})
	local debugLevel = 4

	assert(t, Log.get('error', 'SA_INV_EDIT_T', 'nil', debugLevel))
	
	local _type = type(t)
	assert(_type == 'table', Log.get('error', 'SA_INV_EDIT_T', _type, debugLevel))
	
	local possibleValue = {
		gridSize = 'number',
		framerate = 'number',
		state = 'boolean',
		imageSize = 'boolean',
		mode = 'string'
	}
	
	local validValue = false
	for k, v in pairs(possibleValue) do
		
		local value = t[k]
		if value ~= nil then
			validValue = true
			
			_type = type(value)
			assert(_type == v, Log.get('error', 'SA_INV_EDIT', {k, v, _type}, debugLevel))
		end
	end
	assert(validValue, Log.get('error', 'SA_INV_EDIT_V', nil, debugLevel))
end

return Validator
