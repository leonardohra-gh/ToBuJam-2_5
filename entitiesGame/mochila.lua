
local Object = require("libs.classic")
local Mochila = Object:extend()

function Mochila:new()
    self.pos = {x = 550, y = 30}
    self.dinheiro = 100
    self.itens = {
        pantufa = 0,
        cobertor = 0,
        botasDeNeve = 0,
        escudo = 0,
        patins = 0,
        superCharger = 0
    }
end

function Mochila:update(dt)
end

function Mochila:draw()
    
    love.graphics.print("Pantufas: " .. self.itens.pantufa, self.pos.x, self.pos.y)
    love.graphics.print("Cobertores: " .. self.itens.cobertor, self.pos.x, self.pos.y + 20)
    love.graphics.print("Botas de neve: " .. self.itens.botasDeNeve, self.pos.x, self.pos.y + 40)
    love.graphics.print("Escudo: " .. self.itens.escudo, self.pos.x, self.pos.y + 60)
    love.graphics.print("Patins: " .. self.itens.patins, self.pos.x, self.pos.y + 80)
    love.graphics.print("Super charger: " .. self.itens.superCharger, self.pos.x, self.pos.y + 100)
    love.graphics.print("Moedas: " .. self.dinheiro, self.pos.x, self.pos.y + 120)
end


function Mochila:AddDinheiro(quantidade)
    self.dinheiro = self.dinheiro + quantidade
end

function Mochila:TemDinheiroSuficiente(quantidade)
    return quantidade <= self.dinheiro
end

function Mochila:RemoverDinheiro(quantidade)
    if self:TemDinheiroSuficiente(quantidade) then
        self.dinheiro = self.dinheiro - quantidade
    end
end

function Mochila:AddPantufa()
    self.itens.pantufa = self.itens.pantufa + 1
end

function Mochila:AddCobertor()
    self.itens.cobertor = self.itens.covertor + 1
end

function Mochila:AddBotasDeNeve()
    self.itens.botasDeNeve = self.itens.botasDeNeve + 1
end

function Mochila:AddEscudo()
    self.itens.escudo = self.itens.escudo + 1
end

function Mochila:AddPatins()
    self.itens.patins = self.itens.patins + 1
end

function Mochila:AddSuperCharger()
    self.itens.superCharger = self.itens.superCharger + 1
end

function Mochila:RemovePantufa()
    self.itens.pantufa = self.itens.pantufa - 1
end

function Mochila:RemoveCobertor()
    self.itens.cobertor = self.itens.covertor - 1
end

function Mochila:RemoveBotasDeNeve()
    self.itens.botasDeNeve = self.itens.botasDeNeve - 1
end

function Mochila:RemoveEscudo()
    self.itens.escudo = self.itens.escudo - 1
end

function Mochila:RemovePatins()
    self.itens.patins = self.itens.patins - 1
end

function Mochila:RemoveSuperCharger()
    self.itens.superCharger = self.itens.superCharger - 1
end

return Mochila