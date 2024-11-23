local Entity = require('core.entity')
local Rua = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")

function Rua:new(x, y, rotated)
    local imagePath = "assets/rua.png"
    local atravessavel = true
    self.rotated = rotated
    Rua.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, "rua", atravessavel)
end

function Rua:update(dt)
    Rua.super.update(self, dt)
end

function Rua:draw()
    Rua.super.draw(self, self.rotated)
end

return Rua