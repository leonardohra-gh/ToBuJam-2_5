
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local ConeVisao = require("entitiesGame.coneVisao")
local Robozinho = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
local Size = require("core.structures.size")

function Robozinho:new(x, y, automaticDraw)
    local imagePath = "assets/robozinho.png"
    local atravessavel = false
    local size = Size(48, 48)
    Robozinho.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.DYNAMIC, EntityTags.ROBOZINHO, atravessavel, automaticDraw, size)
    self.direcaoInicial = "x"
    self.initialPos = {x = x, y = y}
    self.vel = {x = 20, y = 0}
    self.maxDistToStart = {x = 200, y = 50}
    self.coneVisao = ConeVisao(x + self.physics.width, y)
    self.jaRotacionou = false
    self.passosNaDirecaoRotacionada = 0
end

function Robozinho:update(dt)
    self:mover()
    Robozinho.super.update(self, dt)
end

function Robozinho:draw()
    Robozinho.super.draw(self)
end

function Robozinho:mover()
    local posX, posY = self.physics:getPositionRounded()
    if self.maxDistToStart.x <= CalcDist(posX, self.initialPos.x) then
        self.vel.x = -self.vel.x
    end

    if self.maxDistToStart.y <= CalcDist(posY, self.initialPos.y) then
        self.vel.y = -self.vel.y
    end

    if self.jaRotacionou then
        self.passosNaDirecaoRotacionada = self.passosNaDirecaoRotacionada + 1
        if self.direcaoInicial == "x" and 5 <= self.passosNaDirecaoRotacionada and CalcDist(posY, self.initialPos.y) == 0 then
            self:rotacionar()
            self.vel.x = -self.vel.x
        end
        if self.direcaoInicial == "y" and 5 <= self.passosNaDirecaoRotacionada and CalcDist(posX, self.initialPos.x) == 0 then
            self:rotacionar()
            self.vel.y = -self.vel.y
        end
    end

    self.physics:setVelocity(self.vel.x, self.vel.y)
    self.coneVisao.physics:setVelocity(self.vel.x, self.vel.y)
end

function CalcDist(x1, x2)
    return math.abs(x2 - x1)
end

function Robozinho:rotacionar()
    local velTemp = self.vel.x
    self.vel.x = self.vel.y
    self.vel.y = velTemp
    self.jaRotacionou = true

end

function Robozinho:beginContact(entidade_colisora, coll)
    local normal, tangente = coll:getNormal()
    if entidade_colisora.tag == EntityTags.PAREDE then --  and normal == -1
        self:rotacionar()
    end
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

function Robozinho:destruir()
    self.coneVisao:destruir()
    self.toBeDestroyed = true
end

return Robozinho