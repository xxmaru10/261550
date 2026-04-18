//Global story tags
# title: Trovadores Viajantes
# frequency: Special
# development: false
# illustration: minstrel


INCLUDE include.ink

->START

===START===
~ PlayMusic("west_bretonnia")
Durante suas viagens, seus ouvidos captam o falatório animado de um grupo de trovadores engajados em uma conversa entusiasmada. Seus trajes vibrantes e gestos enérgicos sugerem uma paixão compartilhada pelo seu ofício. A curiosidade o leva para mais perto e, conforme você se aproxima, a discussão deles flui perfeitamente para uma performance improvisada. #STR_Start1

Cativado por suas vozes harmoniosas, você decide ficar e ouvir. A música dos trovadores tece uma narrativa que transcende meras palavras. O ritmo da canção o atrai para um momento compartilhado, onde as preocupações e incertezas do mundo parecem desaparecer. #STR_Start2

Conforme a performance atinge o clímax, os olhares dos trovadores se cruzam, seus sorrisos refletindo a alegria que encontram em sua troca artística. E então, com uma nota final e triunfante, a canção chega ao fim. #STR_Start3

*[Aplaudir e ovacionar] -> Applaud
*[Expressar sua apreciação] -> Appreciate

===Applaud===
Envolvido pela magia do momento, você se vê aplaudindo junto com a multidão reunida, um reconhecimento silencioso da beleza que todos acabaram de experienciar. #STR_Applaud1
->Leave

===Appreciate===
Com o coração cheio de gratidão, você expressa sua profunda apreciação pela performance dos trovadores. Eles trocam um olhar conhecedor, com sorrisos calorosos e genuínos.
#STR_Appreciate2
->Leave

===Leave===
Com um último aceno de apreço, você deixa os trovadores seguirem sua jornada musical, levando consigo a memória da performance improvisada enquanto retoma seu próprio caminho. #STR_Leave1
(Clicar em "Fim" interromperá a música se ela ainda estiver tocando.) #STR_Leave2
->END
