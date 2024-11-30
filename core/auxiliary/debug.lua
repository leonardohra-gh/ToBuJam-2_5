require("core.auxiliary.world_functions")
local ShapeTypes = require("core.enums.shape_types")
local EntityTags = require("enumsGame.EntityTags")

function DrawTester(tester)
    love.graphics.print("Teste de: " .. tester, 10, 580)
end

function DrawWorldEntityCountTopLeft()
    love.graphics.setFont(SMALL_FONT)
    local worldEntities = GetWorldEntities()
    love.graphics.print("Number of entities: " .. #worldEntities, 10, 10)
    
    local i = 1
    for tag, tagValue in pairs(EntityTags) do
        local entities = GetWorldEntitiesByTag(tagValue)
        love.graphics.print("#" .. tag .. ": " .. #entities, 10, 10 + 20 * i)
        i = i + 1
    end
    love.graphics.setFont(MAIN_FONT)
end

function DrawColliders()
    local worldEntities = GetWorldEntities()
    
    for i = 1, #worldEntities do
        worldEntities[i].physics:drawCollider()
    end
end