local Entity = require('core.entity')
local Jogador = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")
local MyEntity = Entity:extend()

function Jogador:new(x, y)
    local imagePath = "assets/NOMEDAIMAGEM.png"
    MyEntity.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.DYNAMIC)
end

function Jogador:update()
    
    local velocityX, velocityY = 0, 0

    if love.keyboard.isDown("right") then
        velocityX = self.speed
    end
    if love.keyboard.isDown("left") then
        velocityX = - self.speed
    end
    if love.keyboard.isDown("up") then
        velocityY = - self.speed
    end
    if love.keyboard.isDown("down") then
        velocityY = self.speed
    end

    self.physics:setVelocity(velocityX, velocityY)
end

return Jogador