local Entity = require('core.entity')
local Jogador = Entity:extend()
local ShapeTypes = require("core.enums.shape_types")
local BodyTypes = require("core.enums.body_types")
local EntityTags = require("enumsGame.EntityTags")

function Jogador:new(x, y)
    local imagePath = "assets/jogador.png"
    Jogador.super.new(self, x, y, imagePath, World, ShapeTypes.RECTANGLE, BodyTypes.DYNAMIC, EntityTags.JOGADOR)
    self.speed = 100
    self.itens = {
        pantufa = 0,
        cobertor = 0,
        botasDeNeve = 0,
        escudo = 0,
        patins = 0,
        superCharger = 0
    }
    self.dinheiro = 100
    self.pontuacao = 0
    self.movementDisabled = false
end

function Jogador:mover()
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
end

function Jogador:update(dt)
    if not self.movementDisabled then
        self:mover()
    end
    Jogador.super.update(self, dt)
end

function Jogador:draw()
    Jogador.super.draw(self)
end

function Jogador:beginContact(entidade_colisora, coll)
    if entidade_colisora.tag == EntityTags.CHAO_ESCORREGADIO then
        self.movementDisabled = true
        local velocityX, velocityY = self.physics:getVelocity()
        self.physics:setVelocity(2*velocityX, 2*velocityY)
    elseif entidade_colisora.tag == EntityTags.PAREDE then
        self.movementDisabled = false
    end
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
    self.dinheiro = self.dinheiro + quantidade
end

function Jogador:AddPontuacao(quantidade)
    self.pontuacao = self.pontuacao + quantidade
end

function Jogador:TemDinheiroSuficiente(quantidade)
    return quantidade <= self.dinheiro
end

function Jogador:RemoverDinheiro(quantidade)
    if self:TemDinheiroSuficiente(quantidade) then
        self.dinheiro = self.dinheiro + quantidade
    end
end

return Jogador