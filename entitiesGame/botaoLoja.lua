
local ShapeTypes = require("core.enums.shape_types")
local Botao = require("entitiesGame.botao")
local BotaoLoja = Botao:extend()

local imageHovered = love.graphics.newImage("assets/botaoLojaHovered.png")

function BotaoLoja:new(x, y, texto, imageItem, acao)
    BotaoLoja.super.new(self, x, y, "assets/botaoLoja.png", "assets/botaoLojaHovered.png", texto, ShapeTypes.RECTANGLE, acao)
    self.selecionado = false
    self.itemImage = love.graphics.newImage(imageItem)
end

function BotaoLoja:update(dt)

    BotaoLoja.super.update(self, dt)

end

function BotaoLoja:draw()
    if self.ativo then
        local centroX, centroY = self.physics:getPositionRounded()
        love.graphics.draw(self.itemImage, centroX, centroY - 64 / 2)
        love.graphics.print(self.texto, centroX - 130, centroY - 64 / 2)

        if self:isHovered() then
            love.graphics.draw(imageHovered, centroX, centroY - 64 / 2)
        end
    end
end


return BotaoLoja