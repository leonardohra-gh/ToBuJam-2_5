
local BodyTypes = require("core.enums.body_types")
local ShapeTypes = require("core.enums.shape_types")
local Entity = require("core.entity")
local Robozinho = Entity:extend()

function Robozinho:new(x, y)
    local imagePath = "assets/robozinho.png"
    Robozinho.super.new(self, x, y, imagePath, World, ShapeTypes.CIRCLE, BodyTypes.DYNAMIC, "robozinho")
    self.vel = {x = 20, y = 0}
end

function Robozinho:update(dt)
    self:mover()
    Robozinho.super.update(self, dt)
end

function Robozinho:draw()
    Robozinho.super.draw(self)
end

function Robozinho:mover()
    self.physics:setVelocity(self.vel.x, self.vel.y)
    
end

function Robozinho:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == "jogador" then
        finalizarJogo()
    end
end

-- function MyEntity:endContact(entidade_colisora, b, coll)
-- end

-- function MyEntity:preSolve(entidade_colisora, b, coll)
-- end

-- function MyEntity:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
-- end

return Robozinho