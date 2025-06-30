local Types = {}


export type Animation = {
	name: string,
	imageLabel: ImageLabel,
	gridSize: number,
	framerate: number,
	state: boolean,
	async: boolean,
	pos: nil | Vector2,
	
	new: () -> (),
	play: (self: Animation, imageSize: number, lastPos: Vector2?) -> (),
	playAsync: (self: Animation, imageSize: number, lastPos: Vector2?) -> (),
	edit: (self: Animation, tbl: {
		gridSize: number?,
		framerate: number?,
		state: boolean?,
		imageSize: boolean?,
		mode: string?
	}) -> (),
	stop: () -> ()
}


return Types
