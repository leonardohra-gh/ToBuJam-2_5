
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local ChaoCraquelado = Entity:extend()

function ChaoCraquelado:new(x, y)
    local imagePath = "assets/chao_craquelado.png"
    local atravessavel = true
    ChaoCraquelado.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.DYNAMIC, "chaoCraquelado", atravessavel)
end

function ChaoCraquelado:update(dt)
    ChaoCraquelado.super.update(self, dt)
end

function ChaoCraquelado:draw()
    ChaoCraquelado.super.draw(self)
end

function ChaoCraquelado:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == "jogador" then
        finalizarJogo()
    end
end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

-- function MyEntity:preSolve(entidade_colisora, b, coll)
-- end

-- function MyEntity:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
-- end

return ChaoCraquelado