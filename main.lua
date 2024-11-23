require("core.auxiliary.world_functions")
require("core.auxiliary.utils")
require("core.auxiliary.debug")
local TELA = require("core.enums.telas")
local Tamagochi = require("entitiesGame.tamagochi")
local NECESSIDADE = require("core.enums.necessidades")

if arg[2] == "debug" then
    require("lldebugger").start()
    DEBUG_MODE = true
end

-- love.load -> love.update -> love.draw -> love.update -> love.draw -> love.update (...)

local tela = {
    inicio = love.graphics.newImage("assets/telaInicial.png"),
    jogo = love.graphics.newImage("assets/telaJogo.png"),
    pausa = love.graphics.newImage("assets/telaPausa.png"),
    fim = love.graphics.newImage("assets/telaFim.png")
}

local telaSelecionada = TELA.INICIO

function love.load()
    CreateWorld()
    Tamagochi1 = Tamagochi(200, 200)
end

function love.update(dt)
    
    if telaSelecionada == TELA.JOGO then
        UpdateWorldEntities(dt)
        if love.keyboard.isDown("right") then
            Tamagochi1:atenderNecessidade(NECESSIDADE.BRINCAR)
        end
    end



end

function love.draw()
    love.graphics.draw(tela[telaSelecionada])
    DrawWorldEntities()
    if DEBUG_MODE then
        DrawWorldEntityCountTopLeft()
        -- DrawColliders()
    end
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end