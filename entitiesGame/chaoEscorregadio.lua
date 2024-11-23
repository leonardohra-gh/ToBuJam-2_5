
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local ChaoEscorregadio = Entity:extend()

function ChaoEscorregadio:new(x, y)
    local imagePath = "assets/chao_escorregadio.png"
    local atravessavel = true
    ChaoEscorregadio.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.DYNAMIC, "chaoEscorregadio", atravessavel)
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

return ChaoEscorregadio