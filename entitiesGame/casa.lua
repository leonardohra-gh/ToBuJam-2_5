local Entity = require('core.entity')
local PrioridadeDesenho = require('enumsGame.PrioridadeDesenho')
local Casa = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")
local EntityTags = require("enumsGame.EntityTags")
local Tamagochi = require("entitiesGame.tamagochi")
local InteriorCasa = require("entitiesGame.interiorCasa")

local keyboard_E = love.graphics.newImage("assets/keyboard_E.png")

function Casa:new(x, y)
    math.randomseed(os.time() + math.random())
    local corCasa = math.random(5)
    local imagePath = "assets/casa_" .. corCasa .. ".png"
    local atravessavel, size, drawPriority = nil, nil, PrioridadeDesenho.CASA
    atravessavel = false
    Casa.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.CASA, atravessavel, size, drawPriority)
    self.tamagotchi = nil
    self.interior = nil
    self.jogadorPodeEntrar = false
end

function Casa:update(dt)
    Casa.super.update(self, dt)
    if self.jogadorPodeEntrar and love.keyboard.isDown("e") then
        self:Entrar()
    end
end

function Casa:draw()
    if not self.physics.body:isActive() then
        return
    end

    Casa.super.draw(self)
    if not (self.tamagotchi == nil) and not self.tamagotchi.satisfeito then
        self.tamagotchi:desenharNecessidades()
        self.tamagotchi:draw()
    end
    
    if self.jogadorPodeEntrar then
        local x, y = self.physics:getPositionRounded()
        love.graphics.draw(keyboard_E, x + 10, y - 50)
    end
end

function Casa:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        self.jogadorPodeEntrar = true
    end
end

function Casa:endContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        self.jogadorPodeEntrar = false
    end
end

function Casa:Entrar()
    if not jogadorDentroDaCasa then
        self.interior = InteriorCasa(6, self)
        self.jogadorPodeEntrar = false
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