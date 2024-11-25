
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local NECESSIDADE = require("core.enums.necessidades")
local Entity = require("core.entity")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local Tamagotchi = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
-- local BotaoPadrao = require("entitiesGame.botaoPadrao")
local Drawer = require("core.drawer")
local InterfaceTamagotchi = require("entitiesGame.interfaceTamagotchi")


local imagePath = "assets/tamagotchi.png"
local imageNecessidadeAgua = "assets/notification_drink.png"
local imageNecessidadeBanho = "assets/notification_shower.png"
local imageNecessidadeBrincar = "assets/notification_fun.png"
local imageNecessidadeComida = "assets/notification_feed.png"
local imageNecessidadeDormir = "assets/notification_sleep.png"

function Tamagotchi:new(x, y)
    local atravessavel, size, drawPriority = true, nil, PrioridadeDesenho.TAMAGOCHI
    Tamagotchi.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.DYNAMIC, EntityTags.TAMAGOCHI, atravessavel, size, drawPriority)

    self.estaVivo = true
    self.necessidadesValorInicial = {
        AGUA_INICIAL = 10,
        BANHO_INICIAL = 20,
        BRINCAR_INICIAL = 5,
        COMIDA_INICIAL = 10,
        DORMIR_INICIAL = 10
    }
    self.necessidades = {
        AGUA = (0.8 + 0.2 * math.random()) * self.necessidadesValorInicial.AGUA_INICIAL,
        BANHO = (0.8 + 0.2 * math.random()) * self.necessidadesValorInicial.BANHO_INICIAL,
        BRINCAR = (0.8 + 0.2 * math.random()) * self.necessidadesValorInicial.BRINCAR_INICIAL,
        COMIDA = (0.8 + 0.2 * math.random()) * self.necessidadesValorInicial.COMIDA_INICIAL,
        DORMIR = (0.8 + 0.2 * math.random()) * self.necessidadesValorInicial.DORMIR_INICIAL
    }
    self.necessidadeAtual = NECESSIDADE:aleatoria()
    local botoesX, botoesY = self.physics:getPositionRounded()
    self.interface = InterfaceTamagotchi(botoesX, botoesY - 100)
    self:updateImagem()
    -- self.botoes = {
    --     DARAGUA = BotaoPadrao(botoesX, botoesY - 20, "", self.darAgua),
        
    -- }
    -- for i, botao in pairs(self.botoes) do
    --     botao:desativar()
    -- end
end

function Tamagotchi:update(dt)
    
    if self.estaVivo then
        self:aumentarNecessidade(dt)
        self.estaVivo = self:checarVida()
    else
        self:destruir()
        local jogador = GetWorldEntitiesByTag(EntityTags.JOGADOR)[1]
        if not (jogador == nil) then
            jogador:DiminuirTamagotchiVidas()
        end
    end
    Tamagotchi.super.update(self, dt)
end

function Tamagotchi:draw()

    if self.estaVivo then
        Tamagotchi.super.draw(self)
        self.interface:draw()
    end

end

function Tamagotchi:updateImagem()
    if self.necessidadeAtual == NECESSIDADE.AGUA then
        self.drawer = Drawer(imageNecessidadeAgua)
    end
    if self.necessidadeAtual == NECESSIDADE.BANHO then
        self.drawer = Drawer(imageNecessidadeBanho)
    end
    if self.necessidadeAtual == NECESSIDADE.BRINCAR then
        self.drawer = Drawer(imageNecessidadeBrincar)
    end
    if self.necessidadeAtual == NECESSIDADE.COMIDA then
        self.drawer = Drawer(imageNecessidadeComida)
    end
    if self.necessidadeAtual == NECESSIDADE.DORMIR then
        self.drawer = Drawer(imageNecessidadeDormir)
    end
end

function Tamagotchi:aumentarNecessidade(qtd)
    if self.necessidadeAtual == NECESSIDADE.AGUA then
        self.necessidades.AGUA = self.necessidades.AGUA - qtd
    end
    if self.necessidadeAtual == NECESSIDADE.BANHO then
        self.necessidades.BANHO = self.necessidades.BANHO - qtd
    end
    if self.necessidadeAtual == NECESSIDADE.BRINCAR then
        self.necessidades.BRINCAR = self.necessidades.BRINCAR - qtd
    end
    if self.necessidadeAtual == NECESSIDADE.COMIDA then
        self.necessidades.COMIDA = self.necessidades.COMIDA - qtd
    end
    if self.necessidadeAtual == NECESSIDADE.DORMIR then
        self.necessidades.DORMIR = self.necessidades.DORMIR - qtd
    end
end

function Tamagotchi:desenharNecessidades()
    if self.estaVivo then
        Tamagotchi.super.draw(self)
        local x, y = self.physics:getPositionRounded()
        local barX, barY = x - 50 / 2, y - 50
        if self.necessidadeAtual == NECESSIDADE.AGUA then
            self:desenharBarraNecessidade(barX, barY, self.necessidades.AGUA, self.necessidadesValorInicial.AGUA_INICIAL)
        end
        if self.necessidadeAtual == NECESSIDADE.BANHO then
            self:desenharBarraNecessidade(barX, barY, self.necessidades.BANHO, self.necessidadesValorInicial.BANHO_INICIAL)
        end
        if self.necessidadeAtual == NECESSIDADE.BRINCAR then
            self:desenharBarraNecessidade(barX, barY, self.necessidades.BRINCAR, self.necessidadesValorInicial.BRINCAR_INICIAL)
        end
        if self.necessidadeAtual == NECESSIDADE.COMIDA then
            self:desenharBarraNecessidade(barX, barY, self.necessidades.COMIDA, self.necessidadesValorInicial.COMIDA_INICIAL)
        end
        if self.necessidadeAtual == NECESSIDADE.DORMIR then
            self:desenharBarraNecessidade(barX, barY, self.necessidades.DORMIR, self.necessidadesValorInicial.DORMIR_INICIAL)
        end
    end
end

function Tamagotchi:desenharBarraNecessidade(x, y, valor, max)
    local perc = valor / max
    local width, height = 50, 15
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("fill", x, y, width, height)
    love.graphics.setColor(1 - perc, perc, 0, 1)
    love.graphics.rectangle("fill", x, y, width * valor / max, height)
    love.graphics.setColor(0, 0.1, 0, 1)
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
    if self.necessidades.COMIDA <= 0 then
        return false
    end
    if self.necessidades.DORMIR <= 0 then
        return false
    end

    return true
end

function Tamagotchi:atenderNecessidade(necessidade)
    
    if necessidade == NECESSIDADE.AGUA then
        self.necessidades.AGUA = self.necessidadesValorInicial.AGUA_INICIAL
    end
    if necessidade == NECESSIDADE.BANHO then
        self.necessidades.BANHO = self.necessidadesValorInicial.BANHO_INICIAL
    end
    if necessidade == NECESSIDADE.BRINCAR then
        self.necessidades.BRINCAR = self.necessidadesValorInicial.BRINCAR_INICIAL
    end
    if necessidade == NECESSIDADE.COMIDA then
        self.necessidades.COMIDA = self.necessidadesValorInicial.COMIDA_INICIAL
    end
    if necessidade == NECESSIDADE.DORMIR then
        self.necessidades.DORMIR = self.necessidadesValorInicial.DORMIR_INICIAL
    end

    self.necessidadeAtual = NECESSIDADE:aleatoria()
    self:updateImagem()
end

function Tamagotchi:printarNecessidades()
    love.graphics.print("Água: " .. self.necessidades.AGUA, 10, 30)
    love.graphics.print("Banho: " .. self.necessidades.BANHO, 10, 40)
    love.graphics.print("Brincar: " .. self.necessidades.BRINCAR, 10, 50)
    love.graphics.print("Comer: " .. self.necessidades.COMIDA, 10, 60)
    love.graphics.print("Dormir: " .. self.necessidades.DORMIR, 10, 70)
end

function Tamagotchi:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        self.interface:ativar()
        -- for i, botao in pairs(self.botoes) do
        --     botao:ativar()
        -- end
    end
end

function Tamagotchi:endContact(entidade_colisora, b, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        self.interface:desativar()
        -- for i, botao in pairs(self.botoes) do
        --     botao:desativar()
        -- end
    end
end

-- function Tamagotchi:estaVivo()
--     return self.estaVivo
-- end

function Tamagotchi:checkInterfaceClick()
    if self.interface.ativa and self.interface:isHovered() then
        self:atenderNecessidade(NECESSIDADE.AGUA)
        local jogador = GetWorldEntitiesByTag(EntityTags.JOGADOR)[1]
        jogador:AddPontuacao(100)
    end
end

function Tamagotchi:destruir()
    -- for i, botao in pairs(self.botoes) do
    --     botao:destruir()
    -- end
    self.toBeDestroyed = true
end

return Tamagotchi