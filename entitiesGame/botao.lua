
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local Botao = Entity:extend()

function Botao:new(x, y, imagePath, shapeType)
    Botao.super.new(self, x, y, imagePath, World, shapeType, BodyTypes.STATIC, "botao")
    self.ativo = true
end

function Botao:update(dt)

    Botao.super.update(self, dt)

end

function Botao:draw()
    if self.ativo then
        Botao.super.draw(self)
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

function Botao:action()

    self.ativo = false
    -- a depender do botão, se desative
end

return Botao