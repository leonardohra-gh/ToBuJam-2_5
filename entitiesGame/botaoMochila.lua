
local ShapeTypes = require("core.enums.shape_types")
local Botao = require("entitiesGame.botao")
local BotaoMochila = Botao:extend()

local imageSelecionada = love.graphics.newImage("assets/botaoMochilaSelecionado.png")

function BotaoMochila:new(x, y, qtdItens, imageItem)
    BotaoMochila.super.new(self, x, y, "assets/botaoMochila.png", "assets/botaoMochilaHovered.png", qtdItens, ShapeTypes.RECTANGLE, self.alternarSelecao)
    self.qtdItens = qtdItens
    self.selecionado = false
    self.itemImage = love.graphics.newImage(imageItem)
end

function BotaoMochila:update(dt)

    BotaoMochila.super.update(self, dt)
    if self:isHovered() then
        a = true
    end

end

function BotaoMochila:draw()
    if self.ativo then
        local width, height = self.physics:getSize()
        local centroX, centroY = self.physics:getPositionRounded()
        local textWidth  = love.graphics.getFont():getWidth(self.texto)
        local textHeight = love.graphics.getFont():getHeight()
        local itemWidth, itemHeight = self.itemImage:getDimensions()

        if self.selecionado then
            local x, y = self.physics:getPositionRounded()
            love.graphics.draw(imageSelecionada, x - width / 2, y - height / 2)
        elseif self:isHovered() then
            love.graphics.draw(self.hoveredImage, centroX - width / 2, centroY - height / 2)
        else
            Botao.super.draw(self)
        end

        love.graphics.draw(self.itemImage, centroX - width / 2, centroY - height / 2)
        
        local x, y = self.physics:getPositionRounded()
        love.graphics.print(self.qtdItens, x + 12, y + 10)
        -- love.graphics.print(self.qtdItens, centroX - textWidth - width / 2 + 20, centroY - textHeight / 2)
    end
end

function BotaoMochila:selecionar()
    if 1 <= self.qtdItens then
        self.selecionado = true
    end
end

function BotaoMochila:desselecionar()
    self.selecionado = false
end

function BotaoMochila:alternarSelecao()
    if self.selecionado then
        self:desselecionar()
    else
        self:selecionar()
    end
end

function BotaoMochila:AddItem()
    self.qtdItens = self.qtdItens + 1
end

function BotaoMochila:RemoverItem()
    self.qtdItens = self.qtdItens - 1
end

return BotaoMochila