--!strict
local Config = require(script.Parent.Parent.Config)
local Registry = require(script.Parent.Registry)
local Animator = {}


local Animations = {}
Animations.__index = Animations

function Animations.new(name: string, imageLabel: ImageLabel, gridSize: number, framerate: number)
	local self = setmetatable({}, Animations)
	self.name = name
	self.imageLabel = imageLabel
	self.gridSize = gridSize
	self.framerate = framerate
	
	self.state = false -- false stopped, true running
	
	return self
end


local function play()
	
end


function Animations:playWithRect(imageSize: number)
	local imageLabel = self.imageLabel
	local gridSize = self.gridSize

	if imageSize > 1024 then -- limit the size (1024px is the roblox limitation)
		imageSize = 1024
	end

	local offset: number = imageSize / gridSize :: number
	local framerate: number = 1/math.min(self.framerate, Config.MAX_FPS)

	imageLabel.ImageRectSize = Vector2.new(offset, offset)

	local x: number = 0
	local y: number = 0
	
	self.state = true
	
	while task.wait(framerate) and self.state do
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

function Animations:playWithPosition(part: BasePart)
	local imageLabel = self.imageLabel
	local gridSize = self.gridSize
	
	local offset: number = -(part.Size.Y * 50)

	local framerate: number = 1/math.min(self.framerate, Config.MAX_FPS)

	imageLabel.Size = UDim2.new(gridSize, 0, gridSize, 0)

	local x: number = 0
	local y: number = 0
	
	self.state = true
	
	while task.wait(framerate) and self.state do
		local xScale: number = imageLabel.Position.X.Scale
		local yScale: number = imageLabel.Position.Y.Scale

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


-- Async

function Animations:playAsyncWithRect(imageSize: number)
	local co: thread = task.spawn(function()
		self:playWithRect(imageSize)
	end)
	
	Registry.add(self.name, co)
end


function Animations:playAsyncWithPosition(part: BasePart)
	local co: thread = task.spawn(function()
		self:playWithPosition(part)
	end)
	
	Registry.add(self.name, co)
end

-- stop
function Animations:stop()
	local co: thread = Registry.get(self.name)
	task.cancel(co)
end



function Animator.new(name: string, imageLabel: ImageLabel, gridSize: number, framerate: number)
	return Animations.new(name, imageLabel, gridSize, framerate)
end


return Animator
