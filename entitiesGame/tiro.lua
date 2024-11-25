
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local Tiro = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")

function Tiro:new(x, y, velocityX, velocityY)
    local imagePath = "assets/tiro.png"
    local atravessavel, size, drawPriority = true, nil, PrioridadeDesenho.TIRO
    Tiro.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.DYNAMIC, EntityTags.TIRO, atravessavel, size, drawPriority)
    self.physics:setVelocity(velocityX, velocityY)
end

function Tiro:update(dt)
    Tiro.super.update(self, dt)

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

function Tiro:draw()
    Tiro.super.draw(self)
end

function Tiro:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        finalizarJogo()
    end
    if entidade_colisora.tag == EntityTags.PAREDE then
        self:destruir()
    end
end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

-- function MyEntity:preSolve(entidade_colisora, b, coll)
-- end

-- function MyEntity:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
-- end

function Tiro:destruir()
    self.toBeDestroyed = true
end

return Tiro