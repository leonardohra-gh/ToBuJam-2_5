require("core.auxiliary.world_functions")
local ShapeTypes = require("core.enums.shape_types")
local EntityTags = require("enumsGame.EntityTags")

function DrawTester(tester)
    love.graphics.print("Teste de: " .. tester, 10, 580)
end

function DrawWorldEntityCountTopLeft()
    local worldEntities = GetWorldEntities()
    local tamagotchis = GetWorldEntitiesByTag(EntityTags.TAMAGOCHI)
    local casas = GetWorldEntitiesByTag(EntityTags.CASA)
    love.graphics.print("Number of entities: " .. #worldEntities, 10, 10)
    love.graphics.print("#tamagotchis: " .. #tamagotchis, 10, 30)
    love.graphics.print("#casas: " .. #casas, 10, 50)
end

function DrawColliders()
    local worldEntities = GetWorldEntities()
    
    for i = 1, #worldEntities do
        worldEntities[i].physics:drawCollider()
    end
end