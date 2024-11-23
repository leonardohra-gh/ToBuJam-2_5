local Object = require("libs.classic")
local Drawer = Object:extend()

function Drawer:new(imagePath)
    self.image = love.graphics.newImage(imagePath)
end

function Drawer:draw(x, y, rotation, scaleX, scaleY)
    local offsetX = self.image:getWidth()/2
    local offsetY = self.image:getHeight()/2
    love.graphics.draw(
        self.image,
        x or 0,
        y or 0,
        rotation or 0,
        scaleX or 1,
        scaleY or 1,
        offsetX or 0,
        offsetY or 0
    )
end

function Drawer:getWidth()
    return self.image:getWidth()
end

function Drawer:getHeight()
    return self.image:getHeight()
end

return Drawer