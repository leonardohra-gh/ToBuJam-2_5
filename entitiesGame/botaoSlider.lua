
local ShapeTypes = require("core.enums.shape_types")
local Object = require("libs.classic")
local BotaoSlider = Object:extend()

local imageBarra = love.graphics.newImage("assets/botaoSliderBarra.png")
local imageCirculo = love.graphics.newImage("assets/botaoSliderCirculo.png")

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
        raio = 18
    }
end

function BotaoSlider:update(dt)

    if self:isHovered() and love.mouse.isDown(1) then
        local mouseX, mouseY = love.mouse.getPosition()
        self.circulo.pos.x = mouseX - self.circulo.raio
        self.circulo.pos.x = math.max(math.min(self.circulo.pos.x, self.x + self.width - 2 * self.circulo.raio), self.x)
        self.value = self:calcValue()
        self.value = math.max(math.min(self.value, self.max), self.min)
        updateDificuldade(self.value)
    end
    
    -- BotaoSlider.super.update(self, dt)
end

function BotaoSlider:draw()
    local width = math.max(self.circulo.pos.x + 2 * self.circulo.raio - self.x - 2 * 20, 0)
    love.graphics.draw(imageBarra, self.x, self.y)
    love.graphics.setColor(self.value / self.max, 1 - self.value / self.max, 0, 1)
    love.graphics.rectangle("fill", self.x + 20, self.y + 6, width, self.height - 12, 4, 4)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(imageCirculo, self.circulo.pos.x, self.circulo.pos.y)
end

function BotaoSlider:isHovered()
    local tol = 15
    local mouseX, mouseY = love.mouse.getPosition()
    mouseX = mouseX - self.circulo.raio

    return self.x - tol <= mouseX and mouseX <= self.x + self.width - 2 * self.circulo.raio + tol and self.y <= mouseY and mouseY <= self.y + self.height
end

function BotaoSlider:calcValue()
    exactValue = self.min + (self.max - self.min) * (self.circulo.pos.x - self.x) / (self.width - 2 * self.circulo.raio)

    nSteps = math.round(exactValue / self.step)
    roundedValue = nSteps * self.step

    return roundedValue
end


return BotaoSlider