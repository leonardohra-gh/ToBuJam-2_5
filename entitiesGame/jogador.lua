local Entity = require('core.entity')
local Jogador = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")

function Jogador:new(x, y)
    local imagePath = "assets/jogador.png"
    Jogador.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.DYNAMIC)
    self.speed = 100
end

function Jogador:update(dt)
    
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
    Jogador.super.update(self, dt)
end

function Jogador:draw()
    Jogador.super.draw(self)
end

function Jogador:beginContact(entidade_colisora, coll)
end

function Jogador:endContact(entidade_colisora, b, coll)
end

function Jogador:preSolve(entidade_colisora, b, coll)
end

function Jogador:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
end

return Jogador