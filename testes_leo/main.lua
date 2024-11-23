require("core.auxiliary.world_functions")
require("core.auxiliary.utils")
require("core.auxiliary.debug")
Player = require("entitiesGame.jogador")
Parede = require("entitiesGame.Parede")

if arg[2] == "debug" then
    require("lldebugger").start()
    DEBUG_MODE = true
end
-- love.load -> love.update -> love.draw -> love.update -> love.draw -> love.update (...)
function love.load()
    CreateWorld()
    local player = Player(100, 100)
    local parede = Parede(200, 200)
end
function love.update(dt)
    UpdateWorldEntities(dt)

end
function love.draw()
    DrawWorldEntities()
    if DEBUG_MODE then
        DrawWorldEntityCountTopLeft()
        DrawColliders()
        DrawTester("Leo")
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