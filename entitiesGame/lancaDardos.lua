
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local VisaoLancaDardos = require("entitiesGame.visaoLancaDardos")
local PrioridadeDesenho= require("enumsGame.PrioridadeDesenho")
local LancaDardos = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")

function LancaDardos:new(x, y, sensorDistance)
    local imagePath = "assets/lancaDardos.png"
    local atravessavel, size, drawPriority = false, nil, PrioridadeDesenho.LANCA_DARDOS
    LancaDardos.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.STATIC, EntityTags.LANCA_DARDOS, atravessavel, size, drawPriority)
    self.visao = VisaoLancaDardos(x, y, self.drawer:getHeight(), sensorDistance)
end

function LancaDardos:update(dt)
    LancaDardos.super.update(self, dt)
end

function LancaDardos:draw()
    LancaDardos.super.draw(self)
end

-- function MyEntity:beginContact(entidade_colisora, coll)
-- end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

-- function MyEntity:preSolve(entidade_colisora, b, coll)
-- end

-- function MyEntity:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
-- end

function LancaDardos:destruir()
    self.toBeDestroyed = true
    self.visao:destruir()
end

return LancaDardos