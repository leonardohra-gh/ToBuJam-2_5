
local Object = require("libs.classic")
local TelaIntro = Object:extend()

local duration = 50
local boxSpeed = 2
local boxEnterTime = 5

function TelaIntro:new()
    self.timeCounter = 0
    self.box = {
        box1 = {x = -100, y = 200},
        box2 = {x = 1366, y = 300}
    }
end

function TelaIntro:update(dt)
    self.timeCounter = self.timeCounter + dt

    if duration <= self.timeCounter then
        iniciarJogo()
    end
end

function TelaIntro:draw()
    self:drawTextBox1()
    self:drawTextBox2()
end

function TelaIntro:drawTextBox1()
    if self.timeCounter <= boxEnterTime then
        self.box.box1.x = self.box.box1.x + boxSpeed
    end

    love.graphics.rectangle("line", self.box.box1.x, self.box.box1.y, 100, 50)
    love.graphics.print("Intro ...", self.box.box1.x, self.box.box1.y)
end

function TelaIntro:drawTextBox2()
    if boxEnterTime <= self.timeCounter and self.timeCounter <= 2 * boxEnterTime then
        self.box.box2.x = self.box.box2.x - boxSpeed
    end

    love.graphics.rectangle("line", self.box.box2.x, self.box.box2.y, 100, 50)
    love.graphics.print("Intro2 ...", self.box.box2.x, self.box.box2.y)
end

return TelaIntro