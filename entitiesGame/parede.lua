
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local Parede = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")

function Parede:new(x, y)
    local imagePath = "assets/parede.png"
    Parede.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.PAREDE)
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