
local Tela = require("classesGame.Tela")
local TelaJogo = Tela:extend()

local image = nil
local jogoPausado = false
local textoPausa = "Jogo pausado"
local imagePausa = love.graphics.newImage("assets/telaPausa.png")
local imageMapa1 = love.graphics.newImage("assets/mapa_1.png")

local TEMPOCRIACAOTAMAGOTCHI = 2
local contadorCriarTamagotchi = 0

function TelaJogo:new()
    TelaJogo.super.new(self, imageMapa1)
end

function TelaJogo:update(dt)
    contadorCriarTamagotchi = contadorCriarTamagotchi + 1
    
    if TEMPOCRIACAOTAMAGOTCHI <= contadorCriarTamagotchi then
        contadorCriarTamagotchi = 0
        criarTamagotchiEmUmaCasa()
    end
end

function TelaJogo:draw()
    love.graphics.draw(image)
    if jogoPausado then
        love.graphics.draw(imagePausa)
        local textWidth  = love.graphics.getFont():getWidth(textoPausa)
	    local textHeight = love.graphics.getFont():getHeight()
        love.graphics.print(textoPausa, 1366 / 2 - textWidth / 2, 768 / 2 - textHeight / 2)
    end
end

function TelaJogo:estaPausado()
    return jogoPausado
end

function TelaJogo:pause()
    jogoPausado = not jogoPausado
end

function TelaJogo:setMapa(mapaJogo)
    image = love.graphics.newImage(mapaJogo.IMAGEPATH)
end

function TelaJogo:ativarBotoes()
end

function TelaJogo:desativarBotoes()
end

return TelaJogo