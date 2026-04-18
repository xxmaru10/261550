//Global story tags
# title: Cultista Infiltrado
# frequency: Special
# development: false
# illustration: village

INCLUDE include.ink
        
    VAR DealtWithCultists = false
    VAR CultName = "Cult of Khorne"
    VAR HardSkillCheckValue = 250
    VAR NormalSkillCheckValue = 150
    VAR EasySkillCheckValue = 80
    VAR ElderState = 0
        ~ ElderState = RANDOM(1,3) // 1 - normal, 2 - guilty, 3 - grumpy
    VAR SymbolLeftBehind = 1
        //~ SymbolLeftBehind = RANDOM(0,1)
    VAR CultIsKnownToPlayer = false
    VAR MassacreHappened = false
    VAR StruggleHappened = false

-> Start

===Start===
    A jornada até a aldeia foi traiçoeira, serpenteando por florestas densas e vales envoltos em névoa. Ao se aproximar, você nota a agitação dos aldeões em suas vidas diárias. No entanto, há uma corrente de inquietação no ar, escondida atrás de sorrisos forçados e sussurros abafados.
    Você deixa seu grupo acampado fora da aldeia e decide iniciar sua investigação discretamente por conta própria. Observando das sombras, você nota um pequeno grupo se reunindo perto da praça da aldeia; o comportamento deles é suspeitamente secreto. Eles trocam olhares codificados e falam em tons baixos.
    ->choices

    =choices
    *[Aproximar-se do grupo e ouvir a conversa. {print_player_skill_chance("Roguery", NormalSkillCheckValue)}]
        {perform_player_skill_check("Roguery", NormalSkillCheckValue): ->ListenToGroup.succeed | -> ListenToGroup.fail}
    *[Coletar informações dos aldeões sem levantar suspeitas.] ->InvestigateVillagers


=== ListenToGroup ===

    =succeed
    (SUCESSO)
    Você se aproxima furtivamente do grupo, cuidadoso para não chamar a atenção. Mantendo distância, você apura os ouvidos para captar trechos da conversa.
    
    "...o ritual de invocação deve ser realizado logo," sussurra uma figura ansiosa. "Nosso poder cresce a cada dia."
    
    Outra voz responde: "Devemos manter nossas verdadeiras identidades ocultas. A Ordem Templária pode estar em nosso encalço. Não queremos caçadores de bruxas por toda a aldeia; se isso acontecer, tudo estará perdido."
    
    "Vamos nos encontrar no Berço esta noite..."
    
    O grupo se dispersa, com cada membro desaparecendo na multidão. Os aldeões continuam suas rotinas diárias, aparentemente alheios à escuridão oculta que espreita em seu meio. 
    ->Start.choices
    
    =fail
    (FALHA)
    Você tenta se aproximar furtivamente do grupo, cuidadoso para não chamar a atenção; no entanto, a furtividade não é o seu forte. Conforme você avança, o rangido súbito de uma tábua alerta o grupo de sua presença. 
    Eles olham em sua direção, os olhos estreitados com suspeita. Trocam algumas palavras rápidas antes de desaparecerem na multidão.
    Sua tentativa de ouvir às escondidas falhou, e você não pode deixar de se perguntar se o seu elemento surpresa acaba de ser comprometido. 
    ->Start.choices


=== InvestigateVillagers ===
    Você percebe que os cultistas são hábeis em esconder suas verdadeiras identidades. Descobrir quem eles são não será uma tarefa fácil. Você decide interagir com os aldeões e coletar mais informações.
    Falando com vários indivíduos, você indaga sutilmente sobre ocorrências estranhas recentes, pessoas desaparecidas ou rumores de práticas sombrias. Alguns aldeões expressam inquietação, falando de símbolos misteriosos gravados em cantos escondidos, desaparecimentos inexplicáveis e luzes estranhas que aparecem na floresta circundante durante a noite.
    ->choices

    =choices
    *[Procurar o ancião da aldeia para interrogatório.] ->InterviewElder
    *[Aventurar-se na mata durante a noite para descobrir a origem das luzes estranhas.] ->Woods
    *[Investigar os desaparecimentos conversando com os parentes dos desaparecidos.] ->InvestigateDisappearances
    * -> OutOfOptions


=== InterviewElder ===
{ElderState == 3: ->grumpy | ->normal}


    =normal
    O ancião, um homem com mais posses se comparado ao estado modesto da aldeia, reside em um chalé confortável perto do centro do vilarejo.
    Ao bater na porta de madeira, o ancião o recebe com um sorriso caloroso. O chalé emana uma sensação de aconchego, com uma lareira crepitante lançando um brilho reconfortante por todo o cômodo. Você se senta perto de uma pequena mesa de madeira, pronto para discutir suas preocupações sobre as ocorrências estranhas na aldeia.
    {ElderState == 1:Ao confrontar o ancião sobre a potencial presença de um culto na aldeia, ele escuta atentamente, mas com uma expressão cética no rosto. Ele descarta a noção de um culto, considerando-a absurda e improvável. Ele acredita que os problemas recentes podem ser atribuídos a meras coincidências ou incidentes isolados.}
    {ElderState == 1:"Eu entendo suas preocupações," diz ele, com a voz tingida por um toque de condescendência. "Mas garanto-lhe que não há culto algum em nossa aldeia. Essas ocorrências estranhas podem ser explicadas por causas naturais ou pela imaginação hiperativa de alguns aldeões."}
    {ElderState == 1:Frustrado pela negação do ancião, você percebe que convencê-lo a agir contra o culto será uma batalha difícil. Está claro que abordagens alternativas precisam ser exploradas para enfrentar a ameaça crescente.}
    {ElderState == 2: Durante a conversa, você observa os arredores, prestando atenção aos sutis indícios da riqueza relativamente elevada do ancião. A prataria brilha à luz suave das velas, as pinturas nas paredes revelam cenas de paisagens serenas e as vestes do ancião exibem um nível de acabamento superior ao do aldeão comum.}
    {ElderState == 2:À medida que a conversa avança, o ancião admite os problemas da aldeia, mas considera a ideia de um culto operando no local simplesmente absurda. No entanto, você sente um lampejo de inquietação em seus olhos, um indício de culpa que revela mais do que suas palavras transmitem.}
    ->choices
    
    =grumpy
    O ancião, um homem conhecido por seu desempenho medíocre em manter a ordem e resolver os problemas da aldeia, reside em um chalé modesto no coração do vilarejo. Ao se aproximar, você nota sinais de negligência nos arredores — jardim mal cuidado, tinta lascada na porta da frente e um ar geral de desordem.
    Você bate na porta de madeira e o ancião a abre com uma expressão levemente exasperada. "O que você quer?" ele resmunga, seu tom refletindo um toque de aborrecimento. Você explica o motivo de sua visita, expressando preocupações sobre as ocorrências estranhas na aldeia e a possível presença de um culto.
    "Você acha que há um culto em nossa aldeia?" ele mofa, com a voz tingida de descrença. "Isso é absurdo! Já temos problemas suficientes na vida cotidiana sem esses contos fantásticos. Problemas? Sim, temos de sobra. Mas um culto? De jeito nenhum."
    Conforme você insiste, tentando convencer o ancião da seriedade da situação, o temperamento dele explode. "Tenho assuntos mais urgentes para tratar do que ouvir tamanha bobagem!" ele dispara, sua frustração palpável. "Se quiser investigar, vá em frente. Mas não venha me incomodar com seus cultos imaginários!"
    Com isso, ele bate a porta na sua cara, e o som ecoa pelas ruas silenciosas da aldeia.
    Sem escolha, você deve encontrar meios alternativos de investigar sem a cooperação do ancião.
    ->InvestigateVillagers.choices
    
    =choices
    *{ElderState == 2}[Confrontar o ancião sobre sua riqueza aparente, acusando-o de atividades ilícitas. {print_player_skill_chance("Charm", HardSkillCheckValue)}]
        {perform_player_skill_check("Charm", HardSkillCheckValue): -> InterviewElder.succeed | -> InterviewElder.fail}
    * -> InvestigateVillagers.choices
    
    =succeed
    (SUCESSO)
    O rosto do ancião se contrai, pego de surpresa pela franqueza de suas alegações.
    Em um momento de vulnerabilidade, o ancião confessa que tem recebido pequenas quantias de dinheiro deixadas anonimamente à sua porta. A origem do dinheiro permanece um mistério para ele, mas admite que fechou os olhos para os eventos estranhos em troca desses subornos. A vergonha preenche sua voz enquanto explica que suas dificuldades financeiras e a tentação de uma vida melhor para sua família haviam obscurecido seu julgamento.
    Ele parece sincero. Você está convencido de que ele realmente não sabe mais nada sobre a origem do suborno.
    Apesar da falta de conhecimento dele, você implora ao ancião que assuma a responsabilidade por suas ações e corte os laços com o benfeitor anônimo. Você enfatiza a importância de restaurar a segurança e o bem-estar da aldeia, instando-o a tornar-se um aliado na luta contra o culto.
    *[Ficar à espreita para a próxima entrega do suborno para seguir a pessoa que o entrega.] -> wait
    *[Encontrar outras maneiras de continuar sua investigação.] -> InvestigateVillagers.choices
    
    =fail
    (FALHA)
     O ancião nega veementemente tais acusações. Com um ar de indignação, ele se defende, alegando que sua situação relativamente melhor é fruto de uma gestão financeira astuta e investimentos feitos fora da aldeia. 
     O ancião desvia habilmente de suas alegações, atribuindo-as a rumores e ciúmes entre os aldeões que invejam seu sucesso modesto. 
     Apesar de suas suspeitas, ele consegue manter uma aparência externa de inocência, deixando-o com dúvidas persistentes sobre suas verdadeiras intenções. 
     ->InvestigateVillagers.choices

    
    =wait
    Determinado a desvendar o mistério por trás do dinheiro do suborno, você elabora um plano para vigiar a casa do ancião e esperar pela próxima entrega. Dias se transformam em noites enquanto você permanece pacientemente escondido, mantendo uma vigilância atenta para qualquer sinal do misterioso entregador. Mas, com o passar do tempo, ninguém chega, e as noites permanecem sem perturbação.
    Cada vez mais frustrado e exausto, você começa a duvidar da eficácia desta abordagem. Talvez o subornador tenha percebido sua presença ou mudado o método de entrega. A falta de pistas ou desenvolvimentos significativos pesa sobre sua determinação.
    Você decide abandonar a vigilância, reconhecendo que esta pista em particular chegou a um beco sem saída.
    -> InvestigateVillagers.choices

===Woods===
    Intrigado pela menção de luzes estranhas na mata, você decide mergulhar nas profundezas da floresta sob o manto da noite. Com seus sentidos aguçados e sua arma pronta, você navega pela folhagem densa.
    
    À medida que avança na floresta, o brilho das luzes torna-se mais intenso e mágico. Ele dança e cintila em padrões que parecem orquestrados, quase intencionais.
    
    Para sua surpresa, você depara-se com vários enxames de vaga-lumes estranhamente grandes, cujos corpos luminescentes criam um espetáculo de tirar o fôlego. Eles esvoaçam e giram em uníssono hipnotizante, iluminando as árvores ao redor com seu brilho encantador.
    
    Percebendo que esses vaga-lumes são a origem das luzes misteriosas, você observa maravilhado enquanto eles continuam sua exibição noturna. Embora não sejam os cultistas que você procurava, a presença deles o lembra da beleza e do encanto que existem no mundo.
    
    Sentindo uma sensação de paz e tranquilidade, você dedica um momento para apreciar a maravilha natural antes de continuar sua investigação.
    ->InvestigateVillagers.choices

===InvestigateDisappearances===
    Sua primeira ação é abordar os parentes dos indivíduos desaparecidos. Você oferece um ouvido compreensivo e apoio enquanto coleta informações discretamente. Cada relato é repleto de angústia e confusão, com fios comuns de circunstâncias inexplicáveis. Rumores sombrios circulam, sussurrando sobre uma força invisível que espreita nas sombras da aldeia.
    Impulsionado por um senso de urgência, você se aprofunda no assunto, buscando pistas e conexões. Você mapeia os locais onde os desaparecimentos ocorreram em um quadro de investigação improvisado. Padrões emergem, indicando uma concentração de incidentes perto da periferia da aldeia e da floresta circundante.
    ->choices
    
    =search
    Com um foco determinado em encontrar respostas, você parte para investigar as casas dos indivíduos desaparecidos, esperando descobrir pistas que possam esclarecer seu sumiço perturbador. Ao entrar em cada casa, uma sensação de tristeza e inquietação preenche o ar, lembrando-o das vidas que foram interrompidas abruptamente.
    Dentro de uma das casas, você encontra sinais de luta — uma cadeira derrubada, um vaso quebrado e pertences espalhados desordenadamente. É evidente que algo errado ocorreu ali, sugerindo uma partida forçada em vez de voluntária.
    Em outra casa, você descobre pertences pessoais deixados para trás — um amuleto querido, uma carta inacabada e um livro favorito. Esses vestígios de suas vidas sugerem a natureza repentina e inesperada de sua partida.
    Torna-se claro que os indivíduos desaparecidos foram vítimas, levados contra sua vontade.
    {SymbolLeftBehind == 1: Enquanto investiga meticulosamente a casa com sinais de luta, seu olhar atento capta algo em meio ao caos — um item deixado para trás pelos perpetradores. Cuidadosamente escondido sob uma mesa tombada, você descobre um amuleto quebrado com uma corrente rasgada, pertencente inequivocamente ao culto que você tem procurado. -> identify_option}
    {SymbolLeftBehind == 0: Apesar de sua investigação minuciosa nas casas das vítimas, você não encontra outras pistas ou avanços significativos. Os sinais de luta e pertences abandonados apenas aprofundam o mistério, deixando-o com mais perguntas do que respostas. Uma sensação de frustração e impotência começa a se instalar ao perceber que a pista esfriou. ->InvestigateVillagers.choices}
    
    =identify_option
    *[Identificar o símbolo. {print_player_attribute_chance("Intelligence", 5)}] -> identify_check
    
    =identify_check
    {perform_player_attribute_check("Intelligence", 5): -> succeed | -> fail}
    
    =succeed
    (SUCESSO)
    ~ CultIsKnownToPlayer = true
    Você reconhece instantaneamente o símbolo distinto do {CultName}.
    Um calafrio percorre sua espinha ao reconhecer a importância do item. É uma peça distinta de parafernália associada ao culto, confirmando o envolvimento direto deles nos desaparecimentos. 
    ->InvestigateVillagers.choices
    
    =fail
    (FALHA)
    Apesar do seu exame minucioso do símbolo, você é incapaz de identificar seu significado ou importância. 
    ->InvestigateVillagers.choices
    
    =choices
    *[Revistar cuidadosamente as casas dos desaparecidos.] -> search


===OutOfOptions===

Depois de perseguir incansavelmente várias pistas e opções, seus esforços renderam pouco progresso na resolução da complexa rede de mistérios que envolve a aldeia. A frustração e o cansaço começam a cobrar seu preço, deixando-o em uma encruzilhada, incerto sobre o melhor caminho a seguir.

Com a mente pesada pelo peso dos enigmas não resolvidos, você se vê diante da taverna da aldeia. O brilho quente de suas janelas e o aroma convidativo de comida o chamam para dentro. Talvez um momento de folga, uma chance de organizar seus pensamentos e reavaliar suas estratégias, seja o que você precisa.

Enquanto você se senta na taverna, contemplando seu próximo passo, um trecho de conversa de um grupo próximo chama sua atenção. Os aldeões estão agitados com a conversa sobre uma reunião planejada para o dia seguinte, uma ocasião rara em que toda a aldeia se reunirá para discutir eventos e preocupações recentes. 

Ouvindo atentamente, você descobre que a reunião ocorrerá na praça da aldeia. A notícia desperta seu interesse, pois apresenta uma chance de observar as reações dos aldeões, avaliar suas suspeitas e talvez vislumbrar quaisquer cultistas que possam tentar se misturar à multidão.

Você não pode deixar de se perguntar sobre as possibilidades que tal evento apresenta. O pensamento de toda a aldeia congregada em um só lugar, incluindo potenciais cultistas, desencadeia uma série de cálculos em sua mente.

Poderiam os cultistas estar planejando agir durante esta reunião? Eles aproveitariam a multidão para avançar sua agenda ou simplesmente observariam das sombras, disfarçando suas verdadeiras intenções?

*[Comparecer à reunião.] -> AttendGathering
*[Desistir da busca. Esta investigação já tomou muito do seu tempo.] -> VoluntaryEnd

=== AttendGathering ===
Conforme o dia da reunião da aldeia chega, uma mistura de antecipação e cautela preenche o ar. Você se dirige à praça da aldeia, com seus sentidos aguçados e sua consciência elevada. A multidão agitada, um mar de rostos familiares, esconde o desconhecido. Enquanto você navega entre os aldeões, permanece vigilante, seu olhar examinando em busca de quaisquer sinais da presença do culto.

De repente, uma mudança sutil na atmosfera chama sua atenção. Uma corrente de tensão ondula pela multidão, e você nota vários indivíduos que parecem fora de lugar — olhares furtivos, expressões contidas. Instintivamente, seus olhos se estreitam em seus movimentos. Suas suspeitas são confirmadas quando você vislumbra o brilho de adagas, escondidas sob suas roupas.

Seu coração acelera quando a gravidade da situação se torna clara. Os cultistas estão entre os aldeões, ocultos e armados. {CultIsKnownToPlayer: Sabendo o que você sabe sobre o {CultName}, torna-se evidente que a | A} intenção deles não é meramente observar; eles planejam atacar, desencadeando o caos e a violência.

Como você procede?

*[Cuidadoso para não causar pânico, tente desarmar os cultistas um por um. {print_player_skill_chance("Roguery", HardSkillCheckValue)}] -> DisarmCultists
*[Expor a verdadeira natureza deles aos aldeões, voltando-os contra os cultistas. {print_player_skill_chance("Charm", HardSkillCheckValue)}] -> ExposeCultists

=== ExposeCultists ===
{perform_player_skill_check("Charm", HardSkillCheckValue): -> succeed | -> fail}

    =succeed
    ~ StruggleHappened = true
    (SUCESSO)
    Reunindo cada grama de determinação, você eleva sua voz acima do caos, suas palavras cortando o medo e a confusão com autoridade. A urgência toma sua voz enquanto você expõe a ameaça oculta dos cultistas, suas adagas escondidas e sua intenção de desencadear a violência sobre os aldeões desprevenidos. 
    
    Choque e descrença reverberam pela multidão enquanto olham para seus amigos e vizinhos, desmascarados como agentes do caos.
    
    Os aldeões, enfurecidos e traídos, voltam-se contra os cultistas, com a confiança estilhaçada. A luta que se segue é breve, mas feroz, com os aldeões impulsionados por um objetivo comum — proteger sua comunidade e livrá-la desta presença malévola.
    
    Em meio ao caos, um punhado de cultistas consegue se soltar das mãos dos aldeões, desaparecendo nas ruas sinuosas que cercam a praça.
    
    O restante é rapidamente superado em número e contido. Conforme a poeira baixa, uma sensação de triunfo e alívio toma conta da praça. 
    ->choices

    =fail
    (FALHA)
    Em meio à reunião da aldeia, você dá um passo à frente, com o coração palpitando com a urgência de sua mensagem. Sua voz sobressai ao falatório, capturando a atenção dos presentes. Você revela a ameaça oculta — a presença de cultistas entre eles, armados e determinados a um ato violento para apaziguar sua divindade sombria. 
    
    Mas à medida que suas palavras pairam no ar, a descrença e o ceticismo ondulam pela multidão como uma pedra lançada em um lago calmo. Olhos se estreitam e sobrancelhas se franzem enquanto os aldeões trocam olhares, alguns até rindo do que percebem como uma história fantasiosa. 
    ->CultistsAct
    
    =choices
    *[Perseguir o cultista em fuga mais próximo.] ->ChaseCultist

===DisarmCultists===
Movendo-se com cautela deliberada, você tece seu caminho entre os aldeões, com movimentos calculados para evitar chamar atenção. Os cultistas estão posicionados estrategicamente perto da borda da multidão e, ao se aproximar do primeiro, seu coração bate forte com uma mistura de medo e propósito.
{perform_player_skill_check("Roguery", HardSkillCheckValue): -> succeed | -> fail}

    =succeed
    (SUCESSO)
    Seus dedos trabalham habilmente ao chegar ao lado do cultista, sua mão movendo-se para desarmar a adaga escondida. A lâmina está fria ao seu toque enquanto você a extrai de sua bainha oculta, com o cultista permanecendo felizmente alheio às suas ações. 
    Seus movimentos são calculados, seus sentidos sintonizados com cada nuance. O peso de cada lâmina retirada é tanto uma vitória quanto um lembrete sombrio da violência que poderia ter ocorrido. 
    Eventualmente, algumas de suas vítimas percebem que algo está errado. Seus olhares se estreitam e um brilho de suspeita surge em seus olhos. O pânico surge em você ao perceber que suas ações não passaram totalmente despercebidas.
    Os cultistas trocam olhares alarmados; a comunicação silenciosa revela uma decisão — eles percebem que o elemento surpresa que esperavam usar desapareceu. Eles começam a abandonar suas posições na multidão e se misturam às ruas labirínticas que cercam a praça.
    ->choices
    
    =fail
    (FALHA)
    Em um instante, seu coração salta uma batida quando o olhar do cultista trava em suas ações. O pânico brilha nos olhos dele, seguido por uma reação rápida. Com uma respiração ofegante, eles tentam arrancar a adaga de suas mãos. O elemento surpresa foi perdido, substituído por uma luta que atrai a atenção dos cultistas próximos.
    ->CultistsAct
    
    =choices
    *[Perseguir o cultista em fuga mais próximo.] ->ChaseCultist

===CultistsAct===
~ MassacreHappened = true
Os cultistas ocultos aproveitam este momento para executar seu plano. Posicionados estrategicamente perto da borda da reunião, eles sacam adagas escondidas e convergem com um propósito sinistro. 
Antes que alguém possa reagir, os cultistas partem para a ação, suas lâminas brilhando à luz do dia. O caos se instala enquanto eles cortam impiedosamente qualquer um em seu caminho. Gritos de horror preenchem o ar enquanto a praça da aldeia se transforma em uma cena de violência pesadela. A eficiência arrepiante dos cultistas e o choque dos aldeões paralisam qualquer chance de fuga imediata.
Em meio ao caos e ao horror que engolem a praça, seus olhos captam algo estranho — padrões emergindo no fluxo de sangue derramado sobre os paralelepípedos. As adagas dos cultistas, empunhadas com uma brutalidade calculada, criam pequenos riachos de carmesim que parecem convergir em caminhos deliberados.
Um calafrio percorre sua espinha ao reconhecer o significado desses padrões — a intenção dos cultistas é muito mais insidiosa do que um mero massacre. O sangue que derramam não é desperdiçado; ele é direcionado para um propósito. Seu ritual sombrio visa canalizar o sangue derramado para as profundezas ocultas sob a praça da aldeia, uma cerimônia macabra para apaziguar sua divindade sedenta de sangue.

*[Reunir alguns aldeões para montar uma defesa com sua liderança.] -> RallyVillagers
*[Temendo por sua própria vida, fuja da cena de horror e abandone esta busca fútil.]
    Conforme o caos horripilante do massacre se desenrola diante de você, seus instintos assumem o controle, impulsionando-o para a ação.
    A adrenalina corre em suas veias enquanto você se afasta da cena de violência. Os gritos dos aldeões ecoam em seus ouvidos, incitando-o a mover-se rapidamente, buscando desesperadamente uma fuga.
    Deixando a aldeia e seus enigmas para trás, você se afasta do caos, da violência e da escuridão que consumiram seus dias.
    ->END

===RallyVillagers===
Em meio ao caos da praça, sua determinação acende uma centelha de ação em você. Com a voz elevada acima da cacofonia, você chama os que estão ao alcance, suas palavras carregando um senso de urgência e autoridade.

"Aldeões, permaneçam juntos!" - com uma voz firme, você ordena que os aldeões construam barricadas usando barracas e mesas próximas e montem uma defesa contra a investida dos cultistas.

A cena horrível na praça se transforma em uma de organização e desafio conforme os aldeões respondem ao seu comando. Suas armas improvisadas, combinadas com as barreiras criadas, formam uma linha defensiva que se apresenta como um desafio formidável às adagas dos cultistas. 

À medida que o avanço dos cultistas encontra essa resistência inesperada, a determinação deles começa a fraquejar. Eles pausam, contidos pela frente unida dos aldeões e pela vantagem estratégica conquistada. Percebem que o elemento surpresa foi frustrado, substituído por uma força desafiadora que eles não haviam antecipado.

Em uma decisão rápida, os cultistas começam a recuar, seus passos retrocedendo enquanto desaparecem de vista.
->choices

    =choices
    *[Perseguir o cultista em fuga mais próximo.] ->ChaseCultist
    
===ChaseCultist===
Impulsionado por uma determinação implacável, você escolhe perseguir os cultistas enquanto eles recuam da praça. As ruas sinuosas e os becos estreitos tornam-se um borrão enquanto você navega pelos caminhos labirínticos, movido por uma sede de respostas e justiça.
Sua perseguição eventualmente o leva a um prédio que se destaca dos demais — uma estrutura abandonada e parcialmente arruinada, marcada pelo tempo e pela negligência. A entrada, escondida por uma cortina de trepadeiras esfarrapadas, sugere a escuridão que reside em seu interior. Os passos dos cultistas diminuem conforme desaparecem por esta entrada sinistra.
Espada em punho, você decide entrar atrás deles.
->EnterHideout

===VoluntaryEnd===
    Com um suspiro pesado, você reconhece que este quebra-cabeça provou ser demais para você, roubando-lhe tempo e paz. Você decide deixar a aldeia à sua própria sorte. Com um último olhar, você se afasta; o peso das perguntas sem resposta e da justiça não cumprida é um fardo que você relutantemente deixa para trás.
->END

===EnterHideout===
~ OpenCultistLairMission("TOR_cultist_lair_001")
...
{DealtWithCultists: Quando o último cultista cai sob o peso de sua lâmina, um silêncio ensurdecedor desce sobre a câmara. O ar está pesado com o cheiro da vitória e os ecos da batalha. Você permanece em meio aos cultistas caídos, a espada em sua mão sendo um testemunho de sua determinação e habilidade inabaláveis.}
{DealtWithCultists && MassacreHappened: Ao sair da câmara subterrânea, seu coração afunda com a visão que o espera na praça da aldeia. O que antes era o coração vibrante do vilarejo agora está transformado em uma cena de horror indescritível. Corpos de aldeões e cultistas jazem pelo chão, suas vidas extintas no confronto violento que ocorreu.}
{DealtWithCultists && MassacreHappened: O sangue mancha os paralelepípedos, transformando o solo em uma tela macabra de tragédia. O ar está carregado com o cheiro de ferro e as sequelas da batalha, um contraste gritante com as festividades que preenchiam a praça momentos antes. Os destroços do confronto, barracas tombadas e mesas estilhaçadas, testemunham o caos que se desenrolou.}
{DealtWithCultists && MassacreHappened: A atmosfera antes animada é substituída por uma quietude sinistra, quebrada apenas pelos sons distantes de soluços e pelos gritos suaves daqueles que sobreviveram. Os aldeões, que haviam se unido a você diante da ameaça dos cultistas, agora lutam contra a realidade brutal de que seus esforços custaram um preço alto.}
{DealtWithCultists && not MassacreHappened && not StruggleHappened: Você emerge do esconderijo e entra na praça, seu coração ainda acelerado pelo confronto com os cultistas. }
{DealtWithCultists && not MassacreHappened && not StruggleHappened: Ao se mover pela multidão, você percebe que suas ações passaram despercebidas. Os aldeões riem e conversam, absortos em suas festividades, alheios à trama sinistra que pairava sobre eles.}
{DealtWithCultists && not MassacreHappened && not StruggleHappened: Você dedica um momento para apreciar o calor e a alegria que preenchem o ar. Crianças brincam, adultos conversam, e a camaradagem dos aldeões é um testemunho de seus laços compartilhados e resiliência. A escuridão que buscava infiltrar-se em suas vidas foi mantida à distância, e suas ações desempenharam um papel crucial na preservação de seu modo de vida.}
 {DealtWithCultists && not MassacreHappened: O culto foi erradicado e a ameaça oculta foi extinta, deixando para trás uma aldeia que pode continuar a prosperar à luz de um novo dia.}
 {not DealtWithCultists: Enquanto você jaz derrotado dentro da câmara oculta, sua respiração ofegante e seu corpo castigado, o peso de sua falha o oprime. As paredes de pedra fria, que testemunharam a violência da batalha, agora parecem se fechar ao seu redor, um lembrete sombrio da escuridão que prevaleceu.}
 {not DealtWithCultists: Em meio ao silêncio de sua derrota, um som distante chega aos seus ouvidos — um coro de passos apressados e vozes elevadas. As tropas do seu grupo, que estavam acampadas fora da aldeia, agora correm em seu auxílio.}
 {not DealtWithCultists: Os cultistas que conseguiram subjugá-lo, tendo se exposto, não estão mais ao seu alcance. Eles escaparam, desaparecendo como fumaça carregada pelo vento, deixando a aldeia para trás.}
 {not DealtWithCultists: O conhecimento de que os cultistas certamente continuarão seu reinado de escuridão em outra aldeia desprevenida é uma realidade dolorosa de aceitar.}
->END
