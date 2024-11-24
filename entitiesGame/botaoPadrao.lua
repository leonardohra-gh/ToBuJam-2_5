
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
    BotaoPadrao.super.draw(self)
end

return BotaoPadrao