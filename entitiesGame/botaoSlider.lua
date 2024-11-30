
local ShapeTypes = require("core.enums.shape_types")
local Object = require("libs.classic")
local BotaoSlider = Object:extend()


function BotaoSlider:new(x, y, min, max, width, height, step)
    -- BotaoSlider.super.new(self, x, y, "assets/botaoMochila.png", "assets/botaoMochilaHovered.png", qtdItens, ShapeTypes.RECTANGLE, self.alternarSelecao)
    self.x = x
    self.y = y
    self.min = min
    self.max = max
    self.value = min
    self.width = width
    self.height = height
    self.step = step or 1
    self.circulo = {
        pos = {
            x = x,
            y = y
        },
        raio = height / 2,
        cor = {0, 0, 1}
    }
end

function BotaoSlider:update(dt)

    if self:isHovered() and love.mouse.isDown(1) then
        local mouseX, mouseY = love.mouse.getPosition()
        self.circulo.pos.x = mouseX
        self.value = self:calcValue()
        updateDificuldade(self.value)
    end
    
    -- BotaoSlider.super.update(self, dt)
end

function BotaoSlider:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 10, 10)
    love.graphics.setColor(self.value / self.max, 1 - self.value / self.max, 0, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.circulo.pos.x + 2 * self.circulo.raio - self.x, self.height, 10, 10)
    love.graphics.setColor(self.circulo.cor[1], self.circulo.cor[2], self.circulo.cor[3], 1)
    love.graphics.circle("fill", self.circulo.pos.x + self.circulo.raio, self.circulo.pos.y + self.circulo.raio, self.circulo.raio)
    love.graphics.setColor(1, 1, 1, 1)
end

function BotaoSlider:isHovered()
    local mouseX, mouseY = love.mouse.getPosition()

    -- local distMouseCirculo = math.sqrt(math.pow((mouseX - self.circulo.pos.x), 2) + math.pow((mouseY - self.circulo.pos.y), 2))

    -- return distMouseCirculo <= self.circulo.raio

    return self.x <= mouseX and mouseX <= self.x + self.width - 2 * self.circulo.raio and self.y <= mouseY and mouseY <= self.y + self.height
end

function BotaoSlider:calcValue()
    exactValue = self.min + (self.max - self.min) * (self.circulo.pos.x - self.x) / (self.width - 2 * self.circulo.raio)

    nSteps = math.round(exactValue / self.step)
    roundedValue = nSteps * self.step

    return roundedValue
end


return BotaoSlider