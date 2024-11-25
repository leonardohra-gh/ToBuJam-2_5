
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local Size              = require("core.structures.size")
local SaidaCasa = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")

function SaidaCasa:new(x, y, casaOwner)
    local imagePath = "assets/chao.png"
    local atravessavel, size, drawPriority = true, Size(32, 32), PrioridadeDesenho.CHAO
    SaidaCasa.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.SAIDA_CASA, atravessavel, size, drawPriority )
    self.casaOwner = casaOwner
end

function SaidaCasa:update(dt)
    SaidaCasa.super.update(self, dt)
    if self.deveSair then
        self.casaOwner:Sair()
    end
end

function SaidaCasa:draw()
    SaidaCasa.super.draw(self)
end

function SaidaCasa:destruir()
    self.toBeDestroyed = true
end

function SaidaCasa:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        self.deveSair = true
    end
end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

-- function MyEntity:preSolve(entidade_colisora, b, coll)
-- end

-- function MyEntity:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
-- end

return SaidaCasa