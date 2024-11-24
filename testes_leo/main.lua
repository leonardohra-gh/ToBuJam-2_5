require("core.auxiliary.world_functions")
require("core.auxiliary.utils")
require("core.auxiliary.debug")
Jogador = require("entitiesGame.jogador")
Parede = require("entitiesGame.parede")
Chao = require("entitiesGame.chao")
ChaoCraquelado = require("entitiesGame.chaoCraquelado")
ChaoEscorregadio = require("entitiesGame.chaoEscorregadio")
LancaDardos = require("entitiesGame.lancaDardos")
Robozinho = require("entitiesGame.robozinho")
Rua = require("entitiesGame.rua")
Casa = require("entitiesGame.casa")
local OrientacaoParede = require("enumsGame.OrientacaoParede")
local EntityTags       = require("enumsGame.EntityTags")

if arg[2] == "debug" then
    require("lldebugger").start()
    DEBUG_MODE = true
end
-- love.load -> love.update -> love.draw -> love.update -> love.draw -> love.update (...)
function love.load()
    love.window.setMode(1366, 768)
    CreateWorld()
    -- local player = Jogador(800, 300)
    --local parede = Parede(300, 300)
    -- local lancaDardos = LancaDardos(364, 300, 300)
    -- local parede = Parede(900, 300)
    -- local parede = Parede(200, 200)
    -- local chao = Chao(300, 300)
    -- local chaoEscorregadio = chaoEscorregadio(300, 300)
    -- local parede2 = Parede(900, 300)
    --local chaoCraquelado = ChaoCraquelado(100, 200)
    -- local ruaSize = 96
    -- local mult = 1.5
    -- local xi, yi = 0, 400
    -- for i = 1, 6*mult do
    --     local rua = Rua(ruaSize*(i-1), yi, 0)
    -- end
    -- xi, yi = 640, 0
    -- for i = 1, 6*mult do
    --     local rua = Rua(xi, ruaSize*(i-1), math.pi/2)
    -- end
    --criarCasasAleatorias()
    gerarCasaProceduralmente(5)
end
function love.update(dt)
    UpdateWorldEntities(dt)

end
function love.draw()
    DrawWorldEntities()
    if DEBUG_MODE then
        DrawWorldEntityCountTopLeft()
        --DrawColliders()
        DrawTester("Leo")
    end
end

function gerarCasaProceduralmente(qtdArmadilhas)
    -- 1344 x 768: 21 tiles horizontais, 12 tiles verticais
    -- total de 252 tiles
    -- começar com 11 pixeis livres à esquerda, 11 à direita
    local width, height = 21, 12
    local tileWidth, tileHeight = 64, 64
    local casa = {}
    local CHAO, PAREDE, ARMADILHA = 0, 1, 2

    -- colocar chão
    for i = 1, width do
        casa[i] = {}
        for j = 1, height do
            casa[i][j] = CHAO
        end
    end
    
    -- colocar paredes

    for i = 1, width do
        for j = 1, height do
            if i == 1 or i == width then
                casa[i][j] = OrientacaoParede.SIMPLES_VERTICAL
            end
            if j == 1 or j == height then
                casa[i][j] = OrientacaoParede.SIMPLES_HORIZONTAL
            end

            if i == 1 and j == 1 then
                casa[i][j] = OrientacaoParede.CURVA_TOP_LEFT
            end
            if i == width and j == 1 then
                casa[i][j] = OrientacaoParede.CURVA_TOP_RIGHT
            end
            
            if j == height and i == 1 then
                casa[i][j] = OrientacaoParede.CURVA_BOTTOM_LEFT
            end
            if j == height and i == width then
                casa[i][j] = OrientacaoParede.CURVA_BOTTOM_RIGHT
            end
        end
    end
    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    local armadilhas = {EntityTags.CHAO_CRAQUELADO, EntityTags.CHAO_ESCORREGADIO, EntityTags.LANCA_DARDOS, EntityTags.ROBOZINHO}
    local keyset = {}
    for k in pairs(armadilhas) do
        table.insert(keyset, k)
    end

    for i = 1, qtdArmadilhas do
        local random_elem = armadilhas[keyset[math.random(#keyset)]]
        local random_i = math.random(2, width-1)
        local random_j = math.random(2, height-1)
        casa[random_i][random_j] = random_elem
    end


    -- renderizar a casa

    local offsetX = 11
    local halfTileWidth, halfTileHeight = tileWidth/2, tileHeight/2
    for i = 1, width do
        for j = 1, height do
            local xAtual, yAtual = offsetX + ((i-1)*tileWidth) + halfTileWidth, ((j-1)*tileWidth) + halfTileHeight
            if casa[i][j] == CHAO then
                local chao = Chao(xAtual, yAtual)
            end
            if string.find(casa[i][j], "assets/paredes/") then
                local parede = Parede(xAtual, yAtual, casa[i][j])
            end

            if casa[i][j] == EntityTags.CHAO_CRAQUELADO then
                local chaoCraquelado = ChaoCraquelado(xAtual, yAtual)
            end
            if casa[i][j] == EntityTags.CHAO_ESCORREGADIO then
                local ChaoEscorregadio = ChaoEscorregadio(xAtual, yAtual)
            end
            if casa[i][j] == EntityTags.LANCA_DARDOS then
                local LancaDardos = LancaDardos(xAtual, yAtual, 300)
            end
            if casa[i][j] == EntityTags.ROBOZINHO then
                local robozinho = Robozinho(xAtual, yAtual)
            end
        end
    end


end

function criarCasasMapa1()
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