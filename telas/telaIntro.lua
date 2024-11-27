
local Object = require("libs.classic")
local TelaIntro = Object:extend()

local textSy = 16
local duration = 100
local boxSpeed = 2
local boxEnterTime = 10
local sy = 85

function TelaIntro:new()
    self.timeCounter = 0
    self.box = {
        box1 = {x = -500, y = 50},
        box2 = {x = 1366, y = 50 + sy},
        box3 = {x = -500, y = 50 + 2 * sy},
        box4 = {x = 1366, y = 50 + 3 * sy},
        box5 = {x = -800, y = 50 + 4 * sy},
        box6 = {x = 1366, y = 50 + 5 * sy},
        box7 = {x = -500, y = 50 + 6 * sy}
    }
    self.texto = {
        texto1 = "Tamagochivile é uma cidade pequena e pacata. Seus habitantes gostam muito de tamagochis",
        texto2 = "que são animais virtuais que necessitam de cuidados.",
        texto3 = "Porém... nem todo mundo sabe cuidar bem dos seus tamagochis.",
        texto4 =  "Alguns habitantes de Tamagochivile deixam seus pet virtuais de lado e os deixam morrer.",

        texto5 = "Mas... em Tamagochivile há uma lenda: a Fada do Tamagochi.",
        texto6 = "A Fada do Tamagochi é um ser ....... místico, que tem muito carinho por essas criaturas",
        texto7 = "A Fada do Tamagochi cuida deles",
        texto8 = "A Fada do Tamagochi os salva da morte",
        texto9 = "A Fada do Tamagochi... cobra um preço",
        
        texto10 = "Nem todo mundo gosta da Fada do Tamagochi.",
        texto11 = "Então, os habitantes da cidade fazem um esforço herculeano",
        texto12 = "para reformar suas casas todos os dias e colocarem armadilhas",
        texto13 = "para pegar a Fada do Tamagochi e proteger seu dinheiro",

        texto14 = "Toda noite aparecerão tamagochis morrendo, em cima das casas. Uma barrinha indicará quanto tempo eles tem até morrerem.",
        texto15 = "Vá até a casa e evite as armadilhas para chegar ao tamagochi.",
        texto16 = "Escolha a opção certa para atender as necessidades do tamagochi.",
        texto17 = "Pegue o dinheiro suado pelo seu trabalho duro e saia da casa.",
            
        texto18 = "Patos de borracha vão denunciar sua posição e você perderá",
        texto19 = "Robôs aspiradores caminharão pela casa e, se te encontrarem, alertarão os donos e você perderá",
        texto20 = "Cuidado com o chão escorregadio, ao escorregar, você só irá parar dando de cara em uma parede",
        texto21 = "Cuidado com lança dardos, eles atirarão se você entrar na linha de visão deles",

        texto22 = "Use seu dinheiro para comprar itens que desativam as armadilhas (consumíveis) ou upgrades definitivos",
        texto23 = "Clique no item para gasta-lo na próxima vez que cair na sua respectiva armadilha",
        texto24 = "Pantufas evitam que patos de borracha façam barulho",
        texto25 = "A capa da invisibilidade irá impedir o sensor do robô de te detectar",
        
        texto26 = "Botas de neve vão te ajudar a não escorregar",
        texto27 = "Escudo vai te proteger dos dardos atirados pelo lança dardos",
        texto28 = "O patins vai te fazer andar mais rápido",
        texto29 = "O turbo vai fazer os tamagotchis sentirem menos necessidades"
    }
end

function TelaIntro:update(dt)
    self.timeCounter = self.timeCounter + dt

    if duration <= self.timeCounter then
        iniciarJogo()
    end
end

function TelaIntro:draw()
    self:drawTextBox1()
    self:drawTextBox2()
    self:drawTextBox3()
    self:drawTextBox4()
    self:drawTextBox5()
    self:drawTextBox6()
    self:drawTextBox7()
end

function TelaIntro:drawTextBox1()
    if self.timeCounter <= boxEnterTime then
        self.box.box1.x = self.box.box1.x + boxSpeed
    end

    -- love.graphics.rectangle("line", self.box.box1.x, self.box.box1.y, 100, 50)
    love.graphics.print(self.texto.texto1, self.box.box1.x, self.box.box1.y)
    love.graphics.print(self.texto.texto2, self.box.box1.x, self.box.box1.y + textSy)
    love.graphics.print(self.texto.texto3, self.box.box1.x, self.box.box1.y + 2 * textSy)
    love.graphics.print(self.texto.texto4, self.box.box1.x, self.box.box1.y + 3 * textSy)
end

function TelaIntro:drawTextBox2()
    if boxEnterTime <= self.timeCounter and self.timeCounter <= 2 * boxEnterTime then
        self.box.box2.x = self.box.box2.x - boxSpeed
    end

    love.graphics.print(self.texto.texto5, self.box.box2.x, self.box.box2.y)
    love.graphics.print(self.texto.texto6, self.box.box2.x, self.box.box2.y + textSy)
    love.graphics.print(self.texto.texto7, self.box.box2.x, self.box.box2.y + 2 * textSy)
    love.graphics.print(self.texto.texto8, self.box.box2.x, self.box.box2.y + 3 * textSy)
    love.graphics.print(self.texto.texto9, self.box.box2.x, self.box.box2.y + 4 * textSy)
end

function TelaIntro:drawTextBox3()
    if 2 * boxEnterTime <= self.timeCounter and self.timeCounter <= 3 * boxEnterTime then
        self.box.box3.x = self.box.box3.x + boxSpeed
    end

    -- love.graphics.rectangle("line", self.box.box3.x, self.box.box3.y, 100, 50)
    love.graphics.print(self.texto.texto10, self.box.box3.x, self.box.box3.y)
    love.graphics.print(self.texto.texto11, self.box.box3.x, self.box.box3.y + textSy)
    love.graphics.print(self.texto.texto12, self.box.box3.x, self.box.box3.y + 2 * textSy)
    love.graphics.print(self.texto.texto13, self.box.box3.x, self.box.box3.y + 3 * textSy)
end

function TelaIntro:drawTextBox4()
    if 3 * boxEnterTime <= self.timeCounter and self.timeCounter <= 4 * boxEnterTime then
        self.box.box4.x = self.box.box4.x - boxSpeed
    end

    love.graphics.print(self.texto.texto14, self.box.box4.x, self.box.box4.y)
    love.graphics.print(self.texto.texto15, self.box.box4.x, self.box.box4.y + textSy)
    love.graphics.print(self.texto.texto16, self.box.box4.x, self.box.box4.y + 2 * textSy)
    love.graphics.print(self.texto.texto17, self.box.box4.x, self.box.box4.y + 3 * textSy)
end

function TelaIntro:drawTextBox5()
    if 4 * boxEnterTime <= self.timeCounter and self.timeCounter <= 5 * boxEnterTime then
        self.box.box5.x = self.box.box5.x + boxSpeed
    end

    -- love.graphics.rectangle("line", self.box.box5.x, self.box.box5.y, 100, 50)
    love.graphics.print(self.texto.texto18, self.box.box5.x, self.box.box5.y)
    love.graphics.print(self.texto.texto19, self.box.box5.x, self.box.box5.y + textSy)
    love.graphics.print(self.texto.texto20, self.box.box5.x, self.box.box5.y + 2 * textSy)
    love.graphics.print(self.texto.texto21, self.box.box5.x, self.box.box5.y + 3 * textSy)
end

function TelaIntro:drawTextBox6()
    if 5 * boxEnterTime <= self.timeCounter and self.timeCounter <= 6 * boxEnterTime then
        self.box.box6.x = self.box.box6.x - boxSpeed
    end

    love.graphics.print(self.texto.texto22, self.box.box6.x, self.box.box6.y)
    love.graphics.print(self.texto.texto23, self.box.box6.x, self.box.box6.y + textSy)
    love.graphics.print(self.texto.texto24, self.box.box6.x, self.box.box6.y + 2 * textSy)
    love.graphics.print(self.texto.texto25, self.box.box6.x, self.box.box6.y + 3 * textSy)
end

function TelaIntro:drawTextBox7()
    if 6 * boxEnterTime <= self.timeCounter and self.timeCounter <= 7 * boxEnterTime then
        self.box.box7.x = self.box.box7.x + boxSpeed
    end

    -- love.graphics.rectangle("line", self.box.box7.x, self.box.box7.y, 100, 50)
    love.graphics.print(self.texto.texto26, self.box.box7.x, self.box.box7.y)
    love.graphics.print(self.texto.texto27, self.box.box7.x, self.box.box7.y + textSy)
    love.graphics.print(self.texto.texto28, self.box.box7.x, self.box.box7.y + 2 * textSy)
    love.graphics.print(self.texto.texto29, self.box.box7.x, self.box.box7.y + 3 * textSy)
end

function TelaIntro:ativarBotoes()
end

function TelaIntro:desativarBotoes()
end

return TelaIntro