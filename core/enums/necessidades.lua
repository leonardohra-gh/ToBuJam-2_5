local Necessidades = {
    BANHO = "banho",
    BRINCAR = "brincar",
    AGUA = "agua",
    COMIDA = "comida",
    DORMIR = "dormir",
}

function Necessidades:aleatoria()
    local listaNecessidades = {Necessidades.AGUA, Necessidades.BANHO, Necessidades.BRINCAR, Necessidades.COMIDA, Necessidades.DORMIR}
    return listaNecessidades[math.random(5)]
end

return Necessidades