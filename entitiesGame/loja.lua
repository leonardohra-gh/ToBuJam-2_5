
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Items = require("core.enums.items")
local Entity = require("core.entity")
local Loja = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")
local BotaoPadrao = require("entitiesGame.botaoPadrao")

function Loja:new(x, y)
    local imagePath = "assets/lojaExterior.png"
    Loja.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.LOJA, true)
    local botaoWidth, botaoHeight = 150, 60
    local botoesX, botoesY = x + self.physics.width / 2 + botaoWidth / 2, y - self.physics.height / 2 + botaoHeight / 2
    self.aberta = false
    self.botoes = {
        comprarPantufa = BotaoPadrao(botoesX, botoesY, "Comprar pantufa $" .. Items.PANTUFA.PRECO, self.venderPantufa),
        comprarCobertor = BotaoPadrao(botoesX, botoesY + botaoHeight, "Comprar cobertor $" .. Items.COBERTOR.PRECO, self.venderCobertor),
        comprarBotasNeve = BotaoPadrao(botoesX, botoesY + 2 * botaoHeight, "Comprar botas de neve $" .. Items.BOTASNEVE.PRECO, self.venderBotasNeve),
        comprarEscudo = BotaoPadrao(botoesX, botoesY + 3 * botaoHeight, "Comprar escudo $" .. Items.ESCUDO.PRECO, self.venderEscudo),
        comprarPatins = BotaoPadrao(botoesX, botoesY + 4 * botaoHeight, "Comprar patins $" .. Items.PATINS.PRECO, self.venderPatins),
        comprarSuperCharger = BotaoPadrao(botoesX, botoesY + 5 * botaoHeight, "Comprar super charger $" .. Items.SUPERCHARGER.PRECO, self.venderSuperCharger)
    }
    for i, botao in pairs(self.botoes) do
        botao:desativar()
    end
end

function Loja:update(dt)
    Loja.super.update(self, dt)
end

function Loja:draw()
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
    venderItem(Items.PATINS)
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