
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local PatinhoBorracha = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
local Size = require("core.structures.size")

function PatinhoBorracha:new(x, y)
    local imagePath = "assets/patinho_borracha.png"
    local atravessavel, size, drawPriority = true,  Size(32, 32), PrioridadeDesenho.PATINHO_BORRACHA
    PatinhoBorracha.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.DYNAMIC, EntityTags.PATINHO_BORRACHA, atravessavel, size, drawPriority)
end

function PatinhoBorracha:update(dt)
    PatinhoBorracha.super.update(self, dt)
end

function PatinhoBorracha:draw()
    PatinhoBorracha.super.draw(self)
end

function PatinhoBorracha:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        finalizarJogo()
    end
end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

-- function MyEntity:preSolve(entidade_colisora, b, coll)
-- end

-- function MyEntity:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
-- end

function PatinhoBorracha:destruir()
    self.toBeDestroyed = true
end

return PatinhoBorracha