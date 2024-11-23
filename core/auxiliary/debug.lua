require("core.auxiliary.world_functions")
local ShapeTypes = require("core.enums.shape_types")

function DrawWorldEntityCountTopLeft()
    local worldEntities = GetWorldEntities()
    love.graphics.print("Number of entities: " .. #worldEntities, 10, 10)
end

function DrawColliders()
    local worldEntities = GetWorldEntities()
    
    for i = 1, #worldEntities do
        worldEntities[i].physics:drawCollider()
    end
end