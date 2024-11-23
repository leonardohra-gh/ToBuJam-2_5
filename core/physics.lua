local Object = require("libs.classic")
local Physics = Object:extend()
local BodyType = require("core.enums.body_types")
local ShapeType = require("core.enums.shape_types")
require("core.auxiliary.utils")

function Physics:new(world, position, size, shapeType, bodyType, atravessavel)
    self.body = love.physics.newBody(world, position.x, position.y, bodyType or BodyType.DYNAMIC)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    atravessavel = atravessavel or false
    self.shapeType = shapeType

    if shapeType == ShapeType.CIRCLE then
        local averageSize = (size.width + size.height)/2
        local radius = averageSize/2
        self.shape = love.physics.newCircleShape(radius)
        self.boundaries = {
            x = {min = radius, max = screenWidth - radius},
            y = {min = radius, max = screenHeight - radius},
        }
        self.width, self.height = radius*2, radius*2
    elseif shapeType == ShapeType.RECTANGLE then
        self.shape = love.physics.newRectangleShape(size.width, size.height)
        self.boundaries = {
            x = {min = size.width/2, max = screenWidth - size.width/2},
            y = {min = size.height/2, max = screenHeight - size.height/2},
        }
        self.width, self.height = size.width, size.height
    end

    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setSensor(atravessavel)
    self.body:setSleepingAllowed(false)
end

function Physics:getPositionRounded()
    return math.round(self.body:getX()), math.round(self.body:getY())
end

function Physics:getSize()
    return self.width, self.height
end

function Physics:move(speedX, speedY)
    local posisitonX, positionY = self.body:getPosition()
    local newPositionX, newPositionY = posisitonX + (speedX or 0), positionY + (speedY or 0)

    if self:isPositionOutOfBounds(newPositionX, newPositionY) then
        return
    end

    self.body:setPosition(newPositionX, newPositionY)
end

function Physics:isPositionOutOfBounds(positionX, positionY)
    return positionX > self.boundaries.x.max or
           positionX < self.boundaries.x.min or
           positionY > self.boundaries.y.max or
           positionY < self.boundaries.y.min
end

function Physics:setVelocity(velocityX, velocityY, shouldReposition)
    shouldReposition = shouldReposition or true
    local currentVelocityX, currentVelocityY = self.body:getLinearVelocity()
    velocityX = velocityX or currentVelocityX
    velocityY = velocityY or currentVelocityY
    self.body:setLinearVelocity(velocityX, velocityY)

    local newPositionX, newPositionY = self.body:getPosition()
    if shouldReposition and self:isPositionOutOfBounds(newPositionX, newPositionY) then
        self:repositionInBounds()
        self.body:setLinearVelocity(0, 0)
    end
end

function Physics:repositionInBounds()
    local currentPositionX, currentPositionY = self.body:getPosition()
    local newPositionXAboveMinimum = math.max(currentPositionX, self.boundaries.x.min)
    local newPositionXInBoundaries = math.min(newPositionXAboveMinimum, self.boundaries.x.max)
    local newPositionYAboveMinimum = math.max(currentPositionY, self.boundaries.y.min)
    local newPositionYInBoundaries = math.min(newPositionYAboveMinimum, self.boundaries.y.max)

    self.body:setPosition(newPositionXInBoundaries, newPositionYInBoundaries)
end

function Physics:getVelocity()
    return self.body:getLinearVelocity()
end

function Physics:applyForce(forceX, forceY)
    self.body:applyForce(forceX, forceY)
end

function Physics:setRestitution(restitution)
    self.fixture:setRestitution(restitution)
end

function Physics:setFriction(friction)
    self.fixture:setFriction(friction)
end

function Physics:setUserData(label)
    self.fixture:setUserData(label)
end

function Physics:getUserData()
    return self.fixture:getUserData()
end

function Physics:setDensity(density)
    self.fixture:setDensity(density)
end

function Physics:drawCollider()
    if self.shapeType == ShapeType.CIRCLE then
        local x, y = self.body:getPosition()
        local radius = self.width/2
        love.graphics.circle("line", x, y, radius, 20)
    elseif self.shapeType == ShapeType.RECTANGLE then
        love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    end
end

function Physics:setSleepingAllowed(allowed)
    self.body:setSleepingAllowed(allowed)
end

return Physics