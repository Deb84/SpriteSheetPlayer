--!strict
local Log = require(script.Parent.Parent.Logs.Init)
local Config = require(script.Parent.Parent.Config).SpriteAnimator
local Registry = require(script.Parent.Registry)
local Validator = require(script.Parent.Validator)
local Types = require(script.Parent.Types)


local Animation = {}
Animation.__index = Animation


function Animation.new(name, imageLabel, gridSize, framerate: number) : Types.Animation
	Validator.newCheck(name, imageLabel, gridSize, framerate)

	local self = setmetatable({}, Animation)
	self.name = name
	self.imageLabel = imageLabel
	self.gridSize = gridSize

	-- if framerate return the lower value between framerate & MAX value, if not framerate return DEFAULT value
	self.framerate = (framerate and math.min(framerate, Config.MAX_FPS)) or Config.DEFAULT_FPS

	self.state = false -- false stopped, true playing
	self.async = nil
	self.pos = nil
	self.paused = false

	return self :: any
end

local function nextGridPos(gridPos, gridSize)
	gridPos += Vector2.new(1,0)

	if gridPos.X == gridSize then
		gridPos = Vector2.new(0, gridPos.Y + 1)
	end
	if gridPos.Y == gridSize then
		gridPos = Vector2.new(0,0)
	end

	return gridPos
end


-- use the rectOffset to play a sprite sheet
function Animation:play(imageSize: number, lastPos: Vector2?)
	if not self.async then
		Validator.playCheck(imageSize)
	end

	self.imageSize = imageSize
	self.mode = 'playWithRect'
	local imageLabel = self.imageLabel
	local gridSize: number = self.gridSize

	local offset: number = math.min(imageSize / gridSize, Config.MAX_IMAGESIZE / gridSize)
	local framerate: number = 1 / math.min(self.framerate, Config.MAX_FPS)

	imageLabel.ImageRectSize = Vector2.new(offset, offset)

	local gridPos = lastPos or Vector2.new(0,0)

	self.state = true

	-- render loop
	while task.wait(framerate) and self.state do

		gridPos = nextGridPos(gridPos, gridSize) :: Vector2

		self.pos = gridPos

		imageLabel.ImageRectOffset = Vector2.new(gridPos.X * offset, gridPos.Y * offset)
	end
end


-- Async
function Animation:playAsync(imageSize)
	Validator.playCheck(imageSize)

	self.async = true
	local co: thread = task.spawn(function()
		self:play(imageSize)
	end)

	Registry.add(self.name, co)
end

function Animation:unpause()
	self.paused = false

	local lastPos = self.pos

	if self.async then
		local co: thread = task.spawn(function()
			self:play(self.imageSize, lastPos)
		end)

		Registry.add(self.name, co)
	else
		self:play(self.imageSize, lastPos)
	end
end

function Animation:pause(pauseTime: number?)
	Validator.pauseCheck(pauseTime)
	self:stop()
	self.paused = true

	if type(pauseTime) == 'number' then
		task.wait(pauseTime)
		self:unpause()
	end
end


function Animation:edit(t)
	Validator.editCheck(t)
	self:pause()

	for key, value in pairs(t) do
		self[key] = value
	end

	self:unpause()
end


-- stop
function Animation:stop()
	local co: thread = Registry.get(self.name)
	task.cancel(co)
	self.state = false
end


function Animation:delete()
	if self.state then
		self:stop()
	end
	if Registry.exist(self.name) then
		Registry.remove(self.name)
	end
end


return Animation
