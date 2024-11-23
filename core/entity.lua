local Object = require("libs.classic")
local Entity = Object:extend()
local Drawer = require("core.drawer")
local Size = require("core.structures.size")
local Physics = require("core.physics")

function Entity:new(x, y, imagePath, world, shapeType, bodyType, tag)
    if imagePath == nil then
        self.drawer = nil
        self.size = nil
    else
        self.drawer = Drawer(imagePath)
        self.size = Size(self.drawer:getWidth(), self.drawer:getHeight())
    end

    self.physics = Physics(
        world,
        {x = x, y = y},
        self.size,
        shapeType,
        bodyType
    )
    self.physics:setUserData(self)
    self.toBeDestroyed = false
    self.tag = tag or "entity"
end

function Entity:getTag()
    return self.tag
end

function Entity:update(dt)
    if self.toBeDestroyed then
        self:destroy()
    end
end

function Entity:draw(rotation, scaleX, scaleY)
    local x, y = self.physics:getPositionRounded()
    self.drawer:draw(
        x,
        y,
        rotation or 0,
        scaleX or 1,
        scaleY or 1
    )
end

function Entity:isOutOfScreen()
    local currentX, currentY = self.physics:getPositionRounded()
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    local imageWidth, imageHeight = self.drawer:getWidth(), self.drawer:getHeight()
    local leftCompletelyHorizontalAxisLeft = (currentX - imageWidth/2 < 0)
    local leftCompletelyHorizontalAxisRight = (currentX - imageWidth/2 > screenWidth)
    local leftCompletelyVerticalAxisTop = (currentY - imageHeight/2 < 0)
    local leftCompletelyVerticalAxisBottom = (currentY - imageHeight/2 > screenHeight)
    return leftCompletelyHorizontalAxisLeft or leftCompletelyHorizontalAxisRight or leftCompletelyVerticalAxisTop or leftCompletelyVerticalAxisBottom
end

function Entity:getPhysics()
    return self.physics
end

function Entity:destroy()
    if self.physics and self.physics.body then
        self.physics.body:destroy()
        self.physics = nil
    end
end

return Entity