//Global story tags
# title: Fortaleza de Fozzrik
# frequency: Uncommon
# development: false
# illustration: castle

INCLUDE include.ink

-> Start

=== Start ===
Sua jornada através da natureza selvagem e indomável o leva à borda de uma floresta densa. Emergindo entre as árvores, você se depara com uma visão magnífica e misteriosa — uma cidadela imponente que parece desafiar as próprias leis da natureza. #STR_Start1

Ao se aproximar da base da cidadela, seus olhos percorrem os entalhes intrincados que adornam suas paredes, cada um contando uma história de eras passadas. Pináculos imponentes, coroados por ventos rodopiantes de magia, erguem-se em direção aos céus, uma exibição de poder e elegância. É um castelo diferente de qualquer outro, mantido suspenso por um artifício mágico há muito esquecido pela maioria, cobiçado por imperadores e reis em todas as terras. A Fortaleza Voadora é uma maravilha a ser contemplada — um monumento aos sonhos de um mago que ganhou forma sólida. #STR_Start2

Que caminho você seguirá? #STR_Start3

* [Investigar a cidadela mais de perto.] -> InvestigateCitadel
* [Continuar viagem.] -> ContinueOn

=== InvestigateCitadel ===
A curiosidade o compele a se aproximar, seus passos ecoando na presença da cidadela imponente. Antes que possa se aproximar, um espetáculo extraordinário se desenrola diante de seus olhos. A arquitetura da cidadela ganha vida, respondendo a uma força enigmática que parece emanar de seu interior. #STR_InvestigateCitadel

Paredes de pedra dobram-se sobre paredes de pedra. A grandiosidade da cidadela diminui a cada dobra graciosa, sua estrutura imponente transformando-se em uma fração de seu tamanho anterior. Em questão de momentos, o que antes era uma fortaleza monumental agora se reduz a uma mera semelhança de si mesma — uma visão que o deixa paralisado. #STR_InvestigateCitade2

Ao chegar ao local onde a cidadela antes ficava, resta apenas um espaço vazio, como se a própria terra a tivesse engolido por inteiro. Uma mistura de temor e perplexidade preenche seu coração, instando-o a compreender os mistérios do fenômeno mágico em ação. #STR_InvestigateCitade3

* [Usar seu conhecimento de magia para detectar o que há de único na fortaleza. {print_party_skill_chance("Spellcraft", 200)}]-> SpellcraftCheck
* [Ignorar este fenômeno.]-> DismissPhenomenon

=== SpellcraftCheck ===
{perform_party_skill_check("Spellcraft",200): -> success | -> fail}

    =success
    (SUCESSO)
    Recorrendo ao seu conhecimento de magia, você tenta decifrar o que realmente está acontecendo. Então, a percepção o atinge. As lendas de Fozzrik, o enigmático arquiteto mago, ressoam com o que você presenciou. #STR_SpellcraftCheckSuccess1
    
    A cidadela que você encontrou, agora desaparecida, alinha-se perfeitamente com os contos das impressionantes Fortalezas Voadoras de Fozzrik. Essas grandes construções podiam dobrar-se em formas compactas, desafiando a lógica enquanto se transformavam em objetos tão pequenos quanto um baú, ou expandir-se em cidadelas imponentes à vontade. Seu insight perfura o misticismo, revelando o funcionamento da arte de Fozzrik. #STR_SpellcraftCheckSuccess2
    
    Com uma nova compreensão, você segue em frente, seu conhecimento sobre a natureza da cidadela iluminando seu caminho na natureza selvagem. #STR_SpellcraftCheckSuccess3
    -> END
 
    =fail
    (FALHA)
    Ao forçar sua mente para desvendar os segredos da cidadela desaparecida, você se encontra em um impasse. Os meandros deste trabalho permanecem envoltos em enigma, esquivando-se de suas tentativas de compreensão. O desaparecimento da cidadela serve como um testemunho da natureza insondável das artes mágicas, deixando-o com um sentimento persistente de curiosidade tingido de frustração. Apesar de seus melhores esforços, o enigma desta arquitetura permanece sem solução, um mistério que se junta às fileiras de inúmeros outros enigmas no mundo. #STR_SpellcraftCheckFail1
    -> END

=== DismissPhenomenon ===
Embora o desaparecimento da cidadela o deixe perplexo, você escolhe deixar de lado o enigma e focar em prosseguir sua jornada. Sabe-se que os mistérios escapam até mesmo às mentes mais astutas, e ponderar sobre eles pode desviá-lo de seus objetivos. #STR_DismissPhenomenon1


-> END

=== ContinueOn ===
Com a memória da cidadela desaparecida gravada em sua mente, você retoma suas viagens. #STR_ContinueOn1

Enquanto prossegue, o legado da fortaleza perdura, um testemunho da fusão de magia e arquitetura que desafia a percepção comum neste mundo. #STR_ContinueOn2

* -> END

