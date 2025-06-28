--!strict
local Animator = require(script.Animator)

local SP2 = {}

function SP2.new(name: string, imageLabel: ImageLabel, gridSize: number, framerate: number)
	return Animator.new(name, imageLabel, gridSize, framerate)
end

return SP2
