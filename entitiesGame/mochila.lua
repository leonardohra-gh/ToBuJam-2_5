
local Items = require("core.enums.items")
local Object = require("libs.classic")
local Mochila = Object:extend()

function Mochila:new()
    self.pos = {x = 650, y = 30}
    self.dinheiro = 100
    self.itens = {
        pantufa = 0,
        cobertor = 0,
        botasDeNeve = 0,
        escudo = 0,
        patins = 0,
        superCharger = 0
    }
    self.itensSelecionados = {
        pantufa = false,
        cobertor = false,
        botasDeNeve = false,
        escudo = false
    }
end

function Mochila:update(dt)
end

function Mochila:draw()
    local selTexto = ""
    if self.itensSelecionados.pantufa then
        selTexto = "Sel "
    end
    love.graphics.print(selTexto .. "Pantufas: " .. self.itens.pantufa, self.pos.x, self.pos.y)
    
    selTexto = ""
    if self.itensSelecionados.cobertor then
        selTexto = "Sel "
    end
    love.graphics.print(selTexto .. "Cobertores: " .. self.itens.cobertor, self.pos.x, self.pos.y + 20)

    selTexto = ""
    if self.itensSelecionados.botasDeNeve then
        selTexto = "Sel "
    end
    love.graphics.print(selTexto .. "Botas de neve: " .. self.itens.botasDeNeve, self.pos.x, self.pos.y + 40)

    selTexto = ""
    if self.itensSelecionados.escudo then
        selTexto = "Sel "
    end
    love.graphics.print(selTexto .. "Escudo: " .. self.itens.escudo, self.pos.x, self.pos.y + 60)
    love.graphics.print("Patins: " .. self.itens.patins, self.pos.x, self.pos.y + 80)
    love.graphics.print("Super charger: " .. self.itens.superCharger, self.pos.x, self.pos.y + 100)
    love.graphics.print("Moedas: " .. self.dinheiro, self.pos.x, self.pos.y + 120)
end

function Mochila:selecionarItem(item)
    if item == Items.PANTUFA then
        self.itensSelecionados.pantufa = true
    elseif item == Items.COBERTOR then
        self.itensSelecionados.cobertor = true
    elseif item == Items.BOTASNEVE then
        self.itensSelecionados.botasDeNeve = true
    elseif item == Items.ESCUDO then
        self.itensSelecionados.escudo = true
    end
end

function Mochila:desselecionarItem(item)
    if item == Items.PANTUFA then
        self.itensSelecionados.pantufa = false
    elseif item == Items.COBERTOR then
        self.itensSelecionados.cobertor = false
    elseif item == Items.BOTASNEVE then
        self.itensSelecionados.botasDeNeve = false
    elseif item == Items.ESCUDO then
        self.itensSelecionados.escudo = false
    end
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

function Mochila:AddItem(item)
    if item == Items.PANTUFA then
        self.itens.pantufa = self.itens.pantufa + 1
    elseif item == Items.COBERTOR then
        self.itens.cobertor = self.itens.cobertor + 1
    elseif item == Items.BOTASNEVE then
        self.itens.botasDeNeve = self.itens.botasDeNeve + 1
    elseif item == Items.ESCUDO then
        self.itens.escudo = self.itens.escudo + 1
    elseif item == Items.PATINS then
        self.itens.patins = self.itens.patins + 1
    elseif item == Items.SUPERCHARGER then
        self.itens.superCharger = self.itens.superCharger + 1
    end
    
end

function Mochila:RemoverItem(item)
    if item == Items.PANTUFA and 1 <= self.itens.pantufa then
        self.itens.pantufa = self.itens.pantufa - 1
    elseif item == Items.COBERTOR and 1 <= self.itens.cobertor then
        self.itens.cobertor = self.itens.cobertor - 1
    elseif item == Items.BOTASNEVE and 1 <= self.itens.botasDeNeve then
        self.itens.botasDeNeve = self.itens.botasDeNeve - 1
    elseif item == Items.ESCUDO and 1 <= self.itens.escudo then
        self.itens.escudo = self.itens.escudo - 1
    elseif item == Items.PATINS and 1 <= self.itens.patins then
        self.itens.patins = self.itens.patins - 1
    elseif item == Items.SUPERCHARGER and 1 <= self.itens.superCharger then
        self.itens.superCharger = self.itens.superCharger - 1
    end
    
end

return Mochila