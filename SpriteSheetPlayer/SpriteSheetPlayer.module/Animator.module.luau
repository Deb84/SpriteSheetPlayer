--!strict
local Config = require(script.Parent.Parent.Config)
local Registry = require(script.Parent.Registry)
local Animator = {}

type anim = {
	gridSize: number?,
	framerate: number?,
	state: boolean?,
	imageSize: boolean?,
	part: BasePart?,
}


local Animations = {}
Animations.__index = Animations


function Animations.new(name: string, imageLabel: ImageLabel, gridSize: number, framerate: number)
	local self = setmetatable({}, Animations)
	self.name = name
	self.imageLabel = imageLabel
	self.gridSize = gridSize
	
	-- if framerate return the lower value between framerate & MAX value, if not framerate return DEFAULT value
	self.framerate = (framerate and math.min(framerate, Config.MAX_FPS)) or Config.DEFAULT_FPS
	
	self.state = false -- false stopped, true running
	self.edited = 0 -- 0 false, 1 true (not a bool due to a Luau bug)
	
	return self
end

-- use the rectOffset to play a sprite sheet
function Animations:playWithRect(imageSize: number)
	self.imageSize = imageSize
	local imageLabel = self.imageLabel
	local gridSize = self.gridSize

	if imageSize > 1024 then -- limit the size (1024px is the roblox limitation)
		imageSize = 1024
	end

	local offset: number = imageSize / gridSize :: number
	local framerate: number = 1/self.framerate :: number

	imageLabel.ImageRectSize = Vector2.new(offset, offset)

	local x: number = 0
	local y: number = 0
	
	self.state = true
	
	while task.wait(framerate) and self.state do
		if self.edited == 1 then
			self.edited = 0
			self:playWithRect(self.imageSize)
			break
		end
		
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

-- use the position to play a sprite sheet
function Animations:playWithPosition(part: BasePart)
	self.part = part
	local imageLabel = self.imageLabel
	local gridSize = self.gridSize
	
	local offset: number = -(part.Size.Y * 50)

	local framerate: number = 1/math.min(self.framerate, Config.MAX_FPS)

	imageLabel.Size = UDim2.new(gridSize, 0, gridSize, 0)

	local x: number = 0
	local y: number = 0
	
	self.state = true
	
	while task.wait(framerate) and self.state do
		if self.edited == 1 then
			self.edited = 0
			self:playWithRect(self.part)
			break
		end
		
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
	self.state = false
end


function Animations:edit(t: {[string]: anim})
	for key, value in pairs(t) do
		self[key] = value
		self.edited = 1 :: any
	end
end



function Animator.new(name: string, imageLabel: ImageLabel, gridSize: number, framerate: number)
	return Animations.new(name, imageLabel, gridSize, framerate)
end


return Animator
