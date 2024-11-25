
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local ConeVisao = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")

function ConeVisao:new(x, y)
    local imagePath = "assets/coneVisao.png"
    
    local atravessavel, size, drawPriority = true, nil, PrioridadeDesenho.CONE_VISAO
    ConeVisao.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.DYNAMIC, EntityTags.CONE_VISAO, atravessavel, size, drawPriority)
end

function ConeVisao:update(dt)
    ConeVisao.super.update(self, dt)
end

function ConeVisao:draw()
    ConeVisao.super.draw(self)
end

function ConeVisao:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        finalizarJogo()
    end
end

function ConeVisao:destruir()
    self.toBeDestroyed = true
end

return ConeVisao