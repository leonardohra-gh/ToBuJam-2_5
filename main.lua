require("core.auxiliary.world_functions")
require("core.auxiliary.utils")
require("core.auxiliary.debug")
local EntityTags = require("enumsGame.EntityTags")
local TELA = require("core.enums.telas")
local SHAPE = require("core.enums.shape_types")
local Botao = require("entitiesGame.botao")
local Jogador = require("entitiesGame.jogador")
local Casa = require("entitiesGame.casa")

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
    love.window.setMode(1366, 768)
    CreateWorld()
    botaoStart = Botao(300, 500, "assets/botaoRect.png", SHAPE.RECTANGLE, iniciarJogo)
    botaoJogarNovamente = Botao(500, 500, "assets/botaoRect.png", SHAPE.RECTANGLE, carregarTelaInicial)
    carregarTelaInicial()
end

function love.update(dt)

    UpdateWorldEntities(dt)

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
        local todosBotoes = GetWorldEntitiesByTag(EntityTags.BOTAO)
        for i, botao in ipairs(todosBotoes) do
            if botao:estaAtivo() and botao:isHovered() then
                botao:action()
            end
        end
    end
end

function iniciarJogo()
    telaSelecionada = TELA.JOGO
    botaoJogarNovamente:desativar()
    botaoStart:desativar()
    jogador = Jogador(400, 500)
    casa = Casa(500,600)
end

function finalizarJogo()
    telaSelecionada = TELA.FIM
    botaoJogarNovamente:ativar()
    jogador.toBeDestroyed = true
    casa.toBeDestroyed = true
end

function carregarTelaInicial()
    telaSelecionada = TELA.INICIO
    botaoStart:ativar()
    botaoJogarNovamente:desativar()
end


local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end