
require("core.auxiliary.world_functions")
require("core.auxiliary.utils")
require("core.auxiliary.debug")
local TELA = require("core.enums.telas")
local SHAPE = require("core.enums.shape_types")
local EntityTags = require("enumsGame.EntityTags")
local CasasPos = require("enumsGame.CasasPos")
local Botao = require("entitiesGame.botao")
local Jogador = require("entitiesGame.jogador")
local Loja = require("entitiesGame.loja")
local Casa = require("entitiesGame.casa")
local TelaIntro = require("telas.telaIntro")

interiorCasa = nil

if arg[2] == "debug" then
    require("lldebugger").start()
    DEBUG_MODE = true
end

-- love.load -> love.update -> love.draw -> love.update -> love.draw -> love.update (...)

local musicIntro = love.audio.newSource("music/Intro.ogg", "stream")
local musicJogo = love.audio.newSource("music/Jogo.wav", "stream")
local tamanhoTela = {x = 1366, y = 768}
local centroTela = {x = tamanhoTela.x / 2, y = tamanhoTela.y / 2}
local MAPA = {
    tipo1 = {
        IMAGEPATH = "assets/mapa_1.png",
        CASAS = CasasPos.mapa1
    },
    tipo2 = {
        IMAGEPATH = "assets/mapa_2.png",
        CASAS = CasasPos.mapa2
    }
}

local mapaSelecionado

if math.random() <= 0.5 then
    mapaSelecionado = MAPA.tipo1
else
    mapaSelecionado = MAPA.tipo2
end

local tela = {
    inicio = love.graphics.newImage("assets/telaInicial.png"),
    intro = love.graphics.newImage("assets/telaIntro.png"),
    jogo = love.graphics.newImage(mapaSelecionado.IMAGEPATH),
    pausa = love.graphics.newImage("assets/telaPausa.png"),
    fim = love.graphics.newImage("assets/telaFim.png")
}

local filtroNoite = love.graphics.newImage("assets/filtroNoite.png")
local telaSelecionada = TELA.INICIO
local TEMPOCRIACAOTAMAGOTCHI = 100
local contadorCriarTamagotchi = 0
local pausado = false
local pontuacaoFinal = 0

function love.load()
    love.window.setMode(tamanhoTela.x, tamanhoTela.y)
    CreateWorld()
    love.graphics.setFont(love.graphics.newFont(18))
    telaIntro = TelaIntro()
    botaoStart = Botao(centroTela.x - 200, centroTela.y, "assets/botaoRect.png", "assets/botaoRectHovered.png", "Start", SHAPE.RECTANGLE, iniciarJogo)
    botaoStartIntro = Botao(centroTela.x + 200, centroTela.y, "assets/botaoRect.png", "assets/botaoRectHovered.png", "Start intro", SHAPE.RECTANGLE, carregarIntro)
    botaoJogarNovamente = Botao(centroTela.x - 100, centroTela.y + 100, "assets/botaoRect.png", "assets/botaoRectHovered.png", "Jogar novamente", SHAPE.RECTANGLE, carregarTelaInicial)
    love.graphics.setFont(love.graphics.newFont(14))
    carregarTelaInicial()
end

function love.update(dt)
    if not pausado then
        UpdateWorldEntities(dt)
        if telaSelecionada == TELA.JOGO then
            contadorCriarTamagotchi = contadorCriarTamagotchi + 1
        end
        if telaSelecionada == TELA.INTRO then
            telaIntro:update(dt)
        end
        if TEMPOCRIACAOTAMAGOTCHI <= contadorCriarTamagotchi then -- TODO Leo and not player está no interior da casa
            contadorCriarTamagotchi = 0
            criarTamagotchiEmUmaCasa()
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
    if telaSelecionada == TELA.JOGO then
        love.graphics.draw(filtroNoite)
    end
    
    if telaSelecionada == TELA.INTRO then
        telaIntro:draw()
    end
    if telaSelecionada == TELA.FIM then
        local texto = "Pontuação total: "
        local textWidth  = love.graphics.getFont():getWidth(texto)
	    local textHeight = love.graphics.getFont():getHeight()
        love.graphics.print(texto .. pontuacaoFinal, 1366 / 2 - textWidth / 2, 768 / 2 - textHeight / 2)
    end
    if pausado then
        
        love.graphics.draw(tela[TELA.PAUSA])
        local texto = "Jogo pausado"
        local textWidth  = love.graphics.getFont():getWidth(texto)
	    local textHeight = love.graphics.getFont():getHeight()
        love.graphics.print(texto, 1366 / 2 - textWidth / 2, 768 / 2 - textHeight / 2)
    end
end

function love.keypressed(key)
    if key == "escape" then
        pausado = not pausado
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
    botaoStartIntro:desativar()
    criarJogador()
    criarLoja()
    criarCasas()
    criarTamagotchiEmUmaCasa()
    musicIntro:stop()
    musicJogo:play()
    telaSelecionada = TELA.JOGO
end

function carregarIntro()
    botaoJogarNovamente:desativar()
    botaoStart:desativar()
    botaoStartIntro:desativar()
    telaSelecionada = TELA.INTRO
end

function carregarTelaInicial()
    botaoStart:ativar()
    botaoStartIntro:ativar()
    botaoJogarNovamente:desativar()
    musicJogo:stop()
    musicIntro:play()
    telaSelecionada = TELA.INICIO
end

function finalizarJogo()    
    love.graphics.setFont(love.graphics.newFont(18))
    pontuacaoFinal = jogador.pontuacao
    destruirMoedas()
    destruirLoja()
    destruirCasas()
    destruirInteriorCasa()
    destruirTamagotchis()
    destruirJogador()
    telaSelecionada = TELA.FIM
    botaoJogarNovamente:ativar()
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

-- function criarCasasMapa1()
--     positions = CasasPos.mapa1

--     local casaWidth, casaHeight = 128, 128
--     for i = 1, #positions do
--         Casa(positions[i].x + casaWidth / 2, positions[i].y + casaHeight / 2)
--     end
-- end

-- function criarCasasMapa2()
--     positions = mapaSelecionado.CASAS

--     local casaWidth, casaHeight = 128, 128
--     for i = 1, #positions do
--         Casa(positions[i].x + casaWidth / 2, positions[i].y + casaHeight / 2)
--     end
-- end

function criarCasas()
    local positions = mapaSelecionado.CASAS

    local casaWidth, casaHeight = 128, 128
    for i = 1, #positions do
        Casa(positions[i].x + casaWidth / 2, positions[i].y + casaHeight / 2)
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