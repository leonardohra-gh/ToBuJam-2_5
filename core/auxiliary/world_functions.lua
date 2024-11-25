require("core.auxiliary.utils")
local Entity = require("core.entity")
local EntityTags = require("enumsGame.EntityTags")

-- Funções callback do mundo

-- when two fixtures start overlapping (two objects collide).
function BeginContact(fixtureOne, fixtureTwo, collisionContact)
    local entityOne, entityTwo = GetEntityFromFixtures(fixtureOne, fixtureTwo)
    -- Checar se a entidade tem algum comportamento antes de chamar
	if type(entityOne.beginContact) == "function" then
        entityOne:beginContact(entityTwo, collisionContact)
    end
	if type(entityTwo.beginContact) == "function" then
        entityTwo:beginContact(entityOne, collisionContact)
    end
end

-- when two fixtures stop overlapping (two objects disconnect).
function EndContact(fixtureOne, fixtureTwo, collisionContact)
    local entityOne, entityTwo = GetEntityFromFixtures(fixtureOne, fixtureTwo)
	if type(entityOne.endContact) == "function" then
        entityOne:endContact(entityTwo, collisionContact)
    end
	if type(entityTwo.endContact) == "function" then
        entityTwo:endContact(entityOne, collisionContact)
    end
end

-- just before a frame is resolved for a current collision
function PreSolve(fixtureOne, fixtureTwo, collisionContact)
    local entityOne, entityTwo = GetEntityFromFixtures(fixtureOne, fixtureTwo)
	if type(entityOne.preSolve) == "function" then
        entityOne:preSolve(entityTwo, collisionContact)
    end
	if type(entityTwo.preSolve) == "function" then
        entityTwo:preSolve(entityOne, collisionContact)
    end
end

-- just after a frame is resolved for a current collision.
function PostSolve(fixtureOne, fixtureTwo, collisionContact, normalimpulse, tangentimpulse)
    local entityOne, entityTwo = GetEntityFromFixtures(fixtureOne, fixtureTwo)
	if type(entityOne.postSolve) == "function" then
        entityOne:postSolve(entityTwo, collisionContact, normalimpulse, tangentimpulse)
    end
	if type(entityTwo.postSolve) == "function" then
        entityTwo:postSolve(entityOne, collisionContact, normalimpulse, tangentimpulse)
    end
end

function GetWorldEntities()
    local worldEntities = {}
    local worldBodies = World:getBodies()
    for i = 1, #worldBodies do
        local possibleEntity = worldBodies[i]:getFixtures()[1]:getUserData()
        if possibleEntity ~= nil and possibleEntity:is(Entity) then
            table.insert(worldEntities, possibleEntity)
        end
    end
    return worldEntities
end

function GetWorldEntitiesByDrawPriority()
    local worldEntities = {}
    local worldBodies = World:getBodies()
    for i = 1, #worldBodies do
        local possibleEntity = worldBodies[i]:getFixtures()[1]:getUserData()
        if possibleEntity ~= nil and possibleEntity:is(Entity) then
            local drawPriority = possibleEntity.drawPriority
            if not worldEntities[drawPriority] then
                worldEntities[drawPriority] = {}
            end
            table.insert(worldEntities[drawPriority], possibleEntity)
        end
    end
    return worldEntities
end

function GetWorldEntitiesByTag(tag)
    local WorldEntitiesWithTag = {}
    local worldBodies = World:getBodies()
    for i = 1, #worldBodies do
        local possibleEntity = worldBodies[i]:getFixtures()[1]:getUserData()
        if possibleEntity ~= nil and
           possibleEntity:is(Entity) and
           possibleEntity:getTag() == tag then
            table.insert(WorldEntitiesWithTag, possibleEntity)
        end
    end
    return WorldEntitiesWithTag
end

function UpdateWorldEntities(dt)
    World:update(dt)

    local worldEntities = GetWorldEntities()
    for i=1, #worldEntities do
        worldEntities[i]:update(dt)
    end
end

function DrawWorldEntities()
    local worldEntities = GetWorldEntitiesByDrawPriority()
    local sKeys = SortedKeys(worldEntities)
    for i=1, #sKeys do
        local key = sKeys[i]
        for j = 1, #worldEntities[key] do
            worldEntities[key][j]:draw()
        end
    end
end

function SortedKeys(tablePassed)

    local tkeys = {}
    -- populate the table that holds the keys
    for k in pairs(tablePassed) do table.insert(tkeys, k) end
    -- sort the keys
    table.sort(tkeys, function(a,b) return a > b end)

    return tkeys
end

function CreateWorld()
    local gravidadeX = 0
    local gravidadeY = 0
    local enableSleep = true
    World = love.physics.newWorld(gravidadeX, gravidadeY, enableSleep)
    World:setCallbacks(BeginContact, EndContact, PreSolve, PostSolve)
end