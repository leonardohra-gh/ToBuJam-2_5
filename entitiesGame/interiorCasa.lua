
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Object = require("libs.classic")
local InteriorCasa = Object:extend()
local OrientacaoParede = require("enumsGame.OrientacaoParede")
local EntityTags       = require("enumsGame.EntityTags")
local Parede = require("entitiesGame.parede")
local Chao = require("entitiesGame.chao")
local ChaoCraquelado = require("entitiesGame.chaoCraquelado")
local ChaoEscorregadio = require("entitiesGame.chaoEscorregadio")
local LancaDardos = require("entitiesGame.lancaDardos")
local Robozinho = require("entitiesGame.robozinho")
local Tamagochi = require("entitiesGame.tamagochi")

function InteriorCasa:new(qtdArmadilhas)
    self.width, self.height = 21, 12
    self.tileWidth, self.tileHeight = 64, 64
    self.estruturaCasa, self.armadilhasCasa = {}, {}
    self.estruturaCasaEntities, self.armadilhasCasaEntities, self.tamagochi = {}, {}, {}
    self.tamagochi = nil
    self.start = {i = 0, j = 0}
    self.goal = {i = 0, j = 0}
    self:gerarCasaProcedural(qtdArmadilhas)
end

function InteriorCasa:gerarCasaProcedural(qtdArmadilhas)
    -- 1344 x 768: 21 tiles horizontais, 12 tiles verticais
    -- total de 252 tiles
    -- começar com 11 pixeis livres à esquerda, 11 à direita

    -- colocar chão
    math.randomseed(os.time())
    math.random(); math.random(); math.random()
    for i = 1, self.width do
        self.estruturaCasa[i] = {}
        for j = 1, self.height do
            self.estruturaCasa[i][j] = EntityTags.CHAO
        end
    end
    
    -- colocar paredes

    for i = 1, self.width do
        for j = 1, self.height do
            if i == 1 or i == self.width then
                self.estruturaCasa[i][j] = OrientacaoParede.SIMPLES_VERTICAL
            end
            if j == 1 or j == self.height then
                self.estruturaCasa[i][j] = OrientacaoParede.SIMPLES_HORIZONTAL
            end

            if i == 1 and j == 1 then
                self.estruturaCasa[i][j] = OrientacaoParede.CURVA_TOP_LEFT
            end
            if i == self.width and j == 1 then
                self.estruturaCasa[i][j] = OrientacaoParede.CURVA_TOP_RIGHT
            end
            
            if j == self.height and i == 1 then
                self.estruturaCasa[i][j] = OrientacaoParede.CURVA_BOTTOM_LEFT
            end
            if j == self.height and i == self.width then
                self.estruturaCasa[i][j] = OrientacaoParede.CURVA_BOTTOM_RIGHT
            end
        end
    end

    self:generateRandomStart()
    self:generateGoal()

    self:popularEstruturas()

    -- colocar chão
    for i = 1, self.width do
        self.armadilhasCasa[i] = {}
        for j = 1, self.height do
            self.armadilhasCasa[i][j] = {}
        end
    end


    local armadilhas = {EntityTags.CHAO_CRAQUELADO, EntityTags.CHAO_ESCORREGADIO, EntityTags.LANCA_DARDOS, EntityTags.ROBOZINHO}
    local keyset = {}
    for k in pairs(armadilhas) do
        table.insert(keyset, k)
    end

    local i = 1
    while i <= qtdArmadilhas do
        local random_elem = armadilhas[keyset[math.random(#keyset)]]
        local random_i = math.random(2, self.width-1)
        local random_j = math.random(2, self.height-1)
        if self:distanceToStart(random_i, random_j) > 2 and #self.armadilhasCasa[random_i][random_j] == 0 then
            self.armadilhasCasa[random_i][random_j] = random_elem
            i = i + 1
        end
    end

    self:popularArmadilhas()
end

function InteriorCasa:distanceToStart(i, j)
    local distance = math.sqrt(math.pow((i - self.start.i), 2) + math.pow((j - self.start.j), 2))
    return distance
end

function InteriorCasa:getPositionStart()
    return self:getPositionFromIJ(self.start.i, self.start.j)
end

function InteriorCasa:getPositionFromIJ(i, j)
    local halfTileWidth, halfTileHeight = self.tileWidth/2, self.tileHeight/2
    local offsetX = 11
    local x, y = offsetX + ((i-1)*self.tileWidth) + halfTileWidth, ((j-1)*self.tileWidth) + halfTileHeight
    return x, y
end

function InteriorCasa:generateRandomStart()
    local iPossibilities = {2, self.width - 1}
    local jPossibilities = {2, self.height - 1}
    local randomI = iPossibilities[math.random(1, 2)]
    local randomJ = jPossibilities[math.random(1, 2)]
    self.start = {i = randomI, j = randomJ}
end

function InteriorCasa:generateGoal()
    if self.start.i == 2 then
        self.goal.i = self.width - 1
    else
        self.goal.i = 2
    end
    
    if self.start.j == 2 then
        self.goal.j = self.height - 1
    else 
        self.goal.j = 2
    end
    local x, y = self:getPositionFromIJ(self.goal.i, self.goal.j)
    self.tamagochi = Tamagochi(x, y)
end

function InteriorCasa:popularEstruturas()
    -- renderizar a casa

    local offsetX = 11
    local halfTileWidth, halfTileHeight = self.tileWidth/2, self.tileHeight/2
    for i = 1, self.width do
        for j = 1, self.height do
            local xAtual, yAtual = offsetX + ((i-1)*self.tileWidth) + halfTileWidth, ((j-1)*self.tileWidth) + halfTileHeight
            if self.estruturaCasa[i][j] == EntityTags.CHAO then
                local chao = Chao(xAtual, yAtual)
                table.insert(self.estruturaCasaEntities, chao)
            end
            if string.find(self.estruturaCasa[i][j], "assets/paredes/") then
                local parede = Parede(xAtual, yAtual, self.estruturaCasa[i][j])
                table.insert(self.estruturaCasaEntities, parede)
            end
        end
    end
end



function InteriorCasa:popularArmadilhas()
    -- renderizar a casa

    local offsetX = 11
    local halfTileWidth, halfTileHeight = self.tileWidth/2, self.tileHeight/2

    for i = 1, self.width do
        for j = 1, self.height do
            local xAtual, yAtual = offsetX + ((i-1)*self.tileWidth) + halfTileWidth, ((j-1)*self.tileWidth) + halfTileHeight

            if self.armadilhasCasa[i][j] == EntityTags.CHAO_CRAQUELADO then
                local chaoCraquelado = ChaoCraquelado(xAtual, yAtual)
                table.insert(self.armadilhasCasaEntities, chaoCraquelado)
            end
            if self.armadilhasCasa[i][j] == EntityTags.CHAO_ESCORREGADIO then
                local chaoEscorregadio = ChaoEscorregadio(xAtual, yAtual)
                table.insert(self.armadilhasCasaEntities, chaoEscorregadio)
            end
            if self.armadilhasCasa[i][j] == EntityTags.LANCA_DARDOS then
                local lancaDardos = LancaDardos(xAtual, yAtual, 300)
                table.insert(self.armadilhasCasaEntities, lancaDardos)
            end
            if self.armadilhasCasa[i][j] == EntityTags.ROBOZINHO then
                local robozinho = Robozinho(xAtual, yAtual)
                table.insert(self.armadilhasCasaEntities, robozinho)
            end
        end
    end
end

function InteriorCasa:destruir()
    -- TODO destruir filhas
end

return InteriorCasa