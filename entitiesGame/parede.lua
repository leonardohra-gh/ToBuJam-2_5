
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local Parede = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
local OrientacaoParede = require("enumsGame.OrientacaoParede")

function Parede:new(x, y, orientacao)
    orientacao = orientacao or OrientacaoParede.SIMPLES_VERTICAL
    local atravessavel, size, drawPriority = false, nil, PrioridadeDesenho.PAREDE
    Parede.super.new(self, x, y, orientacao, World, ShapeTypes.CIRCLE, BodyTypes.STATIC, EntityTags.PAREDE, atravessavel, size, drawPriority)
end

function Parede:update(dt)
    Parede.super.update(self, dt)
end

function Parede:draw()
    Parede.super.draw(self)
end

function Parede:destruir()
    self.toBeDestroyed = true
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