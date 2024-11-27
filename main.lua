
require("core.auxiliary.world_functions")
require("core.auxiliary.utils")
require("core.auxiliary.debug")
local EntityTags = require("enumsGame.EntityTags")
local MAPA = require("enumsGame.Mapas")
local Jogador = require("entitiesGame.jogador")
local Loja = require("entitiesGame.loja")
local Casa = require("entitiesGame.casa")
local Janela = require("classesGame.Janela")
local TelaInicio = require("classesGame.TelaInicio")
local TelaIntro = require("classesGame.TelaIntro")
local TelaJogo = require("classesGame.TelaJogo")
local TelaFim = require("classesGame.TelaFim")
local SoundControls = require("classesGame.SoundControls")

interiorCasa = nil

MAIN_FONT = love.graphics.newFont(14)

local mapaJogo = nil
local telaAtual = nil

if math.random() <= 0.5 then
    mapaJogo = MAPA.tipo1
else
    mapaJogo = MAPA.tipo2
end
TelaJogo:setMapa(mapaJogo)

if arg[2] == "debug" then
    require("lldebugger").start()
    DEBUG_MODE = true
end

-- love.load -> love.update -> love.draw -> love.update -> love.draw -> love.update (...)

local filtroNoite = love.graphics.newImage("assets/filtroNoite.png")


local TELA = nil

function love.load()
    love.window.setMode(Janela:getTamanho().x, Janela:getTamanho().y)
    CreateWorld()
    TELA = {
        INICIO = TelaInicio(),
        INTRO = TelaIntro(),
        JOGO = TelaJogo(),
        FIM = TelaFim()
    }
    carregarTelaInicial()
end

function mudarTelaPara(novaTela)
    for i, tela in pairs(TELA) do
        if tela == novaTela then
            tela:ativarBotoes()
        else
            tela:desativarBotoes()
        end
    end
    telaAtual = novaTela
    SoundControls.updateMusic(telaAtual)
end

function carregarTelaInicial()
    mudarTelaPara(TELA.INICIO)
    love.graphics.setFont(MAIN_FONT)
end

function carregarIntro()
    mudarTelaPara(TELA.INTRO)
end

function iniciarJogo()
    mudarTelaPara(TELA.JOGO)
    criarJogador()
    criarLoja()
    criarCasas()
    criarTamagotchiEmUmaCasa()
end

function finalizarJogo()
    destruirMoedas()
    destruirLoja()
    destruirCasas()
    destruirInteriorCasa()
    destruirTamagotchis()
    destruirJogador()
    mudarTelaPara(TELA.FIM)
    telaAtual:setPontuacaoFinal(jogador.pontuacao)
end

function love.update(dt)
    if not TelaJogo:estaPausado() then
        updateCursor()
        UpdateWorldEntities(dt)
        telaAtual:update(dt)
    end
end

function love.draw()
    if not (telaAtual == nil) then
        telaAtual:draw()
    end
    DrawWorldEntities()
    if DEBUG_MODE then
        DrawWorldEntityCountTopLeft()
        -- DrawColliders()
    end

    if telaAtual == TELA.JOGO then
        love.graphics.draw(filtroNoite)
    end

end

function love.keypressed(key)
    if key == "escape" then
        telaAtual:pause()
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

function updateCursor()

    love.mouse.setCursor()
    local todosBotoes = GetWorldEntitiesByTag(EntityTags.BOTAO)
    for i, botao in ipairs(todosBotoes) do
        if botao:isHovered() then
            love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
        end
    end
end



function criarTamagotchiEmUmaCasa()
    
    local todasCasas = GetWorldEntitiesByTag(EntityTags.CASA)
    for i, casa in ipairs(todasCasas) do
        if casa.tamagotchi == nil then
            casa:criarTamagotchi()
            break
        end
    end
end


function criarJogador()
    jogador = Jogador(0, 0)
end


function criarLoja()
    Loja(480 + 96 / 2, 0 + 96 / 2)
end

function criarCasas()
    local casaWidth, casaHeight = 128, 128
    for i, pos in pairs(mapaJogo.CASAS_POS) do
        Casa(pos.x + casaWidth / 2, pos.y + casaHeight / 2)
    end
end

function destruirMoedas()
    
    local todasMoedas = GetWorldEntitiesByTag(EntityTags.MOEDAS)
    for i, moeda in ipairs(todasMoedas) do
        moeda:destruir()
    end
end

function destruirInteriorCasa()
    destruirArmadilhas()
    
    local todosChao = GetWorldEntitiesByTag(EntityTags.CHAO)
    for i, chao in ipairs(todosChao) do
        chao:destruir()
    end
    
    local todosParede = GetWorldEntitiesByTag(EntityTags.PAREDE)
    for i, parede in ipairs(todosParede) do
        parede:destruir()
    end
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

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end