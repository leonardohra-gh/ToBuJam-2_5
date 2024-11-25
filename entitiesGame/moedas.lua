
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local Moedas = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")

local imagePath = "assets/moedas.png"

function Moedas:new(x, y)
    local imagePath = "assets/moedas.png"
    local atravessavel, size, drawPriority = nil, nil, PrioridadeDesenho.MOEDAS
    Moedas.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.STATIC, EntityTags.MOEDAS, atravessavel, size, drawPriority)
end

function Moedas:update(dt)
    Moedas.super.update(self, dt)
end

function Moedas:draw()
    Moedas.super.draw(self)
end

function Moedas:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        local jogador = GetWorldEntitiesByTag(EntityTags.JOGADOR)[1]
        jogador.mochila:AddDinheiro(100)
        self:destruir()
    end
end

function Moedas:destruir()
    self.toBeDestroyed = true
end

function Moedas:GetImagem()
    return love.graphics.newImage(imagePath)
end

return Moedas