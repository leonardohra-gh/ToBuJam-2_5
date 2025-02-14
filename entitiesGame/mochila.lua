
local ITEM = require("core.enums.items")
local Object = require("libs.classic")
local Mochila = Object:extend()
local BotaoMochila = require("entitiesGame.botaoMochila")
local Moedas = require("entitiesGame.moedas")

local botaoWidth, botaoHeight = 34, 38
local botaoX, botaoY = 35, 39
local botaoSx, botaoSy = 34 + 24, 6 + 32 + 16
local mochilaInterface = love.graphics.newImage("assets/mochilaInterface.png")

function Mochila:new()
    self.pos = {x = 1225, y = 130}
    self.dinheiro =10000
    self.itens = {
        pantufa = 0,
        cobertor = 0,
        botasDeNeve = 0,
        escudo = 0,
        patins = 0
    }
    self.itensSelecionados = {
        pantufa = false,
        cobertor = false,
        botasDeNeve = false,
        escudo = false
    }
    self.botoes = {
        pantufa = BotaoMochila(self.pos.x + botaoX, self.pos.y + botaoY, self.itens.pantufa, ITEM.PANTUFA.IMAGEM_PATH),
        cobertor = BotaoMochila(self.pos.x + botaoX, self.pos.y + botaoY + botaoSy, self.itens.cobertor, ITEM.COBERTOR.IMAGEM_PATH),
        botasDeNeve = BotaoMochila(self.pos.x + botaoX, self.pos.y + botaoY + 2 * botaoSy, self.itens.botasDeNeve, ITEM.BOTASNEVE.IMAGEM_PATH),
        escudo = BotaoMochila(self.pos.x + botaoX + botaoSx, self.pos.y + botaoY, self.itens.escudo, ITEM.ESCUDO.IMAGEM_PATH),
    }
end

function Mochila:update(dt)
end

function Mochila:draw()
    love.graphics.draw(mochilaInterface, self.pos.x, self.pos.y)
    love.graphics.draw(ITEM.PATINS.IMAGEM, self.pos.x - botaoWidth / 2 + botaoX + botaoSx, self.pos.y - botaoHeight / 2 + botaoY + botaoSy)
    love.graphics.draw(Moedas:GetImagem(), self.pos.x + botaoX - botaoWidth / 2, self.pos.y + botaoY + 2 * botaoSy + 30)

    love.graphics.print(self.itens.patins, self.pos.x+ botaoX + botaoSx + 12, self.pos.y + botaoY + botaoSy + 10)
    love.graphics.print(self.dinheiro, self.pos.x+ botaoX + 12, self.pos.y + botaoY + 2 * botaoSy + 30)
end

function Mochila:selecionarItem(item)
    if item == ITEM.PANTUFA then
        self.itensSelecionados.pantufa = true
    elseif item == ITEM.COBERTOR then
        self.itensSelecionados.cobertor = true
    elseif item == ITEM.BOTASNEVE then
        self.itensSelecionados.botasDeNeve = true
    elseif item == ITEM.ESCUDO then
        self.itensSelecionados.escudo = true
    end
end

function Mochila:desselecionarItem(item)
    if item == ITEM.PANTUFA then
        self.itensSelecionados.pantufa = false
    elseif item == ITEM.COBERTOR then
        self.itensSelecionados.cobertor = false
    elseif item == ITEM.BOTASNEVE then
        self.itensSelecionados.botasDeNeve = false
    elseif item == ITEM.ESCUDO then
        self.itensSelecionados.escudo = false
    end
end


function Mochila:AddDinheiro(quantidade)
    self.dinheiro = self.dinheiro + quantidade
end

function Mochila:TemDinheiroSuficiente(quantidade)
    return quantidade <= self.dinheiro
end

function Mochila:RemoverDinheiro(quantidade)
    if self:TemDinheiroSuficiente(quantidade) then
        self.dinheiro = self.dinheiro - quantidade
    end
end

function Mochila:AddItem(item)
    if item == ITEM.PANTUFA then
        self.botoes.pantufa:AddItem()
    elseif item == ITEM.COBERTOR then
        self.botoes.cobertor:AddItem()
    elseif item == ITEM.BOTASNEVE then
        self.botoes.botasDeNeve:AddItem()
    elseif item == ITEM.ESCUDO then
        self.botoes.escudo:AddItem()
    elseif item == ITEM.PATINS then
        self.itens.patins = self.itens.patins + 1
    end
    
end

function Mochila:RemoverItem(item)
    if item == ITEM.PANTUFA and 1 <= self.itens.pantufa then
        self.botoes.pantufa:RemoverItem()
    elseif item == ITEM.COBERTOR and 1 <= self.itens.cobertor then
        self.botoes.cobertor:RemoverItem()
    elseif item == ITEM.BOTASNEVE and 1 <= self.itens.botasDeNeve then
        self.botoes.botasDeNeve:RemoverItem()
    elseif item == ITEM.ESCUDO and 1 <= self.itens.escudo then
        self.botoes.escudo:RemoverItem()
    elseif item == ITEM.PATINS and 1 <= self.itens.patins then
        self.itens.patins = self.itens.patins - 1
    end
    
end

function Mochila:destruir()
    for i, botao in pairs(self.botoes) do
        botao:destruir()
    end
end

return Mochila