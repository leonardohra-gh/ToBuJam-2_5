
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Items = require("core.enums.items")
local Botao = require("entitiesGame.botao")
local Entity = require("core.entity")
local Loja = Entity:extend()
local EntityTags = require("enumsGame.EntityTags")

function Loja:new(x, y)
    local imagePath = "assets/lojaExterior.png"
    Loja.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.STATIC, EntityTags.LOJA, true)
    local botoesX, botoesY = x + self.physics.width / 2 + 150 / 2, y - self.physics.height / 2 + 60 / 2
    self.aberta = false
    self.botoes = {
        comprarPantufa = Botao(botoesX, botoesY, "assets/botaoRect.png", "assets/botaoRectHovered.png", "Comprar pantufa", ShapeTypes.RECTANGLE, self.comprar)
    }
    self.precos = {
        pantufa = 50
    }
    self.botoes.comprarPantufa:desativar()
end

function Loja:update(dt)
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
    self.botoes.comprarPantufa:ativar()
end

function Loja:Fechar()
    self.aberta = false
    self.botoes.comprarPantufa:desativar()
end

function Loja:comprar()
    local jogador = GetWorldEntitiesByTag(EntityTags.JOGADOR)[1]
    local precoItem = Items.PANTUFA.PRECO
    if jogador.mochila:TemDinheiroSuficiente(precoItem) then
        jogador.mochila:AddPantufa(1)
        jogador.mochila:RemoverDinheiro(precoItem)
    end
end

return Loja