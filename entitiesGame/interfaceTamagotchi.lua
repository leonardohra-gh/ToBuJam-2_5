local Object = require("libs.classic")
local InterfaceTamagotchi = Object:extend()


local RAIOINTERNO, RAIOEXTERNO = 5, 16

function InterfaceTamagotchi:new(x, y)
    self.image = love.graphics.newImage("assets/botaoConico.png")
    self.pos = {x = x, y = y}
    self.ativa = false
end

function InterfaceTamagotchi:draw()
    if self.ativa then
        love.graphics.draw(self.image, self.pos.x, self.pos.y)
    end
end

function InterfaceTamagotchi:isHovered()

    local mouseX, mouseY = love.mouse.getPosition()
    local distParaCentro = math.sqrt(math.pow((mouseX - self.pos.x), 2) + math.pow((mouseY - self.pos.y), 2))

    return RAIOINTERNO <= distParaCentro and distParaCentro <= RAIOEXTERNO

end

function InterfaceTamagotchi:ativar()
    self.ativa = true
end

function InterfaceTamagotchi:desativar()
    self.ativa = false
end

return InterfaceTamagotchi