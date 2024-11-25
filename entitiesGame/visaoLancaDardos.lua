
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local VisaoLancaDardos = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
local Size = require("core.structures.size")
local Tiro = require("entitiesGame.tiro")

function VisaoLancaDardos:new(x, y, height, width)
    local imagePath = "assets/lancaDardos.png"
    local atravessavel = true
    local size = Size(width, height)
    local xReposicionado = x + width/2
    local drawPriority = PrioridadeDesenho.VISAO_LANCA_DARDOS
    VisaoLancaDardos.super.new(self,
                                    xReposicionado,
                                    y,
                                    imagePath,
                                    World,
                                    ShapeTypes.RECTANGLE,
                                    BodyTypes.STATIC,
                                    EntityTags.VISAO_LANCA_DARDOS,
                                    atravessavel,
                                    size,
                                    drawPriority
                                )
    self.shootingCooldown = 0.5
    self.cooldownTimer = 0
    self.shootingVelocityX, self.shootingVelocityY = 800, 0
    self.shouldShoot = false
end

function VisaoLancaDardos:update(dt)
    if self.shouldShoot and self.cooldownTimer <= 0 then
        local x, y = self.physics:getPositionRounded()
        local width, height = self.physics:getSize()
        local tiro = Tiro(x - width/2, y, self.shootingVelocityX, self.shootingVelocityY)
        self.cooldownTimer = self.shootingCooldown
    end

    if self.cooldownTimer > 0 then
        self.cooldownTimer = self.cooldownTimer - dt
        if self.cooldownTimer < 0 then
            self.cooldownTimer = 0
        end
    end
    VisaoLancaDardos.super.update(self, dt)

    -- local velocityX, velocityY = 0, 0

    -- if love.keyboard.isDown("right") then
    --     velocityX = self.speed
    -- end
    -- if love.keyboard.isDown("left") then
    --     velocityX = - self.speed
    -- end
    -- if love.keyboard.isDown("up") then
    --     velocityY = - self.speed
    -- end
    -- if love.keyboard.isDown("down") then
    --     velocityY = self.speed
    -- end

    -- self.physics:setVelocity(velocityX, velocityY)
end

function VisaoLancaDardos:draw()
    --VisaoLancaDardos.super.draw(self)
end

function VisaoLancaDardos:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR and self.cooldownTimer == 0 then
        self.shouldShoot = true
    end
end

function VisaoLancaDardos:endContact(entidade_colisora, b, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        self.shouldShoot = false
    end
end

-- function MyEntity:preSolve(entidade_colisora, b, coll)
-- end

-- function MyEntity:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
-- end

function VisaoLancaDardos:destruir()
    self.toBeDestroyed = true
end

return VisaoLancaDardos