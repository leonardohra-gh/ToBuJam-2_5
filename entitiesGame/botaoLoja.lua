
local ShapeTypes = require("core.enums.shape_types")
local Botao = require("entitiesGame.botao")
local BotaoLoja = Botao:extend()

local imageSelecionada = love.graphics.newImage("assets/botaoMochilaSelecionado.png")

function BotaoLoja:new(x, y, texto, acao)
    BotaoLoja.super.new(self, x, y, "assets/botaoMochila.png", "assets/botaoMochilaHovered.png", texto, ShapeTypes.RECTANGLE, acao)
    self.selecionado = false
    self.itemImage = love.graphics.newImage("assets/pantufa.png")
end

function BotaoLoja:update(dt)

    BotaoLoja.super.update(self, dt)

end

function BotaoLoja:draw()
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

        love.graphics.draw(self.itemImage, centroX + width / 2 - itemWidth / 2 - 20, centroY - height / 2 + itemHeight / 2)
        love.graphics.print(self.texto, centroX - textWidth - width / 2 + 20, centroY - textHeight / 2)
    end
end


return BotaoLoja