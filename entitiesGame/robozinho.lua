
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local ConeVisao = require("entitiesGame.coneVisao")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local Robozinho = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
local Size = require("core.structures.size")

local rotCounter = 0
local VEL_MAX = 200
function Robozinho:new(x, y)
    local imagePath = "assets/robozinho.png"
    local atravessavel, size, drawPriority = false, Size(48, 48), PrioridadeDesenho.ROBOZINHO
    Robozinho.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.DYNAMIC, EntityTags.ROBOZINHO, atravessavel, size, drawPriority)
    
    self.angleMovement = 0
    self.initialPos = {x = x, y = y}
    self.vel = {x = 200, y = 0}
    self.maxDistToStart = {x = 2000, y = 500}
    self.coneVisao = ConeVisao(x + self.physics.width, y)
end

function Robozinho:update(dt)
    self:mover()
    local x, y = self.physics:getPositionRounded()
    if self.coneVisao then
        self.coneVisao:moverPara(x + self.physics.width, y)
    end
    Robozinho.super.update(self, dt)
end

function Robozinho:draw()
    Robozinho.super.draw(self, self.angleMovement)
    love.graphics.print("" .. rotCounter, self.x, self.y)
end

function Robozinho:mover()
    if self.maxDistToStart.x <= self:distToStart().x then
        self.vel.x = -self.vel.x
    end

    if self.maxDistToStart.y <= self:distToStart().y then
        self.vel.y = -self.vel.y
    end

    self.physics:setVelocity(self.vel.x, self.vel.y)
    -- if not self.coneVisao == nil then
    --     self.coneVisao.physics:setVelocity(self.vel.x, self.vel.y)
    -- end
end

function Robozinho:distToStart()
    local posX, posY = self.physics:getPositionRounded()
    return {x = CalcDist(posX, self.initialPos.x), y = CalcDist(posY, self.initialPos.y)}
end

function CalcDist(x1, x2)
    return math.abs(x2 - x1)
end

function Robozinho:rotacionar90()
    self.angleMovement = self.angleMovement + math.pi / 2
    self.vel.x = VEL_MAX * math.cos(self.angleMovement)
    self.vel.y = VEL_MAX * math.sin(self.angleMovement)

end

function Robozinho:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        finalizarJogo()
    elseif not (entidade_colisora.tag == EntityTags.CHAO) then
        self:rotacionar90()
        rotCounter = rotCounter + 1
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