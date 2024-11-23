local Entity = require('core.entity')
local Casa = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")

function Casa:new(x, y)
    local imagePath = "assets/casa.png"
    Casa.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC)
end

function Casa:update(dt)
    Casa.super.update(self, dt)
end

return Casa