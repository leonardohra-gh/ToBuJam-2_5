require("core.auxiliary.world_functions")
local ShapeTypes = require("core.enums.shape_types")
local EntityTags = require("enumsGame.EntityTags")

function DrawTester(tester)
    love.graphics.print("Teste de: " .. tester, 10, 580)
end

function DrawWorldEntityCountTopLeft()
    local worldEntities = GetWorldEntities()
    local tamagotchis = GetWorldEntitiesByTag(EntityTags.TAMAGOCHI)
    love.graphics.print("Number of entities: " .. #worldEntities, 10, 10)
    love.graphics.print("#tamagotchis: " .. #tamagotchis, 10, 30)
end

function DrawColliders()
    local worldEntities = GetWorldEntities()
    
    for i = 1, #worldEntities do
        worldEntities[i].physics:drawCollider()
    end
end