
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Items = require("core.enums.items")
local Entity = require("core.entity")
local PrioridadeDesenho = require("enumsGame.PrioridadeDesenho")
local Loja = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
local BotaoLoja = require("entitiesGame.botaoLoja")

function Loja:new(x, y)
    local imagePath = "assets/loja.png"
    local atravessavel, size, drawPriority = nil, nil, PrioridadeDesenho.LOJA
    Loja.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.LOJA, atravessavel, size, drawPriority)
    local botaoWidth, botaoHeight = 64, 32
    local botoesX, botoesY = x + self.physics.width / 2 + botaoWidth / 2, y - self.physics.height / 2 + botaoHeight / 2
    self.aberta = false
    self.botoes = {
        comprarPantufa = BotaoLoja(botoesX, botoesY, Items.PANTUFA.NOME .. " $" .. Items.COBERTOR.PRECO, self.venderPantufa),
        comprarCobertor = BotaoLoja(botoesX, botoesY + botaoHeight, Items.COBERTOR.NOME .. "$" .. Items.COBERTOR.PRECO, self.venderCobertor),
        comprarBotasNeve = BotaoLoja(botoesX, botoesY + 2 * botaoHeight, Items.BOTASNEVE.NOME .. "$" .. Items.BOTASNEVE.PRECO, self.venderBotasNeve),
        comprarEscudo = BotaoLoja(botoesX, botoesY + 3 * botaoHeight, Items.ESCUDO.NOME .. "$" .. Items.ESCUDO.PRECO, self.venderEscudo),
        comprarPatins = BotaoLoja(botoesX, botoesY + 4 * botaoHeight, Items.PATINS.NOME .. "$" .. Items.PATINS.PRECO, self.venderPatins),
        comprarSuperCharger = BotaoLoja(botoesX, botoesY + 5 * botaoHeight, Items.SUPERCHARGER.NOME .. "$" .. Items.SUPERCHARGER.PRECO, self.venderSuperCharger)
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