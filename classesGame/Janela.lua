
local Object = require("libs.classic")
local Janela = Object:extend()

local TAMANHO = {x = 1366, y = 768}

function Janela:update(dt)
end

function Janela:draw()
end

function Janela:getTamanho()
    return TAMANHO
end

function Janela:getCentro()
    return {x = TAMANHO.x / 2, y = TAMANHO.y / 2}
end

return Janela