require("core.auxiliary.world_functions")
require("core.auxiliary.utils")
require("core.auxiliary.debug")
local Jogador = require("entitiesGame.jogador")
local Casa = require("entitiesGame.casa")
local Rua = require("entitiesGame.rua")

if arg[2] == "debug" then
    require("lldebugger").start()
    DEBUG_MODE = true
end
-- love.load -> love.update -> love.draw -> love.update -> love.draw -> love.update (...)
function love.load()
    CreateWorld()
    jogador = Jogador(250,250)
    casa = Casa(300,200)
    rua = Rua(100,100)
end
function love.update(dt)
    UpdateWorldEntities(dt)
end
function love.draw()
    DrawWorldEntities()
    if DEBUG_MODE then
        DrawWorldEntityCountTopLeft()
        DrawColliders()
        DrawTester("Luana")
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