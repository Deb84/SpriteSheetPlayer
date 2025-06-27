local Config = require(script.Parent.Parent.Config)
local Player = {}


function Player.PlayWithRect(imageLabel: Instance, gridSize: number, imageSize: number, fps: number)
	local texture = imageLabel.Image
	
	if imageSize > 1024 then -- limit the size (1024px is the roblox limitation)
		imageSize = 1024
	end

	local offset = imageSize / gridSize
	local fps = 1/math.min(fps, Config.MAX_FPS)

	imageLabel.ImageRectSize = Vector2.new(offset, offset)

	local basePos = nil
	local x = 0
	local y = 0

	while task.wait(fps) do
		x += 1

		if x == gridSize then
			x = 0
			y += 1
		end
		if y == gridSize then
			x = 0
			y = 0
		end

		imageLabel.ImageRectOffset = Vector2.new(x * offset, y * offset)

	end
end

function Player.PlayWithPosition(imageLabel: Instance, part: Instance, gridSize: number, fps: number)
	local texture = imageLabel.Image
	local offset = -(part.Size.Y * 50)

	local fps = 1/math.min(fps, Config.MAX_FPS)

	imageLabel.Size = UDim2.new(gridSize, 0, gridSize, 0)

	local basePos = nil
	local x = 0
	local y = 0

	while task.wait(fps) do
		local xScale = imageLabel.Position.X.Scale
		local yScale = imageLabel.Position.Y.Scale

		x += 1

		if x == gridSize then
			x = 0
			y += 1
		end
		if y == gridSize then
			x = 0
			y = 0
		end

		imageLabel.Position = UDim2.new(
			xScale, x * offset,
			yScale, y * offset
		)

	end
end

return Player
