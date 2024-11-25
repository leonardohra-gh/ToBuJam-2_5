local Entity = require('core.entity')
local PrioridadeDesenho = require('enumsGame.PrioridadeDesenho')
local Rua = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")
local EntityTags = require("enumsGame.EntityTags")

function Rua:new(x, y, rotated)
    local imagePath = "assets/rua.png"
    local atravessavel, size, drawPriority = true, nil, PrioridadeDesenho.RUA
    self.rotated = rotated
    Rua.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.RUA, atravessavel, size, drawPriority)
end

function Rua:update(dt)
    Rua.super.update(self, dt)
end

function Rua:draw()
    Rua.super.draw(self, self.rotated)
end

return Rua