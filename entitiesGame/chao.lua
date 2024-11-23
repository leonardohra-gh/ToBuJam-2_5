
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local Chao = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")

function Chao:new(x, y)
    local imagePath = "assets/chao.png"
    local atravessavel = true
    Chao.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.CHAO, atravessavel)
end

function Chao:update(dt)
    Chao.super.update(self, dt)
end

function Chao:draw()
    Chao.super.draw(self)
end

-- function MyEntity:beginContact(entidade_colisora, coll)
-- end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

-- function MyEntity:preSolve(entidade_colisora, b, coll)
-- end

-- function MyEntity:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
-- end

return Chao