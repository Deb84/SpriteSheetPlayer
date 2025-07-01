# SpriteSheetPlayer for Roblox
SpriteSheetPlayer is a mini-lib for Roblox written in Luau which allows to use spritesheet/flipbook on an ```imageLabel``` Instance.

> [!WARNING]\
> Still in development! A lot of features are not yet implemented

## How to use

You can simply require the lib like this
```luau
local SpriteSheetPlayer = require(Location.SpriteSheetPlayer.SpriteSheetPlayer)
```
---

#### Variables required:
```imageLabel``` The imageLabel instance

```gridSize``` The number of rows and columns (exemple: 8, only square are supported for now)

```imageSize``` The total sprite sheet size in pixel, only if you use ```PlayWithRect``` (exemple: 1024, needed to calculate the size of the frames)

```framerate``` Frame Per Second (FPS) (exemple: 24)

## Fonctions

### Create a new animation

```.new()```
```luau
local animation = SpriteSheetPlayer.new(name, ImageLabel, gridSize, framerate)
```
### Play an animation
Play a sprite sheet animation synchronously:

```:play()```
<br>
```luau
animation:play(imageSize)
```
> [!WARNING]\
> For now, synchronous can't be stopped, the sprite sheet can be played forever
#### Async:

Play a sprite sheet animation asynchronously:

```:playAsync()```
<br>
```luau
animation:playAsync(imageSize)
```
### Stop the animation

```:stop()```
<br>
```luau
animation:stop()
```

---
### Edit the value while an animation is playing

```:edit()```
<br>
```luau
animation:edit({setting = value})
animation:edit({framerate = 15})
```

### Delete an animation

```:delete()```
<br>
```luau
animation:delete()
animation = nil
```
