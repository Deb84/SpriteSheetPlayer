# SpriteSheetPlayer for Roblox
SpriteSheetPlayer is a mini-lib for Roblox written in Luau which allows to use spritesheet/flipbook on an ```imageLabel``` Instance.


## How to use

You can simply require the lib like this
```luau
local SpriteSheetPlayer = require(ReplicatedStorage.SpriteSheetPlayer.SpriteSheetPlayer)
```
---

### The lib has actually four function to play an sprite sheet animation:

#### Variables used:
```imageLabel``` The imageLabel instance

```part``` The part where the animation plays, only if you use ```PlayWithPosition``` (needed to calculate the offset)

```gridSize``` The number of rows and columns (exemple: 8, only square are supported for now)

```imageSize``` The total sprite sheet size in pixel, only if you use ```PlayWithRect``` (exemple: 1024, needed to calculate the size of the frames)

```fps``` Frame Per Second (FPS) (exemple: 24)


### Sync:

```PlayWithRect```
<br>
Play a sprite sheet animation synchronously:
<br>
```luau
SpriteSheetPlayer.PlayWithRect(imageLabel, gridSize, imageSize, fps)
SpriteSheetPlayer.PlayWithRect(imageLabel, 8, 1024, 24)
```
```PlayWithPosition```
<br>
```luau
SpriteSheetPlayer.PlayWithPosition(imageLabel, part, gridSize, fps)
SpriteSheetPlayer.PlayWithPosition(imageLabel, part, 8, 24)
```
> [!WARNING]\
> For now, synchronous can't be stopped, the sprite sheet can maybe played forever
> 
### Async:

Play a sprite sheet animation asynchronously:

```AsyncPlayWithRect```
<br>
```luau
SpriteSheetPlayer.AsyncPlayWithRect(taskName, imageLabel, gridSize, imageSize, fps)
SpriteSheetPlayer.AsyncPlayWithRect('1', imageLabel, 8, 1024, 24)
```
```AsyncPlayWithPositon```
<br>
```luau
SpriteSheetPlayer.AsyncPlayWithPosition('myAnimation', imageLabel, part, 8, 24)
```

### Difference between PlayWithRect and PlayWithPosition :

```PlayWithRect``` crops the sprite sheet to the frame size (recommended).

```PlayWithPosition``` adjusts the size and position of the entire sprite sheet to match the target frame.

