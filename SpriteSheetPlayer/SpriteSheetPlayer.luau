--!strict
local Animation = require(script.Parent.SpriteAnimator.SpriteAnimator)

local SP2 = {}

function SP2.new(name: string, imageLabel: ImageLabel, gridSize: number, framerate: number)
	return Animation.new(name, imageLabel, gridSize, framerate)
end

return SP2
