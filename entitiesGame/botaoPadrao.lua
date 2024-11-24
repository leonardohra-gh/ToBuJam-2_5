
local ShapeTypes = require("core.enums.shape_types")
local Botao = require("entitiesGame.botao")
local BotaoPadrao = Botao:extend()

function BotaoPadrao:new(x, y, texto, action)
    BotaoPadrao.super.new(self, x, y, "assets/botaoRect.png", "assets/botaoRectHovered.png", texto, ShapeTypes.RECTANGLE, action)
end

function BotaoPadrao:update(dt)

    BotaoPadrao.super.update(self, dt)

end

function BotaoPadrao:draw()
    if self.ativo then
        local centroX, centroY = self.physics:getPositionRounded()
        local width, height = self.physics:getSize()
        local textWidth  = love.graphics.getFont():getWidth(self.texto)
	    local textHeight = love.graphics.getFont():getHeight()
        if self:isHovered() then
            love.graphics.draw(self.hoveredImage, centroX - width / 2, centroY - height / 2)
            love.graphics.print(self.texto, centroX - textWidth / 2, centroY - textHeight / 2)
        else
            Botao.super.draw(self)
            love.graphics.print(self.texto, centroX - textWidth / 2, centroY - textHeight / 2 - 10)
        end
    end
end

return BotaoPadrao