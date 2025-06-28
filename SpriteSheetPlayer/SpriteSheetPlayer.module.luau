--!strict
local Animator = require(script.Animator)
local Registry = require(script.Registry)

local SP2 = {}

function SP2.new(name: string, imageLabel: ImageLabel, gridSize: number, framerate: number)
	return Animator.new(name, imageLabel, gridSize, framerate)
end

function SP2.playWithRectAsync(anim, imageSize: number)
	local co: thread = task.spawn(function()
		anim:playWithRect(imageSize)
	end)
	
	Registry.add(anim.name, co)
end

function SP2.stop(name: string)
	local co: thread = Registry.get(name)
	task.cancel(co)
end

return SP2
