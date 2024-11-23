local Entity = require('core.entity')
local Jogador = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")

function Jogador:new(x, y)
    local imagePath = "assets/jogador.png"
    Jogador.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.DYNAMIC, "jogador")
    self.speed = 100
    self.itens = {
        pantufa = 0,
        cobertor = 0,
        botasDeNeve = 0,
        escudo = 0,
        patins = 0,
        superCharger = 0
    }
    self.dinheiro = 0
    self.pontuacao = 0
end

function Jogador:update(dt)
    
    local velocityX, velocityY = 0, 0
    
    if love.keyboard.isDown("right") then
        velocityX = self.speed
    end
    if love.keyboard.isDown("left") then
        velocityX = - self.speed
    end
    if love.keyboard.isDown("up") then
        velocityY = - self.speed
    end
    if love.keyboard.isDown("down") then
        velocityY = self.speed
    end
    
    self.physics:setVelocity(velocityX, velocityY)
    Jogador.super.update(self, dt)
end

function Jogador:draw()
    Jogador.super.draw(self)
end

function Jogador:beginContact(entidade_colisora, coll)
end

function Jogador:endContact(entidade_colisora, b, coll)
end

function Jogador:preSolve(entidade_colisora, b, coll)
end

function Jogador:postSolve(entidade_colisora, b, coll, normalimpulse, tangentimpulse)
end

function Jogador:AddPantufa()
    self.itens.pantufa = self.itens.pantufa + 1
end

function Jogador:AddCobertor()
    self.itens.cobertor = self.itens.covertor + 1
end

function Jogador:AddBotasDeNeve()
    self.itens.botasDeNeve = self.itens.botasDeNeve + 1
end

function Jogador:AddEscudo()
    self.itens.escudo = self.itens.escudo + 1
end

function Jogador:AddPatins()
    self.itens.patins = self.itens.patins + 1
end

function Jogador:AddSuperCharger()
    self.itens.superCharger = self.itens.superCharger + 1
end

function Jogador:RemovePantufa()
    self.itens.pantufa = self.itens.pantufa - 1
end

function Jogador:RemoveCobertor()
    self.itens.cobertor = self.itens.covertor - 1
end

function Jogador:RemoveBotasDeNeve()
    self.itens.botasDeNeve = self.itens.botasDeNeve - 1
end

function Jogador:RemoveEscudo()
    self.itens.escudo = self.itens.escudo - 1
end

function Jogador:RemovePatins()
    self.itens.patins = self.itens.patins - 1
end

function Jogador:RemoveSuperCharger()
    self.itens.superCharger = self.itens.superCharger - 1
end

function Jogador:AddDinheiro(quantidade)
    self.itens.dinheiro = self.itens.dinheiro + quantidade
end

function Jogador:AddPontuacao(quantidade)
    self.itens.pontuacao = self.itens.pontuacao + quantidade
end

return Jogador