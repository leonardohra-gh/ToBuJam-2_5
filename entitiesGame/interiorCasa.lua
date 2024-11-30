
local Object = require("libs.classic")
local SaidaCasa = require("entitiesGame.saidaCasa")
local InteriorCasa = Object:extend()
local OrientacaoParede = require("enumsGame.OrientacaoParede")
local EntityTags       = require("enumsGame.EntityTags")
local Parede = require("entitiesGame.parede")
local Chao = require("entitiesGame.chao")
local ChaoCraquelado = require("entitiesGame.chaoCraquelado")
local ChaoEscorregadio = require("entitiesGame.chaoEscorregadio")
local LancaDardos = require("entitiesGame.lancaDardos")
local Robozinho = require("entitiesGame.robozinho")
local Moeda = require("entitiesGame.moedas")
require("funcoesGlobaisGame.arrayFunctions")

function InteriorCasa:new(qtdArmadilhas, casaOwner)
    self.width, self.height = 21, 12
    self.tileWidth, self.tileHeight = 64, 64
    self.estruturaCasa, self.armadilhasCasa = {}, {}
    self.estruturaCasaEntities, self.armadilhasCasaEntities = {}, {}
    self.tamagochi = nil
    self.start = {i = 0, j = 0}
    self.startDoor = {i = 0, j = 0}
    self.goal = {i = 0, j = 0}
    self.coinIJ = {i= 0, j = 0}
    self.coin = nil
    self.casaOwner = casaOwner
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
    
    self:generateRooms()
    self:generateRandomStart()
    self:generateDoorStart()
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
        if self:distanceToStart(random_i, random_j) > 2 and #self.armadilhasCasa[random_i][random_j] == 0 and (not string.find(self.estruturaCasa[random_i][random_j], "assets/paredes/")) then
            self.armadilhasCasa[random_i][random_j] = random_elem
            i = i + 1
        end
    end

    self:popularArmadilhas()
end

function InteriorCasa:generateRooms()
    local intersectionI = math.random(6, self.width-2)
    local intersectionJ = math.random(6, self.height-2)

    self.estruturaCasa[1][intersectionJ] = OrientacaoParede.T_DIREITA
    self.estruturaCasa[self.width][intersectionJ] = OrientacaoParede.T_ESQUERDA
    for i = 2, self.width-1 do
        self.estruturaCasa[i][intersectionJ] = OrientacaoParede.SIMPLES_HORIZONTAL
    end

    self.estruturaCasa[intersectionI][1] = OrientacaoParede.T_BAIXO
    self.estruturaCasa[intersectionI][self.height] = OrientacaoParede.T_CIMA
    for j = 2, self.height-1 do
        self.estruturaCasa[intersectionI][j] = OrientacaoParede.SIMPLES_VERTICAL
    end

    self.estruturaCasa[intersectionI][intersectionJ] = OrientacaoParede.CRUZ

    local iDoor, jDoor = math.random(2, intersectionI-1), intersectionJ
    self.estruturaCasa[iDoor][jDoor] = EntityTags.CHAO
    iDoor, jDoor = intersectionI, math.random(2, intersectionJ-1)
    self.estruturaCasa[iDoor][jDoor] = EntityTags.CHAO
    iDoor, jDoor = math.random(intersectionI+1, self.width-1), intersectionJ
    self.estruturaCasa[iDoor][jDoor] = EntityTags.CHAO
    iDoor, jDoor = intersectionI, math.random(intersectionJ+1, self.height-1)
    self.estruturaCasa[iDoor][jDoor] = EntityTags.CHAO
end

function InteriorCasa:distanceToStart(i, j)
    return self:distanceBetween(i, j, self.start.i, self.start.j)
end

function InteriorCasa:distanceBetween(i0, j0, i1, j1)
    local distance = math.sqrt(math.pow((i0 - i1), 2) + math.pow((j0 - j1), 2))
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
    local iCloseToWall = {2, self.width - 1}
    local jCloseToWall = {2, self.height - 1}
    local iPossibilities = ArrayFromMToN(2, self.width - 1)
    local jPossibilities = ArrayFromMToN(2, self.height - 1)
    
    if math.random(1, 2) == 1 then
        local randomI, randomJ = self:tryRandomPositionUntilValid(iCloseToWall, jPossibilities)
        self.start = {i = randomI, j = randomJ}
    else
        local randomI, randomJ = self:tryRandomPositionUntilValid(iPossibilities, jCloseToWall)
        self.start = {i = randomI, j = randomJ}
    end
    
end

function InteriorCasa:tryRandomPositionUntilValid(iPossibilities, jPossibilities)
    local randomI = iPossibilities[math.random(1, #(iPossibilities))]
    local randomJ = jPossibilities[math.random(1, #(jPossibilities))]
    while not self:isValidPosition(randomI, randomJ) do
        randomI = iPossibilities[math.random(1, #(iPossibilities))]
        randomJ = jPossibilities[math.random(1, #(jPossibilities))]
    end

    return randomI, randomJ
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
    if self.casaOwner.tamagotchi then
        self.casaOwner:moverTamagotchiPara(x, y)
    end

    local moedaI, moedaJ = math.random(self.width), math.random(self.height)
    while
        self:distanceBetween(moedaI, moedaJ, self.goal.i, self.goal.j) > 3 or
        self:distanceBetween(moedaI, moedaJ, self.goal.i, self.goal.j) == 0 or
        self:isWall(moedaI, moedaJ) do
        moedaI, moedaJ = math.random(self.width), math.random(self.height)
    end

    self.moedaIJ = {i = moedaI, j = moedaJ}
    x, y = self:getPositionFromIJ(self.moedaIJ.i, self.moedaIJ.j)
    self.moeda = Moeda(x, y)

end

function InteriorCasa:generateDoorStart()
    local i, j = self.start.i, self.start.j
    local doorI, doorJ = 1, 1
    if i == 2 then
        doorI = 1
        doorJ = j
    elseif i == self.width - 1 then
        doorI = i + 1
        doorJ = j
    elseif j == 2 then
        doorI = i
        doorJ = 1
    elseif j == self.height - 1 then
        doorI = i
        doorJ = j + 1
    end


    self.estruturaCasa[doorI][doorJ] = EntityTags.SAIDA_CASA
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
            if self:isWall(i, j) then
                local chao = Chao(xAtual, yAtual)
                table.insert(self.estruturaCasaEntities, chao)
                local parede = Parede(xAtual, yAtual, self.estruturaCasa[i][j])
                table.insert(self.estruturaCasaEntities, parede)
            end
            
            if self.estruturaCasa[i][j] == EntityTags.SAIDA_CASA then
                local saida = SaidaCasa(xAtual, yAtual, self.casaOwner) -- TODO destruir isso
                table.insert(self.estruturaCasaEntities, saida)
            end
        end
    end
end

function InteriorCasa:isWall(i, j)
    return string.find(self.estruturaCasa[i][j], "assets/paredes/")
end

function InteriorCasa:isSurroundedByWalls(i, j)
    return (self.estruturaCasa[i-1][j] and self:isWall(i-1, j)) and
           (self.estruturaCasa[i][j-1] and self:isWall(i, j-1)) and
           (self.estruturaCasa[i+1][j] and self:isWall(i+1, j)) and
           (self.estruturaCasa[i][j+1] and self:isWall(i, j+1))
end

function InteriorCasa:isValidPosition(i, j)
    return not (self:isSurroundedByWalls(i, j) or self:isWall(i, j))
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
    local casaX, casaY = self.casaOwner.physics:getPositionRounded()
    self.casaOwner:moverTamagotchiPara(casaX, casaY)
    for i = 1, #self.estruturaCasaEntities do
        self.estruturaCasaEntities[i]:destruir()
    end
    for i = 1, #self.armadilhasCasaEntities do
        self.armadilhasCasaEntities[i]:destruir()
    end

    if self.moeda then
        self.moeda:destruir()
    end
end

return InteriorCasa