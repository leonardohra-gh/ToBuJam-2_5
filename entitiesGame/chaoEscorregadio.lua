
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local ChaoEscorregadio = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")

function ChaoEscorregadio:new(x, y)
    local imagePath = "assets/chao_escorregadio.png"
    local atravessavel, size, drawPriority = true, nil, PrioridadeDesenho.CHAO_ESCORREGADIO
    ChaoEscorregadio.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.DYNAMIC, EntityTags.CHAO_ESCORREGADIO, atravessavel, size, drawPriority)
end

function ChaoEscorregadio:update(dt)
    ChaoEscorregadio.super.update(self, dt)
end

function ChaoEscorregadio:draw()
    ChaoEscorregadio.super.draw(self)
end

-- function ChaoEscorregadio:beginContact(entidade_colisora, coll)
-- end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

-- function MyEntity:preSolve(entidade_colisora, b, coll)
-- end

-- function MyEntity:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
-- end

function ChaoEscorregadio:destruir()
    self.toBeDestroyed = true
end

return ChaoEscorregadio