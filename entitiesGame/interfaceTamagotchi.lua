local Entity = require('core.entity')
local InterfaceTamagotchi = Entity:extend()
local BotaoTamagotchi = require("entitiesGame.botaoTamagotchi")
local PrioridadeDesenho = require('enumsGame.PrioridadeDesenho')
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")
local EntityTags = require("enumsGame.EntityTags")


local RAIOINTERNO, RAIOEXTERNO = 5, 16
local imagem = love.graphics.newImage("assets/tamagotchiInterface.png")

function InterfaceTamagotchi:new(tamagotchi)
    
    self.image = imagem
    InterfaceTamagotchi.super.new(self, 200, 100, "assets/tamagotchiInterface.png", World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.InterfaceTamagotchi, true, nil, PrioridadeDesenho.INTERFACE_TAMAGOTCHI)
    self.pos = {x = 200, y = 100}
    self.botoes = {
        agua = BotaoTamagotchi(self.pos.x + 176, self.pos.y + 410, "assets/drink_button.png", tamagotchi, self.darAgua),
        banho = BotaoTamagotchi(self.pos.x + 176 + 128, self.pos.y + 410, "assets/shower_button.png", tamagotchi, self.darBanho),
        brincar = BotaoTamagotchi(self.pos.x + 176 + 256, self.pos.y + 410, "assets/fun_button.png", tamagotchi, self.brincar),
        comida = BotaoTamagotchi(self.pos.x + 176 + 64, self.pos.y + 450, "assets/feed_button.png", tamagotchi, self.alimentar),
        dormir = BotaoTamagotchi(self.pos.x + 176 + 128 + 64, self.pos.y + 450, "assets/sleep_button.png", tamagotchi, self.dormir),
    }
    for i, botao in pairs(self.botoes) do
        botao:desativar()
    end
    self.ativa = false
end

function InterfaceTamagotchi:draw()
    if self.ativa then
        love.graphics.draw(self.image, self.pos.x, self.pos.y)
        for i, botao in pairs(self.botoes) do
            botao:draw()
        end
        -- love.graphics.draw(imagem, self.pos.x, self.pos.y)
    end
end


function InterfaceTamagotchi:darAgua()
    self.tamagotchi:darAgua()
end

function InterfaceTamagotchi:brincar()
    self.tamagotchi:brincar()
end

function InterfaceTamagotchi:darBanho()
    self.tamagotchi:darBanho()
end

function InterfaceTamagotchi:dormir()
    self.tamagotchi:dormir()
end

function InterfaceTamagotchi:alimentar()
    self.tamagotchi:alimentar()
end


function InterfaceTamagotchi:isHovered()

    local mouseX, mouseY = love.mouse.getPosition()
    local distParaCentro = math.sqrt(math.pow((mouseX - self.pos.x), 2) + math.pow((mouseY - self.pos.y), 2))

    return RAIOINTERNO <= distParaCentro and distParaCentro <= RAIOEXTERNO

end

function InterfaceTamagotchi:ativar()
    self.ativa = true
    for i, botao in pairs(self.botoes) do
        botao:ativar()
    end
end

function InterfaceTamagotchi:desativar()
    self.ativa = false
    for i, botao in pairs(self.botoes) do
        botao:desativar()
    end
end

function InterfaceTamagotchi:destruir()
    
    for i, botao in pairs(self.botoes) do
        botao:destruir()
        self.toBeDestroyed = true
    end
end

return InterfaceTamagotchi