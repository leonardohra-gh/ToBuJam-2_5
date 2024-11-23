
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local Parede = Entity:extend()

function Parede:new(x, y)
    local imagePath = "assets/parede.png"
    Parede.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, "parede")
end

function Parede:update(dt)
    Parede.super.update(self, dt)

    -- local velocityX, velocityY = 0, 0

    -- if love.keyboard.isDown("right") then
    --     velocityX = self.speed
    -- end
    -- if love.keyboard.isDown("left") then
    --     velocityX = - self.speed
    -- end
    -- if love.keyboard.isDown("up") then
    --     velocityY = - self.speed
    -- end
    -- if love.keyboard.isDown("down") then
    --     velocityY = self.speed
    -- end

    -- self.physics:setVelocity(velocityX, velocityY)
end

function Parede:draw()
    Parede.super.draw(self)
end

-- function MyEntity:beginContact(entidade_colisora, coll)
-- end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

-- function MyEntity:preSolve(entidade_colisora, b, coll)
-- end

-- function MyEntity:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
-- end

return Parede