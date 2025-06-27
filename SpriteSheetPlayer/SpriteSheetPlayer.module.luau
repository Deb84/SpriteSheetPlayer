local SSP = {}

local Player = require(script.Player)
local Registry = require(script.Registry)


function SSP.PlayWithRect(imageLabel: Instance, gridSize: number, imageSize : number, fps: number)
	Player.PlayWithRect(imageLabel, gridSize, imageSize, fps)
end


function SSP.PlayWithPosition(imageLabel: Instance, part: Instance, gridSize: number, fps: number)
	Player.PlayWithPosition(imageLabel, part, gridSize, fps)
end


function SSP.AsyncPlayWithRect(taskName: string, imageLabel: Instance, gridSize: number, imageSize : number, fps: number)
	local co = task.spawn(function()
		Player.PlayWithRect(imageLabel, gridSize, imageSize, fps)
	end)
	Registry.add(taskName, {co = co, imageLabel = imageLabel, gridSize = gridSize, imageSize = imageSize, fps = fps})
end


function SSP.AsyncPlayWithPositon(taskName: Instance, imageLabel: Instance, part: Instance, gridSize: number, fps: number)
	local co = task.spawn(function()
		Player.PlayWithPosition(imageLabel, part, gridSize, fps)
	end)
	Registry.add(taskName, {co = co, imageLabel = imageLabel, part = part, gridSize = gridSize, fps = fps})
end


function SSP.StopPlay(taskName)
	local co = Registry.get(taskName)
	task.cancel(co.co)
end
	
return SSP
