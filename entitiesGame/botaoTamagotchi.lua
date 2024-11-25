
local ShapeTypes = require("core.enums.shape_types")
local Botao = require("entitiesGame.botao")
local BotaoTamagotchi = Botao:extend()


function BotaoTamagotchi:new(x, y, imagePath, tamagotchi, action)
    BotaoTamagotchi.super.new(self, x, y, imagePath, imagePath, "", ShapeTypes.CIRCLE, action)
    self.tamagotchi = tamagotchi
end

function BotaoTamagotchi:update(dt)

    BotaoTamagotchi.super.update(self, dt)

end

function BotaoTamagotchi:draw()
    if self.ativo then
        Botao.super.draw(self)
        -- local width, height = self.physics:getSize()
        -- local centroX, centroY = self.physics:getPositionRounded()
        -- local textWidth  = love.graphics.getFont():getWidth(self.texto)
        -- local textHeight = love.graphics.getFont():getHeight()
        -- local itemWidth, itemHeight = self.itemImage:getDimensions()

        -- if self.selecionado then
        --     local x, y = self.physics:getPositionRounded()
        --     love.graphics.draw(imageSelecionada, x - width / 2, y - height / 2)
        -- elseif self:isHovered() then
        --     love.graphics.draw(self.hoveredImage, centroX - width / 2, centroY - height / 2)
        -- else
        --     Botao.super.draw(self)
        -- end

        -- love.graphics.draw(self.itemImage, centroX - width / 2, centroY - height / 2)
        -- love.graphics.print(self.qtdItens, centroX - textWidth - width / 2 + 20, centroY - textHeight / 2)
    end
end

return BotaoTamagotchi