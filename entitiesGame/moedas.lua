
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local Moedas = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")

function Moedas:new(x, y)
    local imagePath = "assets/moedas.png"
    Moedas.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.STATIC, "moedas")
end

function Moedas:update(dt)
    Moedas.super.update(self, dt)
end

function Moedas:draw()
    Moedas.super.draw(self)
end

function Moedas:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        local jogador = GetWorldEntitiesByTag(EntityTags.JOGADOR)[1]
        jogador.mochila:AddDinheiro(100)
        self:destruir()
    end
end

function Moedas:destruir()
    self.toBeDestroyed = true
end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

-- function MyEntity:preSolve(entidade_colisora, b, coll)
-- end

-- function MyEntity:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
-- end

return Moedas