
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local ChaoCraquelado = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
local Size = require("core.structures.size")

function ChaoCraquelado:new(x, y)
    local imagePath = "assets/chao_craquelado.png"
    local atravessavel, size, drawPriority = true,  Size(32, 32), PrioridadeDesenho.CHAO_CRAQUELADO
    ChaoCraquelado.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.DYNAMIC, EntityTags.CHAO_CRAQUELADO, atravessavel, size, drawPriority)
end

function ChaoCraquelado:update(dt)
    ChaoCraquelado.super.update(self, dt)
end

function ChaoCraquelado:draw()
    ChaoCraquelado.super.draw(self)
end

function ChaoCraquelado:beginContact(entidade_colisora, coll)
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

function ChaoCraquelado:destruir()
    self.toBeDestroyed = true
end

return ChaoCraquelado