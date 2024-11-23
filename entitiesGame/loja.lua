
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
    self.aberta = false
    self.botoes = {
        comprarPantufa = Botao(100, 100, "assets/botaoRect.png", ShapeTypes.RECTANGLE, self.comprar)
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

function Loja:Abrir()
    self.aberta = true
    self.botoes.comprarPantufa:ativar()
end

function Loja:Fechar()
    self.aberta = false
end

function Loja:comprar()
    local jogador = GetWorldEntitiesByTag("jogador")[1]
    local precoItem = Items.PANTUFA.PRECO
    if jogador:TemDinheiroSuficiente(precoItem) then
        jogador:AddPantufa(1)
        jogador:RemoverDinheiro(precoItem)
    end
end

return Loja