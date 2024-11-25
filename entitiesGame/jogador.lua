local Entity = require('core.entity')
local PrioridadeDesenho = require('enumsGame.PrioridadeDesenho')
local Size              = require('core.structures.size')
local Jogador = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")
local EntityTags = require("enumsGame.EntityTags")
local Mochila = require('entitiesGame.mochila')

local TAMAGOTCHI_VIDAS = 5
local IMAGE_TAMAGOTCHI_VIDA = love.graphics.newImage("assets/tamagotchiVida.png")
local IMAGE_LIFE_BAR = love.graphics.newImage("assets/life_bar.png")
local vidasX, vidasY = 1170 - 16 / 2, 95
local MAX_SPEED = 300
local SPEED_INC = 50

function Jogador:new(x, y)
    local imagePath = "assets/jogador.png"
    local atravessavel, size, drawPiority = nil, Size(48, 60), PrioridadeDesenho.JOGADOR
    Jogador.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.DYNAMIC, EntityTags.JOGADOR, atravessavel, size, drawPiority)
    self.speed = 150
    self.mochila = Mochila()
    self.pontuacao = 0
    self.movementDisabled = false
    self.tamagotchometro = TAMAGOTCHI_VIDAS
end

function Jogador:mover()
    local velocityX, velocityY = 0, 0
    
    if love.keyboard.isDown("right") then
        velocityX = self.speed
    end
    if love.keyboard.isDown("left") then
        velocityX = - self.speed
    end
    if love.keyboard.isDown("up") then
        velocityY = - self.speed
    end
    if love.keyboard.isDown("down") then
        velocityY = self.speed
    end
    
    self.physics:setVelocity(velocityX, velocityY)
end

function Jogador:moverPara(x, y)
    self.physics:moveTo(x, y)
end

function Jogador:update(dt)
    if not self.movementDisabled then
        self:mover()
    end
    Jogador.super.update(self, dt)
end

function Jogador:draw()
    Jogador.super.draw(self)
    self.mochila:draw()
    love.graphics.print("Pontuação: " .. self.pontuacao, 1250, 285)
    love.graphics.draw(IMAGE_LIFE_BAR, vidasX + 25, vidasY)
    for i = 1, self.tamagotchometro do
        love.graphics.draw(IMAGE_TAMAGOTCHI_VIDA, vidasX + 30 * i, vidasY)
    end
end

function Jogador:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.CHAO_ESCORREGADIO then
        self.movementDisabled = true
        local velocityX, velocityY = self.physics:getVelocity()
        self.physics:setVelocity(2*velocityX, 2*velocityY)
    elseif entidade_colisora.tag == EntityTags.PAREDE then
        self.movementDisabled = false
    end
end

function Jogador:endContact(entidade_colisora, b, coll)
end

function Jogador:preSolve(entidade_colisora, b, coll)
end

function Jogador:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
end

function Jogador:AddPontuacao(quantidade)
    self.pontuacao = self.pontuacao + quantidade
end

function Jogador:AddVelocidade()
    if self:PodeAumentarVelocidade()then
        self.speed = self.speed + SPEED_INC
    end
end

function Jogador:PodeAumentarVelocidade()
    return self.speed + SPEED_INC <= MAX_SPEED
end

function Jogador:AumentarTamagotchiVidas()
    if self.tamagotchometro + 1 <= TAMAGOTCHI_VIDAS then
        self.tamagotchometro = self.tamagotchometro + 1
    end
end

function Jogador:DiminuirTamagotchiVidas()
    self.tamagotchometro = self.tamagotchometro - 1
    if self.tamagotchometro <= 0 then
        finalizarJogo()
    end
end

function Jogador:destruir()
    self.mochila:destruir()
    self.toBeDestroyed = true
end

return Jogador