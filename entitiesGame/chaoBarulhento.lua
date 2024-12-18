
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local ChaoBarulhento = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local Size = require("core.structures.size")

local MAX_TEMPO_ATIVO = 10

function ChaoBarulhento:new(x, y)
    local imagePath = "assets/chaoBarulhento.png"
    ChaoBarulhento.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.DYNAMIC, EntityTags.CHAO_BARULHENTO, true, Size(32, 32), PrioridadeDesenho.CHAO_BARULHENTO)
    self.ativo = false
    self.contadorAtivacao = 0
end

function ChaoBarulhento:update(dt)
    ChaoBarulhento.super.update(self, dt)
    if self.ativo then
        self.contadorAtivacao = self.contadorAtivacao + dt
    end

    if MAX_TEMPO_ATIVO <= self.contadorAtivacao then
        self:desativar()
    end
end

function ChaoBarulhento:draw()
    ChaoBarulhento.super.draw(self)

    if self.ativo then
        love.graphics.setFont(LARGE_FONT)
        local x, y = self.physics:getPositionRounded()
        love.graphics.print("!", x, y)
        love.graphics.setFont(MAIN_FONT)
    end
end

function ChaoBarulhento:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        self:ativar()
    end

    if entidade_colisora.tag == EntityTags.ROBOZINHO then
        self:desativar()
    end
end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

function ChaoBarulhento:ativar()
    self.contadorAtivacao = 0
    self.ativo = true
end

function ChaoBarulhento:desativar()
    self.contadorAtivacao = 0
    self.ativo = false
end

function ChaoBarulhento:destruir()
    self.toBeDestroyed = true
end

return ChaoBarulhento