local Types = {}


export type Animation = {
	name: string,
	imageLabel: ImageLabel,
	imageSize: number,
	gridSize: number,
	framerate: number,
	state: boolean,
	async: boolean,
	pos: nil | Vector2,
	paused: boolean,
	
	new: () -> (),
	play: (self: Animation, lastPos: Vector2?) -> (),
	playAsync: (self: Animation, lastPos: Vector2?) -> (),
	unpause: (self: Animation) -> (),
	pause: (self: Animation, pauseTime: number?) -> (),
	edit: (self: Animation, t: {
		gridSize: number?,
		framerate: number?,
		state: boolean?,
		imageSize: boolean?,
		mode: string?
	}) -> (),
	stop: () -> ()
}


return Types
