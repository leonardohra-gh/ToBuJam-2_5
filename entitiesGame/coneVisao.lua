
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local ConeVisao = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")

function ConeVisao:new(x, y)
    local imagePath = "assets/coneVisao.png"
    ConeVisao.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.DYNAMIC, EntityTags.CONE_VISAO, true)
end

function ConeVisao:update(dt)
    ConeVisao.super.update(self, dt)
end

function ConeVisao:draw()
    ConeVisao.super.draw(self)
end

-- function MyEntity:beginContact(entidade_colisora, coll)
-- end

function ConeVisao:destruir()
    self.toBeDestroyed = true
end

return ConeVisao