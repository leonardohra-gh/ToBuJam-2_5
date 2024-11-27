
local SHAPE = require("core.enums.shape_types")
local Botao = require("entitiesGame.botao")
local Janela = require("classesGame.Janela")
local Tela = require("classesGame.Tela")
local TelaInicio = Tela:extend()

local image = love.graphics.newImage("assets/telaInicial.png")
local botoes = nil

function TelaInicio:new()
    local centroTela = Janela:getCentro()
    botoes =
    {
        start = Botao(centroTela.x - 200, centroTela.y, "assets/botaoRect.png", "assets/botaoRectHovered.png", "Start", SHAPE.RECTANGLE, iniciarJogo),
        intro = Botao(centroTela.x + 200, centroTela.y, "assets/botaoRect.png", "assets/botaoRectHovered.png", "Start intro", SHAPE.RECTANGLE, carregarIntro)
    }
end

function TelaInicio:update(dt)
    for i, botao in pairs(botoes) do
        botao:update(dt)
    end
end

function TelaInicio:draw()
    love.graphics.draw(image)
    for i, botao in pairs(botoes) do
        botao:draw()
    end
end

function TelaInicio:ativarBotoes()
    for i, botao in pairs(botoes) do
        botao:ativar()
    end
end

function TelaInicio:desativarBotoes()
    for i, botao in pairs(botoes) do
        botao:desativar()
    end
end

return TelaInicio