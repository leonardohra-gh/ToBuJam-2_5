
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local EntityTags = require("enumsGame.EntityTags")
local Entity = require("core.entity")
local Botao = Entity:extend()

function Botao:new(x, y, imagePath, imageHoveredPath, texto, shapeType, action)
    Botao.super.new(self, x, y, imagePath, World, shapeType, BodyTypes.STATIC, EntityTags.BOTAO, true)
    self.ativo = true
    self.action = action
    self.texto = texto
    self.hoveredImage = love.graphics.newImage(imageHoveredPath)
end

function Botao:update(dt)

    Botao.super.update(self, dt)

end

function Botao:draw()
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

function Botao:isHovered()

    local botaoX, botaoY = self.physics:getPositionRounded()
    local width, height = self.physics:getSize()
    local mouseX, mouseY = love.mouse.getPosition()

    if self.physics.shapeType == ShapeTypes.CIRCLE then
        local raio = width / 2
        local distParaCentro = math.sqrt(math.pow((mouseX - botaoX), 2) + math.pow((mouseY - botaoY), 2))

        return distParaCentro <= raio
    end

    if self.physics.shapeType == ShapeTypes.RECTANGLE then
        return math.abs(mouseX - botaoX) <= width / 2 and math.abs(mouseY - botaoY) <= height / 2
    end

end

function Botao:estaAtivo()
    return self.ativo
end

function Botao:ativar()
    self.ativo = true
end

function Botao:desativar()
    self.ativo = false
end

function Botao:performAction()
    self.action()
end

return Botao