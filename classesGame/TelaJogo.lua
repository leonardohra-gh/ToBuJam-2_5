
local MAPA = require("enumsGame.Mapas")
local Casa = require("entitiesGame.casa")
local Janela = require("classesGame.Janela")
local Tela = require("classesGame.Tela")
local TelaJogo = Tela:extend()

local TEMPOCRIACAOTAMAGOTCHI = 130

local mapaJogo = nil
local jogoPausado = false
local imagePausa = love.graphics.newImage("assets/telaPausa.png")
local contadorCriarTamagotchi = 0

function TelaJogo:new()
    mapaJogo = MAPA[getRandomInt(2)]
    TelaJogo.super.new(self, mapaJogo.IMAGE)
end

function TelaJogo:update(dt)
    contadorCriarTamagotchi = contadorCriarTamagotchi + dt
    if TEMPOCRIACAOTAMAGOTCHI <= contadorCriarTamagotchi then
        contadorCriarTamagotchi = 0
        criarTamagotchiEmUmaCasa()
    end
end

function TelaJogo:draw()
    TelaJogo.super.draw(self)
    if jogoPausado then
        love.graphics.draw(imagePausa)
        local centroTela = Janela:getCentro()
        love.graphics.printf("Jogo pausado", centroTela.x - 250, centroTela.y, 500, "center")
    end
end

function TelaJogo:estaPausado()
    return jogoPausado
end

function TelaJogo:pause()
    jogoPausado = not jogoPausado
end

function TelaJogo:ativarBotoes()
end

function TelaJogo:desativarBotoes()
end

function TelaJogo:atualizarTempoCriacaoTamagotchi()
    TEMPOCRIACAOTAMAGOTCHI = TEMPOCRIACAOTAMAGOTCHI - dificuldadeJogo
end

function TelaJogo:criarCasas()
    local casaWidth, casaHeight = 128, 128
    for i, pos in pairs(mapaJogo.CASAS_POS) do
        Casa(pos.x + casaWidth / 2, pos.y + casaHeight / 2)
    end
end

return TelaJogo