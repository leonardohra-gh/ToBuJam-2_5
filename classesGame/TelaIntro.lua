
local Tela = require("classesGame.Tela")
local TelaIntro = Tela:extend()

local textSy = 16
local duration = 100
local boxSpeed = 2
local boxEnterTime = 10
local sy = 85
local timeCounter = 0
local box = {
    box1 = {x = -500, y = 50},
    box2 = {x = 1366, y = 50 + sy},
    box3 = {x = -500, y = 50 + 2 * sy},
    box4 = {x = 1366, y = 50 + 3 * sy},
    box5 = {x = -800, y = 50 + 4 * sy},
    box6 = {x = 1366, y = 50 + 5 * sy},
    box7 = {x = -500, y = 50 + 6 * sy}
}
local texto = {
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

function TelaIntro:update(dt)
    timeCounter = timeCounter + dt

    if duration <= timeCounter then
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
    if timeCounter <= boxEnterTime then
        box.box1.x = box.box1.x + boxSpeed
    end

    -- love.graphics.rectangle("line", box.box1.x, box.box1.y, 100, 50)
    love.graphics.print(texto.texto1, box.box1.x, box.box1.y)
    love.graphics.print(texto.texto2, box.box1.x, box.box1.y + textSy)
    love.graphics.print(texto.texto3, box.box1.x, box.box1.y + 2 * textSy)
    love.graphics.print(texto.texto4, box.box1.x, box.box1.y + 3 * textSy)
end

function TelaIntro:drawTextBox2()
    if boxEnterTime <= timeCounter and timeCounter <= 2 * boxEnterTime then
        box.box2.x = box.box2.x - boxSpeed
    end

    love.graphics.print(texto.texto5, box.box2.x, box.box2.y)
    love.graphics.print(texto.texto6, box.box2.x, box.box2.y + textSy)
    love.graphics.print(texto.texto7, box.box2.x, box.box2.y + 2 * textSy)
    love.graphics.print(texto.texto8, box.box2.x, box.box2.y + 3 * textSy)
    love.graphics.print(texto.texto9, box.box2.x, box.box2.y + 4 * textSy)
end

function TelaIntro:drawTextBox3()
    if 2 * boxEnterTime <= timeCounter and timeCounter <= 3 * boxEnterTime then
        box.box3.x = box.box3.x + boxSpeed
    end

    -- love.graphics.rectangle("line", box.box3.x, box.box3.y, 100, 50)
    love.graphics.print(texto.texto10, box.box3.x, box.box3.y)
    love.graphics.print(texto.texto11, box.box3.x, box.box3.y + textSy)
    love.graphics.print(texto.texto12, box.box3.x, box.box3.y + 2 * textSy)
    love.graphics.print(texto.texto13, box.box3.x, box.box3.y + 3 * textSy)
end

function TelaIntro:drawTextBox4()
    if 3 * boxEnterTime <= timeCounter and timeCounter <= 4 * boxEnterTime then
        box.box4.x = box.box4.x - boxSpeed
    end

    love.graphics.print(texto.texto14, box.box4.x, box.box4.y)
    love.graphics.print(texto.texto15, box.box4.x, box.box4.y + textSy)
    love.graphics.print(texto.texto16, box.box4.x, box.box4.y + 2 * textSy)
    love.graphics.print(texto.texto17, box.box4.x, box.box4.y + 3 * textSy)
end

function TelaIntro:drawTextBox5()
    if 4 * boxEnterTime <= timeCounter and timeCounter <= 5 * boxEnterTime then
        box.box5.x = box.box5.x + boxSpeed
    end

    -- love.graphics.rectangle("line", box.box5.x, box.box5.y, 100, 50)
    love.graphics.print(texto.texto18, box.box5.x, box.box5.y)
    love.graphics.print(texto.texto19, box.box5.x, box.box5.y + textSy)
    love.graphics.print(texto.texto20, box.box5.x, box.box5.y + 2 * textSy)
    love.graphics.print(texto.texto21, box.box5.x, box.box5.y + 3 * textSy)
end

function TelaIntro:drawTextBox6()
    if 5 * boxEnterTime <= timeCounter and timeCounter <= 6 * boxEnterTime then
        box.box6.x = box.box6.x - boxSpeed
    end

    love.graphics.print(texto.texto22, box.box6.x, box.box6.y)
    love.graphics.print(texto.texto23, box.box6.x, box.box6.y + textSy)
    love.graphics.print(texto.texto24, box.box6.x, box.box6.y + 2 * textSy)
    love.graphics.print(texto.texto25, box.box6.x, box.box6.y + 3 * textSy)
end

function TelaIntro:drawTextBox7()
    if 6 * boxEnterTime <= timeCounter and timeCounter <= 7 * boxEnterTime then
        box.box7.x = box.box7.x + boxSpeed
    end

    -- love.graphics.rectangle("line", box.box7.x, box.box7.y, 100, 50)
    love.graphics.print(texto.texto26, box.box7.x, box.box7.y)
    love.graphics.print(texto.texto27, box.box7.x, box.box7.y + textSy)
    love.graphics.print(texto.texto28, box.box7.x, box.box7.y + 2 * textSy)
    love.graphics.print(texto.texto29, box.box7.x, box.box7.y + 3 * textSy)
end

function TelaIntro:ativarBotoes()
end

function TelaIntro:desativarBotoes()
end

return TelaIntro