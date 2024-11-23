-- Funções auxiliares

function GetEntityFromFixtures(a, b)
    return a:getUserData(), b:getUserData()
end

function math.round(num)
    return math.floor(num + 0.5)
end