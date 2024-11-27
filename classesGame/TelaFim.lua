
local SHAPE = require("core.enums.shape_types")
local Janela = require("classesGame.Janela")
local Botao = require("entitiesGame.botao")
local Tela = require("classesGame.Tela")
local TelaFim = Tela:extend()

local pontuacaoFinal = 0
local image = love.graphics.newImage("assets/telaFim.png")
local font = love.graphics.newFont(18)
local botaoJogarNovamente = nil

function TelaFim:new()
    TelaFim.super.new(self, image)
    local centroTela = Janela:getCentro()
    botaoJogarNovamente = Botao(centroTela.x - 100, centroTela.y + 100, "assets/botaoRect.png", "assets/botaoRectHovered.png", "Jogar novamente", SHAPE.RECTANGLE, carregarTelaInicial)
end

function TelaFim:update(dt)
end

function TelaFim:draw()
    local texto = "Pontuação total: "
    local textWidth  = love.graphics.getFont():getWidth(texto)
    local textHeight = love.graphics.getFont():getHeight()
    love.graphics.setFont(font)
    love.graphics.print(texto .. pontuacaoFinal, 1366 / 2 - textWidth / 2, 768 / 2 - textHeight / 2)
    love.graphics.setFont(MAIN_FONT)
end

function TelaFim:setPontuacaoFinal(pontFinal)
    pontuacaoFinal = pontFinal
end

function TelaFim:ativarBotoes()
    botaoJogarNovamente:ativar()
end

function TelaFim:desativarBotoes()
    botaoJogarNovamente:desativar()
end

return TelaFim