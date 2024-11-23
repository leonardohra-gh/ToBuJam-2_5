require("core.auxiliary.world_functions")
require("core.auxiliary.utils")
require("core.auxiliary.debug")
local TELA = require("core.enums.telas")
local SHAPE = require("core.enums.shape_types")
local Botao = require("entitiesGame.botao")
local Jogador = require("entitiesGame.jogador")
local Robozinho = require("entitiesGame.robozinho")
local Parede = require("entitiesGame.parede")
local Loja = require("entitiesGame.loja")

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
    botaoJogarNovamente:desativar()
    botaoStart:desativar()
    jogador = Jogador(0, 0)
    robo = Robozinho(300, 505)
    Parede(400, 500)
    Parede(350, 550)
    Parede(366, 550)
    Parede(382, 550)
    Parede(408, 550)
    Parede(424, 550)
    Loja(300, 300)
end

function finalizarJogo()
    telaSelecionada = TELA.FIM
    botaoJogarNovamente:ativar()
    destruirArmadilhas()
    jogador.toBeDestroyed = true
end

function carregarTelaInicial()
    telaSelecionada = TELA.INICIO
    botaoStart:ativar()
    botaoJogarNovamente:desativar()
end

function destruirArmadilhas()
    local todosChaoCraquelado = GetWorldEntitiesByTag("chaoCraquelado")
    for i, chaoCraquelado in ipairs(todosChaoCraquelado) do
        chaoCraquelado.toBeDestroyed = true
    end

    local todosRobos = GetWorldEntitiesByTag("robozinho")
    for i, robo in ipairs(todosRobos) do
        robo.toBeDestroyed = true
    end

    local todosConeVisao = GetWorldEntitiesByTag("coneVisao")
    for i, coneVisao in ipairs(todosConeVisao) do
        coneVisao.toBeDestroyed = true
    end
    
    local todosChaoEscorregadio = GetWorldEntitiesByTag("chaoEscorregadio")
    for i, chaoEscorregadio in ipairs(todosChaoEscorregadio) do
        chaoEscorregadio.toBeDestroyed = true
    end
    
    local todosLancaDardos = GetWorldEntitiesByTag("lancaDardos")
    for i, lancaDardos in ipairs(todosLancaDardos) do
        lancaDardos.toBeDestroyed = true
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