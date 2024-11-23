local Entity = require('core.entity')
local Rua = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")

function Rua:new(x, y)
    local imagePath = "assets/rua.png"
    Rua.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC)
end

function Rua:update(dt)
    Rua.super.update(self, dt)
end

return Rua