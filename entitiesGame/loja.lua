
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Items = require("core.enums.items")
local Entity = require("core.entity")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local Loja = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
local BotaoLoja = require("entitiesGame.botaoLoja")
local Tamagotchi = require("entitiesGame.tamagochi")

local imagePath = "assets/loja.png"
local imageBalcao = love.graphics.newImage("assets/lojaBalcao.png")
local balcaoX, balcaoY = 550, 200

function Loja:new(x, y)
    local atravessavel, size, drawPriority = nil, nil, PrioridadeDesenho.LOJA
    Loja.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.LOJA, atravessavel, size, drawPriority)
    self.aberta = false
    self.botoes = {
        comprarPantufa = BotaoLoja(balcaoX + 240, balcaoY + 80, Items.PANTUFA.NOME .. " $" .. Items.COBERTOR.PRECO, "assets/pantufa.png", self.venderPantufa),
        comprarCobertor = BotaoLoja(balcaoX + 512, balcaoY + 144, Items.COBERTOR.NOME .. " $" .. Items.COBERTOR.PRECO, "assets/cobertor.png", self.venderCobertor),
        comprarBotasNeve = BotaoLoja(balcaoX + 240, balcaoY + 208, Items.BOTASNEVE.NOME .. " $" .. Items.BOTASNEVE.PRECO, "assets/botasNeve.png", self.venderBotasNeve),
        comprarEscudo = BotaoLoja(balcaoX + 512, balcaoY + 272, Items.ESCUDO.NOME .. " $" .. Items.ESCUDO.PRECO, "assets/escudo.png", self.venderEscudo),
        comprarPatins = BotaoLoja(balcaoX + 240, balcaoY + 336, Items.PATINS.NOME .. " $" .. Items.PATINS.PRECO, "assets/patins.png", self.venderPatins),
        comprarSuperCharger = BotaoLoja(balcaoX + 512, balcaoY + 400, Items.SUPERCHARGER.NOME .. " $" .. Items.SUPERCHARGER.PRECO, "assets/superCharger.png", self.venderSuperCharger)
    }
    for i, botao in pairs(self.botoes) do
        botao:desativar()
    end
end

function Loja:update(dt)
    Loja.super.update(self, dt)
end

function Loja:draw()
    
    if not self.physics.body:isActive() then
        return
    end
    
    Loja.super.draw(self)

    if self.aberta then
        love.graphics.draw(imageBalcao, balcaoX, balcaoY)
    end
end

function Loja:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        self:Abrir()
    end
end

function Loja:endContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.JOGADOR then
        self:Fechar()
    end
end

function Loja:Abrir()
    self.aberta = true
    for i, botao in pairs(self.botoes) do
        botao:ativar()
    end
end

function Loja:Fechar()
    self.aberta = false
    for i, botao in pairs(self.botoes) do
        botao:desativar()
    end
end

function Loja:venderPantufa()
    venderItem(Items.PANTUFA)
end

function Loja:venderCobertor()
    venderItem(Items.COBERTOR)
end

function Loja:venderBotasNeve()
    venderItem(Items.BOTASNEVE)
end

function Loja:venderEscudo()
    venderItem(Items.ESCUDO)
end

function Loja:venderPatins()
    local jogador = GetWorldEntitiesByTag(EntityTags.JOGADOR)[1]
    if jogador:PodeAumentarVelocidade() then
        venderItem(Items.PATINS)
        jogador:AddVelocidade()
    end
end

function Loja:venderSuperCharger()
    venderItem(Items.SUPERCHARGER)
    Tamagotchi:chargeUp()
end

function Loja:destruir()
    for i, botao in pairs(self.botoes) do
        botao:destruir()
    end
    self.toBeDestroyed = true
end

function venderItem(item)
    local precoItem = item.PRECO
    local jogador = GetWorldEntitiesByTag(EntityTags.JOGADOR)[1]
    if jogador.mochila:TemDinheiroSuficiente(precoItem) then
        jogador.mochila:AddItem(item)
        jogador.mochila:RemoverDinheiro(precoItem)
    end
end

return Loja