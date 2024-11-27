
local Object = require("libs.classic")
local Tela = Object:extend()

function Tela:new(image)
    self.image = image
end

function Tela:update(dt)
end

function Tela:draw()
    love.graphics.draw(self.image)
end


return Tela