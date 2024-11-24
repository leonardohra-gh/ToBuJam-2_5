
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local Tamagotchi = Entity:extend()
local NECESSIDADE = require("core.enums.necessidades")
local EntityTags = require("enumsGame.EntityTags")

function Tamagotchi:new(x, y)
    local imagePath = "assets/tamagotchi.png"
    Tamagotchi.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.DYNAMIC, EntityTags.TAMAGOCHI, true)

    self.estaVivo = true
    self.necessidadesValorInicial = {
        AGUA = 10,
        BANHO = 20,
        BRINCAR = 5,
        COMER = 10,
        DORMIR = 10
    }
    self.necessidades = {
        AGUA = (0.8 + 0.2 * math.random()) * self.necessidadesValorInicial.AGUA,
        BANHO = (0.8 + 0.2 * math.random()) * self.necessidadesValorInicial.BANHO,
        BRINCAR = (0.8 + 0.2 * math.random()) * self.necessidadesValorInicial.BRINCAR,
        COMER = (0.8 + 0.2 * math.random()) * self.necessidadesValorInicial.COMER,
        DORMIR = (0.8 + 0.2 * math.random()) * self.necessidadesValorInicial.DORMIR
    }
end

function Tamagotchi:update(dt)
    
    if self.estaVivo then
        self.necessidades.AGUA = self.necessidades.AGUA - dt
        self.necessidades.BANHO = self.necessidades.BANHO - dt
        self.necessidades.BRINCAR = self.necessidades.BRINCAR - dt
        self.necessidades.COMER = self.necessidades.COMER - dt
        self.necessidades.DORMIR = self.necessidades.DORMIR - dt
        self.estaVivo = self:checarVida()
    else
        self.toBeDestroyed = true
        local jogador = GetWorldEntitiesByTag(EntityTags.JOGADOR)[1]
        if not (jogador == nil) then
            jogador:DiminuirTamagotchiVidas()
        end
    end
    Tamagotchi.super.update(self, dt)
end

function Tamagotchi:draw()

    -- if self.estaVivo then
    --     Tamagotchi.super.draw(self)
    -- end

    -- self:desenharNecessidades()

end

function Tamagotchi:desenharNecessidades()
    if self.estaVivo then
        Tamagotchi.super.draw(self)
        local x, y = self.physics:getPositionRounded()
        self:desenharBarraNecessidade(x - 20, y - 40, self.necessidades.AGUA, self.necessidadesValorInicial.AGUA)
    end
end

function Tamagotchi:desenharBarraNecessidade(x, y, valor, max)
    local width, height = 50, 5
    love.graphics.setColor(0, 0, 1, 1)
    love.graphics.rectangle("fill", x, y, width * valor / max, height)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("line", x, y, width, height)
    love.graphics.setColor(1, 1, 1, 1)
end

function Tamagotchi:checarVida()
    if self.necessidades.AGUA <= 0 then
        return false
    end
    if self.necessidades.BANHO <= 0 then
        return false
    end
    if self.necessidades.BRINCAR <= 0 then
        return false
    end
    if self.necessidades.COMER <= 0 then
        return false
    end
    if self.necessidades.DORMIR <= 0 then
        return false
    end

    return true
end

function Tamagotchi:atenderNecessidade(necessidade)
    
    if necessidade == NECESSIDADE.AGUA then
        self.necessidades.AGUA = self.necessidadesValorInicial.AGUA
    end
    if necessidade == NECESSIDADE.BANHO then
        self.necessidades.BANHO = self.necessidadesValorInicial.BANHO
    end
    if necessidade == NECESSIDADE.BRINCAR then
        self.necessidades.BRINCAR = self.necessidadesValorInicial.BRINCAR
    end
    if necessidade == NECESSIDADE.COMIDA then
        self.necessidades.COMER = self.necessidadesValorInicial.COMER
    end
    if necessidade == NECESSIDADE.DORMIR then
        self.necessidades.DORMIR = self.necessidadesValorInicial.DORMIR
    end
end

function Tamagotchi:printarNecessidades()
    love.graphics.print("Água: " .. self.necessidades.AGUA, 10, 30)
    love.graphics.print("Banho: " .. self.necessidades.BANHO, 10, 40)
    love.graphics.print("Brincar: " .. self.necessidades.BRINCAR, 10, 50)
    love.graphics.print("Comer: " .. self.necessidades.COMER, 10, 60)
    love.graphics.print("Dormir: " .. self.necessidades.DORMIR, 10, 70)
end

-- function MyEntity:beginContact(entidade_colisora, coll)
-- end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

-- function MyEntity:preSolve(entidade_colisora, b, coll)
-- end

-- function MyEntity:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
-- end

return Tamagotchi