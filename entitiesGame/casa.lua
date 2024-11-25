local Entity = require('core.entity')
local PrioridadeDesenho = require('enumsGame.PrioridadeDesenho')
local Casa = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")
local EntityTags = require("enumsGame.EntityTags")
local Tamagochi = require("entitiesGame.tamagochi")
local InteriorCasa = require("entitiesGame.interiorCasa")

function Casa:new(x, y)
    math.randomseed(os.time() + math.random())
    local corCasa = math.random(5)
    local imagePath = "assets/casa_" .. corCasa .. ".png"
    local atravessavel, size, drawPriority = nil, nil, PrioridadeDesenho.CASA
    atravessavel = true
    Casa.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.CASA, atravessavel, size, drawPriority)
    self.tamagotchi = nil
    self.interior = nil
    self.gerarLayout = false
    -- if math.random() <= 1 then
    --     self:criarTamagotchi()
    -- end
end

function Casa:update(dt)
    Casa.super.update(self, dt)
    if self.gerarLayout then
        self:Entrar()
    end
end

function Casa:draw()
    if not self.physics.body:isActive() then
        return
    end

    Casa.super.draw(self)
    if not (self.tamagotchi == nil) then
        self.tamagotchi:desenharNecessidades()
    end    
end

function Casa:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        self.gerarLayout = true
    end
end

function Casa:Entrar()
    self.interior = InteriorCasa(6, self)
    self.gerarLayout = false
    local jogador = GetWorldEntitiesByTag(EntityTags.JOGADOR)[1]
    local x, y = self.interior:getPositionStart()
    jogador:moverPara(x, y)
    InactivateEntities({EntityTags.TAMAGOCHI, EntityTags.CASA, EntityTags.LOJA})
    if self.tamagotchi then
        self.tamagotchi.physics.body:setActive(true)
    end
    jogadorDentroDaCasa = true
end

function Casa:Sair()
    self.interior:destruir()
    ActivateEntities({EntityTags.TAMAGOCHI, EntityTags.CASA, EntityTags.LOJA})
    jogadorDentroDaCasa = false
end

function Casa:criarTamagotchi()
    local casaX, casaY = self.physics:getPositionRounded()
    self.tamagotchi = Tamagochi(casaX, casaY - 20)
    
end

function Casa:moverTamagotchiPara(x, y)
    if self.tamagotchi then
        self.tamagotchi:moverPara(x, y)
    end
end

function Casa:destruir()
    if not self.tamagotchi == nil then
        self.tamagotchi:destruir()
    end
    self.toBeDestroyed = true
end

return Casa