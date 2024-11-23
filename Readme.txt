* Esse template serve para facilitar o desenvolvimento de jogos usando framework LUA. 
* Ele foi feito para ser usado no VSCode, com as extensions: Lua by sumneko e Local Lua Debugger by Tom Blind

Além disso, também foi feito levando em consideração que você já botou a pasta do love (onde tem o arquivo love.exe) na variável "PATH", das variáveis de ambiente.
- Caso não tenha feito isso:
-- Instale o love (caso não tenha instalado): https://love2d.org
-- Vá no menu windows -> na busca, digite: editar variáveis de ambiente
-- No menu que abrir, clique em "variaveis de ambiente"
-- Em "variáveis do sistema" -> Path -> editar -> novo, cole o diretório onde você instalou o Love (geralmente vai ser C:\Program Files\LOVE). Essa pasta tem que ter "love.exe" dentro.
-- Clique em ok pra tudo

- Para fazer o build, é necessário instalar o makelove
-- Instale o python (https://www.python.org/downloads/)
-- Depois de instalado, abra o prompt de comando
-- digite pip3 install makelove 

Essas configurações vão habilitar o auto-complete para LÖVE e facilitar o run, build e debug de jogos criados em love.

Caso você tenha pego esse template de algum lugar e está confuso, aqui vou explicar para que serve cada coisa:

.vscode/launch.json: 
Vamos configurar como o visual studio code se comporta quando vamos "rodar" a aplicação, seja em Run ou Debug. Basicamente o arquivo diz "Quando rodarmos (launch) pelo debug (inseto verde), rode o comando 'love . debug' (executar 'love' na pasta atual, passando 'debug' como argumento)  e quando rodarmos pelo play (seta verde), rode o comando 'love .' (executar 'love' na pasta atual)"

.vscode/settings.json:
Aqui estamos definindo que vamos usar o LuaJIT (Lua Just In Time) para rodar o nosso projeto, e avisando para o vscode que existem 2 variáveis globais a serem utilizadas, "love" e "lldebugger" para ele não nos dar esse warning quando usarmos elas. Também estamos definindo para o vscode que vamos usar uma biblioteca chamada "love2d", para que ele nos dê um autocomplete de funções.

.vscode/tasks.json:
No tasks.json a gente prepara nosso processo de build. Basiacmente vamos definir que, quando fizermos build (ctrl + shift + B), ele vai chamar o comando "makelove --config make_all.toml", que é o comando que cria uma pasta "bin" com os executáveis do jogo zipados a depender do Sistema Operacional.

make_all.toml:
Basicamente o arquivo de configuração do build, quando executarmos o build, queremos buildar para windows 32 e 64 bits e MacOS, jogando o resultado para a pasta "bin".

main.lua:
Arquivo principal onde o jogo vai rodar. 
* No topo temos uma condicional, que se estivermos passando "debug" como parâmetro, vamos usar a biblioteca de debug do love (lldebugger).
* No final, temos uma configuração de como lidar com erros. Se tivermos em debug (usando lldebugger), o vscode vai pular pra linha e mostrar o erro

Atenção, isso pode deixar o jogo lento em debug, caso tenha break points no jogo


Resumindo, podemos:
- Rodar como debug (para parar em breakpoints)
- Rodar como release (para ver sem breakpoints)
- Buildar o jogo, criando um executável zipado, com ctrl + shift + B
- Programar com autocomplete do Lua e LÖVE