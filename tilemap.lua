local lvlhnd = {}

local currentLevel
local level = {}
level.__index = level

local tileLayer = {}
tileLayer.__index = tileLayer
function tileLayer:new(w,h)
    local new = {
        texture = nil,
        tileData = range(1, w*h, -1)
    }
    return setmetatable(new, tileLayer)
end

function lvlhnd.newLevel(w, h)
    local newLevel = {
        metadata = {
            width = w,
            height = h
        },
        objects = {},
        layers = {
            --visual-only--

            visual_top = tileLayer:new(w,h),
            visual_bottom = tileLayer:new(w,h),

            --debug/collision--

            solid = {},
            jump_thru = {},
            top_layer = {},
            bottom_layer = {}
        },
        tileSize = 16
    }
    return setmetatable(newLevel, level)
end

function level:setupLevel()
    self.layers['solid'] = {0}
    currentLevel = self
end

function level:modifyTile(x, y, textureIndex, layer) 
    layer = layer or 'visual_top'
    local width, height, size = self:getDimensions()
    local index = y * width + x + 1

    if index >= 1 
    and index <= width * height then
        self.layers[layer].tileData[index] = textureIndex
    end
end

function level:setVisualTileset(size, texture1, texture2)
    texture2 = texture2 or texture1
    self.layers.visual_top.texture = texture1
    self.layers.visual_bottom.texture = texture2
    self.tileSize = size
end

function level:getDimensions()
    return self.metadata.width, self.metadata.height, self.tileSize
end

function level:draw()
    local width, height, size = self:getDimensions()
    local tiles = self.layers.visual_top.tileData
    local texture = self.layers.visual_top.texture

    if not texture then
        return
    end

    local textureWidth, textureHeight = texture:getDimensions()
    local tilesetWidth = textureWidth / size

    for index = 1, width * height do
        local v = tiles[index]

        if v >= 0 then
            -- Quad handling
            local quad_col = v % tilesetWidth
            local quad_row = math.floor(v / tilesetWidth)

            local quad_region_x = quad_col * size
            local quad_region_y = quad_row * size

            local quad = love.graphics.newQuad(
                quad_region_x,
                quad_region_y,
                size,
                size,
                textureWidth,
                textureHeight
            )

            -- Positioning
            local zeroIndex = index - 1
            local col = zeroIndex % width
            local row = math.floor(zeroIndex / width)

            local x = col * size
            local y = row * size

            -- Rendering
            love.graphics.draw(texture, quad, x, y)
        end
    end
end

function range(start, stop, number)
    step = step or 1
    local array = {}
    for i = start, stop do
        table.insert(array, number)
    end
    return array
end

return lvlhnd
