local Entity = require('core.entity')
local Casa = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")
local EntityTags = require("enumsGame.EntityTags")
local Tamagochi = require("entitiesGame.tamagochi")

function Casa:new(x, y)
    local imagePath = "assets/casa.png"
    Casa.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.CASA, true)
    local casaX, casaY = self.physics:getPositionRounded()
    if math.random() <= 1 then
        self.tamagotchi = Tamagochi(casaX, casaY)
    end
end

function Casa:update(dt)
    Casa.super.update(self, dt)
end

function Casa:draw()
    Casa.super.draw(self)
    if not (self.tamagotchi == nil) then
        self.tamagotchi:desenharNecessidades()
    end
    
end

function Casa:destruir()
    self.tamagotchi:destruir()
    self.toBeDestroyed = true
end

return Casa