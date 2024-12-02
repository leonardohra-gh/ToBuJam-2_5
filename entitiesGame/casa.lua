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
        self.tamagotchi:draw()
    end    
end

function Casa:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        self.gerarLayout = true
    end
end

function Casa:Entrar()
    if not jogadorDentroDaCasa then
        self.interior = InteriorCasa(6, self)
        self.gerarLayout = false
        local jogador = GetWorldEntitiesByTag(EntityTags.JOGADOR)[1]
        jogador:savePosAoEntrarNaCasa()
    
        local x, y = self.interior:getPositionStart()
        jogador:moverPara(x, y)
        InactivateEntities({EntityTags.TAMAGOCHI, EntityTags.CASA, EntityTags.LOJA})
        if self.tamagotchi then
            self.tamagotchi.physics.body:setActive(true)
        end
        jogadorDentroDaCasa = true
    end
end

function Casa:Sair()
    if jogadorDentroDaCasa then
        self.interior:destruir()
        ActivateEntities({EntityTags.TAMAGOCHI, EntityTags.CASA, EntityTags.LOJA})
        local jogador = GetWorldEntitiesByTag(EntityTags.JOGADOR)[1]
        local pos = jogador:getPosAoEntrarNaCasa()
        jogador:moverPara(pos.x, pos.y)
        jogadorDentroDaCasa = false
    end
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
    if not (self.tamagotchi == nil) then
        self.tamagotchi:destruir()
    end
    if not (self.interior == nil) then
        self.interior:destruir()
    end
    self.toBeDestroyed = true
end

return Casa