# tilemap.lua - LOVE2D Tilemap library

tilemap.lua is a simple implementation of a tilemap / level system that aims to help beginners create tile based games without having to deal with tiled because tiled is scary and mean

## how to setup

this is how you can easily setup your level
```lua
local tilemap = require 'yourLibraryFolder/tilemap'

local tileset = love.graphics.newImage('path/to/your/image.png')
local exampleMap = tilemap.newLevel(16, 16) -- width, height ( in tiles )
exampleMap.setVisualTileset(16, tileset) -- cell-size ( in pixels ), tileset-image
```

### methods for usage

* ```level:setupLevel()``` - currently does nothing of value, do not use
* ```level:modifyTile(x, y, textureIndex, layer)``` - changes a tile at position (x, y) in tiles, to a tile number (textureIndex), on the specified layer or the default layer
* ```level:draw(layer)``` - draws all the tiles on a specific or default layer

### list of layers for reference

```lua
layers = {
    --visual-only--

    'visual_top',
    'visual_bottom',

    --debug/collision--

    'solid',
    'jump_thru',
    'top_layer',
    'bottom_layer'
},
```
