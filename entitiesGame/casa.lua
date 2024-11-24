local Entity = require('core.entity')
local Casa = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")
local EntityTags = require("enumsGame.EntityTags")
local Tamagochi = require("entitiesGame.tamagochi")

function Casa:new(x, y)
    math.randomseed(os.time() + math.random())
    local corCasa = math.random(5)
    local imagePath = "assets/casa_" .. corCasa .. ".png"
    Casa.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.CASA)
    self.tamagotchi = nil
    -- if math.random() <= 1 then
    --     self:criarTamagotchi()
    -- end
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

function Casa:criarTamagotchi()
    local casaX, casaY = self.physics:getPositionRounded()
    self.tamagotchi = Tamagochi(casaX, casaY - 20)
    
end

function Casa:destruir()
    if not self.tamagotchi == nil then
        self.tamagotchi:destruir()
    end
    self.toBeDestroyed = true
end

return Casa