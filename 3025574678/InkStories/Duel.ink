//Global story tags
# title: A Arte da L�mina
# frequency: Special
# development: false
# illustration: roadpoint2

INCLUDE include.ink

VAR PlayerWin = false
VAR MetBefore = true
    ~ MetBefore = GetPlayerHasCustomTag("MetVittorio")
VAR DeniedBefore = true
    ~ DeniedBefore = GetPlayerHasCustomTag("DeniedVittorio")
    
    ~ SetTextVariable("MetBefore",MetBefore)
    ~ SetTextVariable("DeniedBefore1",DeniedBefore)
    ~ SetTextVariable("DeniedBefore2",DeniedBefore)
    ~ SetTextVariable("MetBefore2",MetBefore)

->START

===START===
Conforme você continua sua jornada por uma estrada sinuosa, os sussurros suaves da brisa acompanham cada passo seu.#STR_Start1
De repente, o som rítmico de passos se aproximando captura sua atenção. Olhando para cima, {not MetBefore: você avista uma figura misteriosa se aproximando com passos confiantes. À medida que se aproxima, o brilho de um florete finamente trabalhado chama sua atenção. O estranho para diante de você, com um sorriso caloroso no rosto enquanto o avalia.}{MetBefore: você avista a figura familiar de Vittorio de Luca, o renomado duelista tileano, caminhando em direção ao seu grupo com passos confiantes. {not DeniedBefore: Memórias de seu encontro anterior retornam, a emoção do primeiro duelo ainda presente em sua mente.}} #illustration: stranger #STR_Start2
{not MetBefore: "Ah, que golpe de sorte encontrar um bando de guerreiros dignos neste caminho solitário," diz ele. "Sou Vittorio de Luca, um mestre da lâmina vindo das terras distantes de Tileia. Viajei por toda parte, buscando um adversário digno que possa igualar minhas habilidades em combate. E agora, o destino me trouxe até você. Gostaria de provar suas habilidades em um duelo amigável, com uma pequena aposta para torná-lo emocionante?"#STR_Start3NotMetBefore} 
{MetBefore: Conforme Vittorio se aproxima, o brilho de seu florete finamente trabalhado chama sua atenção, e um sorriso caloroso se espalha em seu rosto enquanto ele o avalia. "Ah, que sorte nos encontrarmos novamente neste caminho solitário," diz ele, sua voz carregando um tom brincalhão. "Vejo que o fogo de um guerreiro ainda queima em você. {not DeniedBefore: Gostaria de provar suas habilidades mais uma vez em uma revanche?"} {DeniedBefore: Gostaria de provar suas habilidades desta vez?}#STR_Start3MetBefore} 
~ SetPlayerCustomTag("MetVittorio") 
-> choices

=choices
*[Aceitar o desafio.] ->accept
*[Talvez em outra hora. Não temos tempo a perder.] -> deny

=accept
{not MetBefore: Intrigado pela proposta, você retribui o sorriso, curioso sobre os riscos que ele propõe. #STR_AcceptNotMetBefore1}
{not MetBefore: "Um duelo com uma aposta? Estou ouvindo," você responde, aberto à ideia. #STR_AcceptNotMetBefore2}
{not MetBefore: Os olhos do duelista brilham de antecipação enquanto ele explica os termos. "Se você vencer, oferecerei uma soma de 5.000 moedas de ouro como prova de sua habilidade. Caso eu saia triunfante, não peço nada além da honra de ter testado minhas habilidades contra as suas."#STR_AcceptNotMetBefore3}
Com um brilho de excitação nos olhos, você aceita o desafio do duelista e um sorriso determinado cruza seu rosto. "Muito bem," você diz, "eu aceito sua oferta, Vittorio de Luca. Vamos fazer deste duelo um evento para se lembrar {MetBefore: mais uma vez}." #STR_Accept1
Enquanto seus companheiros guerreiros vibram em apoio, você ordena que montem acampamento à beira da estrada, transformando a clareira em uma arena improvisada. #illustration: meadow #STR_Accept2
Com a arena pronta, você caminha para o centro, seu coração batendo forte de antecipação. Seus companheiros guerreiros se reúnem ao redor, formando um círculo para assistir à disputa, com expressões de entusiasmo e orgulho. #STR_Accept3
->enterArena

=deny
~ SetPlayerCustomTag("DeniedVittorio")
A expressão de Vittorio permanece composta, mas um leve sorriso sarcástico brinca nos cantos de seus lábios. #STR_Deny1
"Uma pena," responde ele, sua voz carregada com um toque de condescendência. "Eu esperava encontrar alguém digno do meu tempo, mas parece que os boatos sobre sua proeza foram exagerados." #STR_Deny2
Com um ar de elegância arrogante, Vittorio de Luca encerra o encontro oferecendo uma reverência desdenhosa, seus movimentos exalando uma superioridade inquestionável. #STR_Deny3
->END

=enterArena
~ OpenDuelMission()
...
{PlayerWin: Conforme o tilintar das espadas cessa, os gritos de alegria de seus companheiros guerreiros preenchem o ar, ecoando após sua vitória arduamente conquistada. {SetPlayerCustomTag("DefeatedVittorio")}#STR_PlayerWin1}
{PlayerWin: Você permanece no centro do campo de luta improvisado, com o peito ofegante de esforço e triunfo. Vittorio de Luca, o renomado duelista tileano, estende a mão em um gesto de respeito, com um sorriso genuíno iluminando seu rosto. "Bem lutado," diz ele, sua voz cheia de admiração.#STR_PlayerWin2}
{PlayerWin: A camaradagem entre seu grupo e Vittorio se solidifica enquanto ele graciosamente lhe apresenta 5.000 moedas de ouro, honrando sua aposta e reconhecendo sua habilidade. {GiveGold(5000)}#STR_PlayerWin3} 
{not PlayerWin: Quando o duelo termina, o ar fica pesado com uma mistura de emoções. Seus companheiros guerreiros assistem em silêncio respeitoso enquanto Vittorio de Luca, o renomado duelista tileano, emerge vitorioso da disputa feroz.#STR_PlayerLost1}
{not PlayerWin:Você recua, reconhecendo a habilidade dele com um aceno de admiração. Vittorio permanece no centro do campo de luta improvisado, seu florete brilhando na luz fraca, com um sorriso vitorioso em seu rosto. "Um oponente formidável, de fato," diz ele, sua voz carregando um senso de orgulho em sua conquista. "Você lutou bravamente, mas desta vez, a vitória é minha."#STR_PlayerLost2}
Vittorio de Luca despede-se respeitosamente do seu bando. Seu comportamento gracioso e a elegância de suas palavras permanecem inalterados, independentemente do resultado do duelo. #STR_DuelEnd
->END
