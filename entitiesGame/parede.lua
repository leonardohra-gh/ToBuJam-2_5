
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local Parede = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
local OrientacaoParede = require("enumsGame.OrientacaoParede")

function Parede:new(x, y, orientacao)
    orientacao = orientacao or OrientacaoParede.SIMPLES_VERTICAL
    Parede.super.new(self, x, y, orientacao, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.PAREDE)
end

function Parede:update(dt)
    Parede.super.update(self, dt)
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