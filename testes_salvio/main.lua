require("core.auxiliary.world_functions")
require("core.auxiliary.utils")
require("core.auxiliary.debug")
local EntityTags = require("enumsGame.EntityTags")
local TELA = require("core.enums.telas")
local SHAPE = require("core.enums.shape_types")
local Botao = require("entitiesGame.botao")
local Jogador = require("entitiesGame.jogador")
local Robozinho = require("entitiesGame.robozinho")
local Parede = require("entitiesGame.parede")
local Loja = require("entitiesGame.loja")
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
    CreateWorld()
    love.graphics.setFont(love.graphics.newFont(18))
    botaoStart = Botao(300, 500, "assets/botaoRect.png", "assets/botaoRectHovered.png", "Start", SHAPE.RECTANGLE, iniciarJogo)
    botaoJogarNovamente = Botao(500, 500, "assets/botaoRect.png", "assets/botaoRectHovered.png", "Jogar novamente", SHAPE.RECTANGLE, carregarTelaInicial)
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

        local todosTamagotchis = GetWorldEntitiesByTag(EntityTags.TAMAGOCHI)
        for i, tamagochi in pairs(todosTamagotchis) do
            if tamagochi.estaVivo then
                tamagochi:checkInterfaceClick()
            end
        end

    end
end

function iniciarJogo()
    botaoJogarNovamente:desativar()
    botaoStart:desativar()
    jogador = Jogador(600, 500)
    Loja(300, 400)
    criarCasasAleatorias()
    telaSelecionada = TELA.JOGO
end

function finalizarJogo()
    destruirLoja()
    destruirCasas()
    destruirArmadilhas()
    destruirTamagotchis()
    destruirJogador()
    telaSelecionada = TELA.FIM
    botaoJogarNovamente:ativar()
end

function carregarTelaInicial()
    telaSelecionada = TELA.INICIO
    botaoStart:ativar()
    botaoJogarNovamente:desativar()
end

function destruirArmadilhas()
    local todosChaoCraquelado = GetWorldEntitiesByTag(EntityTags.CHAO_CRAQUELADO)
    for i, chaoCraquelado in ipairs(todosChaoCraquelado) do
        chaoCraquelado:destruir()
    end

    local todosRobos = GetWorldEntitiesByTag(EntityTags.ROBOZINHO)
    for i, robo in ipairs(todosRobos) do
        robo:destruir()
    end
    
    local todosChaoEscorregadio = GetWorldEntitiesByTag(EntityTags.CHAO_ESCORREGADIO)
    for i, chaoEscorregadio in ipairs(todosChaoEscorregadio) do
        chaoEscorregadio:destruir()
    end
    
    local todosLancaDardos = GetWorldEntitiesByTag(EntityTags.LANCA_DARDOS)
    for i, lancaDardos in ipairs(todosLancaDardos) do
        lancaDardos:destruir()
    end
end

function destruirTamagotchis()
    
    local todosTamagotchis = GetWorldEntitiesByTag(EntityTags.TAMAGOCHI)
    for i, tamagotchi in ipairs(todosTamagotchis) do
        tamagotchi:destruir()
    end
end

function destruirCasas()
    local todasCasas = GetWorldEntitiesByTag(EntityTags.CASA)
    for i, casa in ipairs(todasCasas) do
        casa:destruir()
    end
end

function destruirLoja()
    local loja = GetWorldEntitiesByTag(EntityTags.LOJA)[1]
    if not (loja == nil) then
        loja:destruir()
    end
end

function destruirJogador()
    local jogador = GetWorldEntitiesByTag(EntityTags.JOGADOR)[1]
    if not (jogador == nil) then
        jogador:destruir()
    end
end

function criarCasasAleatorias()
    positions = {
        {x = 100, y = 100},
        {x = 1000, y = 150},
        {x = 300, y = 200},
        {x = 750, y = 400},
        {x = 100, y = 600},
        {x = 1250, y = 500},
    }

    for i = 1, #positions do
        Casa(positions[i].x, positions[i].y)
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