
local musicIntro = love.audio.newSource("music/Intro.ogg", "stream")
local musicJogo = love.audio.newSource("music/Jogo.wav", "stream")
local TELA = require("enumsGame.Telas")
local Object = require("libs.classic")
local SoundControls = Object:extend()

function SoundControls:updateMusic(tela)
    
    if tela == TELA.INTRO then
        musicJogo:stop()
        musicIntro:play()
    end
    
    if tela == TELA.JOGO then
        musicIntro:stop()
        musicJogo:play()
    end

end

return SoundControls