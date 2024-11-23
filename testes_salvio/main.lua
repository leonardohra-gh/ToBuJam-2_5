require("core.auxiliary.world_functions")
require("core.auxiliary.utils")
require("core.auxiliary.debug")
local Parede = require("entitiesGame.parede")
if arg[2] == "debug" then
    require("lldebugger").start()
    DEBUG_MODE = true
end
-- love.load -> love.update -> love.draw -> love.update -> love.draw -> love.update (...)
function love.load()
    CreateWorld()
    parede = Parede(200, 230)
end
function love.update(dt)
    UpdateWorldEntities(dt)
end
function love.draw()
    DrawWorldEntities()
    if DEBUG_MODE then
        DrawWorldEntityCountTopLeft()
        DrawColliders()
        DrawTester("Sálvio")
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