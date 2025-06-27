# SpriteSheetPlayer for Roblox
SpriteSheetPlayer is a mini-lib for Roblox written in Luau which allows to use spritesheet/flipbook on an ```imageLabel``` Instance.


## How to use

You can simply require the lib like this
```luau
local SpriteSheetPlayer = require(<location>.SpriteSheetPlayer.SpriteSheetPlayer)
```
---

### The lib has actually four function to play an sprite sheet animation:

#### Variables used:
```imageLabel``` The imageLabel instance

```part``` The part where the animation plays, only if you use ```PlayWithPosition``` (needed to calculate the offset)

```gridSize``` The number of rows and columns

```imageSize``` The total sprite sheet size in pixel, only if you use ```PlayWithRect``` (needed to calculate the size of the frames)

```fps``` Frame Per Second (FPS)


### Sync:

```PlayWithRect```
<br>
Play a sprite sheet animation synchronously:
<br>
```luau
SpriteSheetPlayer.PlayWithRect(imageLabel, gridSize, imageSize, fps)
```
```PlayWithPosition```
<br>
```luau
SpriteSheetPlayer.PlayWithPosition(imageLabel, part, gridSize, fps)
```
> [!WARNING]\
> For now, synchronous can't be stopped, the can maybe played forever
> 
### Async:

Play a sprite sheet animation asynchronously:

```AsyncPlayWithRect```
<br>
```luau
SpriteSheetPlayer.AsyncPlayWithRect(taskName, imageLabel, gridSize, imageSize, fps)
```
```AsyncPlayWithPositon```
<br>
```luau
SpriteSheetPlayer.AsyncPlayWithPosition(taskName, imageLabel, part, gridSize, fps)
```

### Difference between PlayWithRect and PlayWithPosition :

```PlayWithRect``` crops the sprite sheet to the frame size (recommended).

```PlayWithPosition``` adjusts the size and position of the entire sprite sheet to match the target frame.

