
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local ConeVisao = require("entitiesGame.coneVisao")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local Robozinho = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
local Size = require("core.structures.size")

local VEL_MAX = 200
local HEARING_DISTANCE = 400
local MAX_DIST_TO_TARGET = 32 / 2 + 32 / 2

function Robozinho:new(x, y)
    local imagePath = "assets/robozinho.png"
    local atravessavel, size, drawPriority = false, Size(48, 48), PrioridadeDesenho.ROBOZINHO
    Robozinho.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.DYNAMIC, EntityTags.ROBOZINHO, atravessavel, size, drawPriority)
    
    self.angleMovement = 0
    self.initialPos = {x = x, y = y}
    self.vel = {x = 200, y = 0}
    -- self.maxDistToStart = {x = 2000, y = 500}
    self.coneVisao = ConeVisao(x + self.physics.width, y)
    self.atento = false
    self.targetPoint = nil
end

function Robozinho:update(dt)
    
    if not (self.targetPoint == nil) then
        self:escolherDirecao()
    end
    self:mover()

    local x, y = self.physics:getPositionRounded()
    if not (self.coneVisao == nil) then
        self.coneVisao:moverPara(x + self.physics.width, y)
    end

    self:checarBarulho()

    Robozinho.super.update(self, dt)
end

function Robozinho:draw()
    Robozinho.super.draw(self, self.angleMovement)
    
    if self.atento then
        love.graphics.setFont(LARGE_FONT)
        local x, y = self.physics:getPositionRounded()
        love.graphics.print("!", x, y - 10)
        love.graphics.setFont(MAIN_FONT)
    end
end

function Robozinho:escolherDirecao()
    local posX, posY = self.physics:getPositionRounded()
    if self.targetPoint.x + MAX_DIST_TO_TARGET <= posX then
        self.vel.x = -math.abs(self.vel.x)
    elseif posX + MAX_DIST_TO_TARGET <= self.targetPoint.x then
        self.vel.x = math.abs(self.vel.x)
    end
    
    if self.targetPoint.y + MAX_DIST_TO_TARGET < posY then
        self.vel.y = -math.abs(self.vel.y)
    elseif posY + MAX_DIST_TO_TARGET <= self.targetPoint.y then
        self.vel.y = math.abs(self.vel.y)
    end

    if self:estaAoLadoDoAlvo() and self.vel.x == 0 then
        self:rotacionar90()
    end

    if self:estaAbaixoOuAcimaDoAlvo() and self.vel.y == 0 then
        self:rotacionar90()
    end
end

function Robozinho:estaAbaixoOuAcimaDoAlvo()
    local posX, posY = self.physics:getPositionRounded()
    return CalcDist(self.targetPoint.x, posX) <= MAX_DIST_TO_TARGET
end

function Robozinho:estaAoLadoDoAlvo()
    local posX, posY = self.physics:getPositionRounded()
    return CalcDist(self.targetPoint.y, posY) <= MAX_DIST_TO_TARGET
end

function Robozinho:mover()

    -- if self.maxDistToStart.x <= self:distToStart().x then
    --     self.vel.x = -self.vel.x
    -- end

    -- if self.maxDistToStart.y <= self:distToStart().y then
    --     self.vel.y = -self.vel.y
    -- end

    self.physics:setVelocity(self.vel.x, self.vel.y)
    -- if not self.coneVisao == nil then
    --     self.coneVisao.physics:setVelocity(self.vel.x, self.vel.y)
    -- end
end

function Robozinho:distToStart()
    local posX, posY = self.physics:getPositionRounded()
    return {x = CalcDist(posX, self.initialPos.x), y = CalcDist(posY, self.initialPos.y)}
end

function Robozinho:distToPoint(pos)
    local posX, posY = self.physics:getPositionRounded()
    return math.sqrt(math.pow(CalcDist(posX, pos.x), 2) + math.pow(CalcDist(posY, pos.y), 2))
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
    elseif entidade_colisora.tag == EntityTags.PAREDE or entidade_colisora.tag == EntityTags.PATINHO_BORRACHA or entidade_colisora.tag == EntityTags.LANCA_DARDOS or entidade_colisora.tag == EntityTags.CHAO_ESCORREGADIO then
        self:rotacionar90()
    end
end

function Robozinho:checarBarulho()
    
    self.atento = false
    self.targetPoint = nil

    local todosChaoBarulhento = GetWorldEntitiesByTag(EntityTags.CHAO_BARULHENTO)
    for i, chaoBarulhento in pairs(todosChaoBarulhento) do
        if chaoBarulhento.ativo then
            local chaoPosX, chaoPosY = chaoBarulhento.physics:getPositionRounded()
            local distToChao = self:distToPoint({x = chaoPosX, y = chaoPosY})
            if distToChao <= HEARING_DISTANCE then
                self.atento = true
                self.targetPoint = {x = chaoPosX, y = chaoPosY}
            end
        end
    end
end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

function Robozinho:destruir()
    self.coneVisao:destruir()
    self.toBeDestroyed = true
end

return Robozinho