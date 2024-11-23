
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local ConeVisao = Entity:extend()

function ConeVisao:new(x, y)
    local imagePath = "assets/coneVisao.png"
    ConeVisao.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.DYNAMIC, "coneVisao", true)
end

function ConeVisao:update(dt)
    ConeVisao.super.update(self, dt)
end

function ConeVisao:draw()
    ConeVisao.super.draw(self)
end

-- function MyEntity:beginContact(entidade_colisora, coll)
-- end

return ConeVisao