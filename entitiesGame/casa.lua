local Entity = require('core.entity')
local Casa = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")
local MyEntity = Entity:extend()

function Casa:new(x, y)
    local imagePath = "assets/NOMEDAIMAGEM.png"
    MyEntity.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC)
end

function Casa:update()
    self.super.update(self)
end

return Casa