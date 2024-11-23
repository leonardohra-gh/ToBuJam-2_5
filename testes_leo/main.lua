require("core.auxiliary.world_functions")
require("core.auxiliary.utils")
require("core.auxiliary.debug")
Mochila = require("entitiesGame.jogador")
Parede = require("entitiesGame.parede")
Chao = require("entitiesGame.chao")
ChaoCraquelado = require("entitiesGame.chaoCraquelado")
chaoEscorregadio = require("entitiesGame.chaoEscorregadio")
Rua = require("entitiesGame.rua")

if arg[2] == "debug" then
    require("lldebugger").start()
    DEBUG_MODE = true
end
-- love.load -> love.update -> love.draw -> love.update -> love.draw -> love.update (...)
function love.load()
    love.window.setMode(1366, 768)
    CreateWorld()
    local player = Mochila(100, 100)
    local parede = Parede(200, 200)
    -- local chao = Chao(300, 300)
    local chaoEscorregadio = chaoEscorregadio(300, 300)
    local parede2 = Parede(900, 300)
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