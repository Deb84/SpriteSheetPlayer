--!strict
type SpriteAnimator = {
	MAX_FPS: number,
	DEFAULT_FPS: number,
	MAX_IMAGESIZE: number
}

local Config = {
	SpriteAnimator = {
		MAX_FPS = 60, -- default value: 60
		DEFAULT_FPS = 24, -- default value: 24
		MAX_IMAGESIZE = 1024 -- default value: 1024 (px), this is the roblox limitation
	} :: SpriteAnimator
	
	
}

return Config
