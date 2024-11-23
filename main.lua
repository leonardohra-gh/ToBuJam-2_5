require("core.auxiliary.world_functions")
require("core.auxiliary.utils")
require("core.auxiliary.debug")
local TELA = require("core.enums.telas")
local Botao = require("entitiesGame.botao")
local Tamagochi = require("entitiesGame.tamagochi")
local SHAPE = require("core.enums.shape_types")
local NECESSIDADE = require("core.enums.necessidades")
local Jogador = require("entitiesGame.jogador")

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
    botaoStart = Botao(300, 500, "assets/botaoRect.png", SHAPE.RECTANGLE, iniciarJogo)
    carregarTelaInicial()
    -- botaoAlimentar = Botao(400, 500, "assets/botaoCircular.png", SHAPE.CIRCLE)
    -- Tamagochi1 = Tamagochi(200, 200)
end

function love.update(dt)

    UpdateWorldEntities(dt)
    if telaSelecionada == TELA.INICIO then
        
        -- if love.keyboard.isDown("right") then
        --     Tamagochi1:atenderNecessidade(NECESSIDADE.BRINCAR)
        -- end
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

function love.mousereleased(x, y, button)
    if button == 1 then
        local todosBotoes = GetWorldEntitiesByTag("botao")
        for i, botao in ipairs(todosBotoes) do
            if botao:estaAtivo() and botao:isHovered() then
                botao:action()
            end
        end
    end
end

function iniciarJogo()
    telaSelecionada = TELA.JOGO
    botaoStart:desativar()
    jogador = Jogador(400, 500)
end

function carregarTelaInicial()
    botaoStart:ativar()
end


local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end