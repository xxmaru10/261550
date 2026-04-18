//Global story tags
# title: A Vila Pesteada
# frequency: Special
# development: false
# illustration: village

INCLUDE include.ink

VAR EXTREMESKILLCHECK = 1500
VAR NORMALSKILLCHECK = 150
VAR EASYSKILLCHECK = 50
VAR found_vial = false
VAR suspicious = false
VAR found_passage = false
VAR met_healer = false
VAR found_age = false
VAR DealtWithCultists = false
VAR MadeDealWithCultists = false

->START


===START===
Você deixa seu grupo acampado na orla da vila e decide entrar sozinho, vestindo roupas simples de camponês para evitar atenção. Ao pisar na vila, um fedor repugnante agride seus sentidos. O ar está pesado com o cheiro de decomposição, misturado ao odor persistente do desespero. Ruas estreitas e desertas serpenteiam entre edifícios em ruínas, suas fachadas desgastadas e castigadas pelo tempo e pela negligência. Os aldeões, antes vibrantes e cheios de vida, agora se arrastam como espectros assombrados, sua vitalidade extinta pelo aperto implacável de uma peste desconhecida.

Uma névoa doentia cobre a vila, lançando um aspecto pálido sobre tudo o que toca. Portas rangem em dobradiças enferrujadas, suas cores antes vivas agora desbotadas e descascando. Janelas fechadas traem o medo que reside em seu interior, como se os aldeões tivessem se trancado para longe do mundo. Aqui e ali, lanternas tremeluzentes lançam uma luz fraca sobre símbolos desesperados de proteção rabiscados nas paredes — sigilos rudes gravados em sangue e cinzas, tentativas fúteis de afastar o contágio.

Em meio à desolação, algumas figuras desafiam a investida implacável da doença. Elas se movem com propósito, seus olhos abrigando um lampejo de resiliência. Estes sobreviventes lançam olhares cautelosos, seus corpos intocados pela aflição que devastou seus vizinhos. Sua existência, como brasas frágeis em meio à escuridão invasora, sugere uma esperança remanescente para a vila. -> choices

    =choices
    *[Buscar informações com os aldeões.] -> QuestionVillagers
    *[Caminhar pela vila observando cuidadosamente os arredores.] -> ObserveVillage
    *{suspicious}{not found_age} [Perguntar por aí sobre o curandeiro.] -> AskAboutHealer
    *{found_vial || (found_age && met_healer)}[Tirar um momento para organizar seus pensamentos e revisar suas descobertas.] -> GatherThoughts


===QuestionVillagers===
Ao se aproximar de uma figura solitária entre os aldeões exaustos, os olhos dela brilham com uma centelha de resiliência. Intrigado, você faz a pergunta que pesa em sua mente, questionando sobre a peste. 
Com uma expressão fatigada, o aldeão responde em voz baixa: "A peste... ela tem nos assombrado há meses. Tantas vidas perdidas, tanto sofrimento suportado." Sua voz carrega o peso de sua experiência pessoal, refletindo a angústia coletiva que permeia o ar. 
Ele aponta para a moradia do curandeiro da vila, reconhecendo sua dedicação inabalável diante do desespero, e diz: "Procure o curandeiro. Ele se tornou nosso farol de esperança, lutando incansavelmente contra esta aflição implacável." ->choices 

    =choices
    *{not met_healer}[Seguir o conselho e procurar o curandeiro da vila.] -> AtTheHealers
    *{met_healer}[Voltar à moradia do curandeiro esperando encontrá-lo desta vez.] -> AtTheHealers

===AskAboutHealer===
Você decide investigar discretamente sobre o curandeiro entre os aldeões. Ao iniciar conversas, você nota um tema comum nas respostas — o curandeiro tem sido um pilar da vila desde que qualquer um consiga se lembrar. Gerações confiaram em sua perícia, seu conhecimento passado de uma era para a outra.
"Ah, o curandeiro? Ele está conosco desde que me entendo por gente", diz um aldeão idoso, com uma nota de reverência na voz. "Sua sabedoria e remédios salvaram incontáveis vidas; até meu avô buscou sua ajuda."
Outro aldeão acrescenta: "Sim, eu era apenas uma criança quando o vi pela primeira vez, e isso foi há muitos decênios. Ele permaneceu uma presença constante, oferecendo conforto aos doentes e esperança aos desesperados."
As palavras dos aldeões soam estranhas para você, pois se os relatos forem verdadeiros, o curandeiro teria mais de noventa anos, mas a última vez que você o viu, ele não parecia ter mais de cinquenta. A dúvida rói os cantos da sua mente, como se a própria realidade tivesse se distorcido dentro desta vila esquecida.
~found_age = true
->START.choices

===AtTheHealers===
~met_healer=true
Ao entrar na moradia do curandeiro, uma cena se desenrola diante de seus olhos que tanto cativa quanto inquieta. A sala está repleta de pacientes, seus rostos pálidos marcados pelos estragos da peste. Alguns jazem em catres, contorcendo-se de dor, enquanto outros sentam-se em cadeiras, esperando ansiosamente por sua vez de receber tratamento. 

O curandeiro move-se pela sala, seus movimentos graciosos, mas decididos. Ele oferece palavras suaves de conforto, seu toque é gentil e seguro. Prateleiras que revestem as paredes sustentam o peso de incontáveis frascos, potes e instrumentos médicos. A luz tremeluzente das velas projeta sombras sinistras, revelando vislumbres da dedicação do curandeiro e das ferramentas de seu ofício.

Em meio à variedade de ervas medicinais e poções, seu olhar pousa em algo que parece fora de lugar — um frasco curioso com um líquido escuro e viscoso que se destaca dos demais. -> choices 

    =choices
    *[Examinar o frasco curioso. {print_player_skill_chance("Medicine", EASYSKILLCHECK)}]
        {perform_player_skill_check("Medicine", EASYSKILLCHECK): -> succeed | -> fail}
    *[Perguntar ao curandeiro sobre o frasco.] -> inquire
    *{found_vial}[Confrontar o curandeiro.] -> ConfrontHealer
    *{found_vial}[Decidir guardar a descoberta para si e continuar sua investigação.] -> START.choices
    *[Sair.] -> START.choices

    =succeed
    Ao examinar o frasco com um crescente sentimento de alarme, seu olhar treinado reconhece o conteúdo pelo que ele realmente é — um agente insidioso do contágio, uma substância potente e vil que alimenta a própria peste que consome a vila.
    ~found_vial = true
    ->choices
    
    =fail
    Ao examinar o frasco com uma expressão perplexa, você não consegue identificar seu propósito ou conteúdo, carecendo do conhecimento médico necessário para discernir sua verdadeira natureza. -> choices

    =inquire
    Você direciona seu olhar para o curandeiro e pergunta diretamente sobre o frasco peculiar. 
    "Qual é o propósito deste frasco? Seu conteúdo parece diferente de qualquer remédio que já encontrei", você questiona, seu tom mesclando curiosidade e cautela. 
    O curandeiro encontra seu olhar, seus olhos piscam brevemente com inquietação antes de responder em voz tranquilizadora: "Ah, esse frasco contém um extrato potente de uma erva rara — um ingrediente chave em um poderoso desinfetante. Ele ajuda a conter a propagação da doença, garantindo a segurança tanto dos aflitos quanto dos saudáveis." Suas palavras são acompanhadas por um sorriso calmo, mascarando qualquer apreensão subjacente. 
    ~suspicious = true
    -> choices

===ObserveVillage===

Você caminha pelas ruas desoladas, seus olhos escaneando atentamente os arredores em busca de qualquer sinal que possa revelar a verdade por trás da peste e dos boatos de atividade de cultistas. Entre os edifícios em ruínas e os habitantes sofridos, você nota detalhes sutis que despertam seu interesse.

Um sigilo desbotado gravado em uma parede em ruínas chama sua atenção. Ele se assemelha a símbolos associados ao deus do caos Nurgle, sugerindo uma possível conexão com os boatos de cultistas. Ao ver a peste, você já suspeitava disso, mas sua presença isolada não é suficiente para confirmar a verdade.

Em meio à desolação, você nota um padrão peculiar. Seus olhos são atraídos por certos indivíduos que desafiam a aflição que assola o restante. Homens de meia-idade, entre trinta e quarenta anos, que exalam um nível extraordinário de saúde e vitalidade. Seus portes robustos e musculosos contrastam fortemente com as figuras frágeis e emaciadas que os cercam. Suas bochechas ostentam um rubor saudável, brilhando com vitalidade, enquanto seus olhos brilham com resiliência e força. Sua própria presença parece irradiar vida em meio à melancolia.

Você não pode deixar de ficar impressionado com o bem-estar deles. Sua saúde excepcional levanta questões em sua mente — o que lhes concede essa resiliência extraordinária? Existe uma explicação natural, ou poderia haver algo mais por trás de sua aparente invulnerabilidade? -> choices

    =choices
    *[Observar a rotina diária dos aldeões saudáveis.] -> ObserveRoutine

===ObserveRoutine===
Intrigado pela saúde extraordinária dos homens de meia-idade na vila, você decide observar sua rotina diária ao longo de alguns dias. Sua investigação leva a uma descoberta fascinante — toda manhã, sem falta, os aldeões saudáveis se reúnem na humilde moradia do curandeiro da vila.
Isso desperta sua curiosidade, pois eles não parecem precisar de nenhum tratamento, no entanto, passam um tempo considerável lá dentro. -> choices
    
    =choices
    *[Decidir entrar na moradia do curandeiro enquanto a maioria dos aldeões saudáveis estiver lá dentro.] -> AtTheHealersAgain

===AtTheHealersAgain===
Com a curiosidade falando mais alto, você decide aproveitar a oportunidade e entrar na moradia do curandeiro {met_healer: novamente} quando os aldeões saudáveis estão reunidos lá dentro. No momento em que você passa pela porta, uma visão estranha o saúda. O abrigo do curandeiro está mal iluminado, repleto do cheiro de ervas e incenso. De um lado da sala, alguns aldeões jazem em péssimas condições, gemendo de dor, seus corpos devastados pela peste. 
Mas não há sinal do curandeiro ou dos aldeões saudáveis que você acabou de ver entrando momentos atrás.
~suspicious = true
->choices

    =choices
    *[Procurar por alguma pista de onde eles possam ter desaparecido. {print_player_skill_chance("Scouting", EASYSKILLCHECK)}]
        {perform_player_skill_check("Scouting", EASYSKILLCHECK): -> succeed | -> fail}
    *{found_passage}[Sem hesitação, você desce para o subterrâneo.] -> Descend
    *{not found_passage}[Desistir da busca e sair.] -> START.choices

    =succeed
    Seus olhos varrem a sala, procurando por qualquer pista que possa explicar seu desaparecimento repentino. Prateleiras revestem as paredes, adornadas com frascos, garrafas de poções e tomos antigos sobre várias práticas medicinais. A sala parece estranhamente tensa, como se guardasse um segredo esperando para ser desvendado.
    Enquanto você explora cautelosamente, uma passagem oculta chama sua atenção, escondida atrás de uma tapeçaria pesada. Instintivamente, você se aproxima, seu coração batendo forte em antecipação. A passagem parece levar ao subterrâneo, em direção a uma escuridão desconhecida que o convida a descobrir seus segredos.
    ~found_passage=true
    ->choices
    
    =fail
    Seus olhos varrem a sala, procurando por qualquer pista que possa explicar seu desaparecimento repentino. Você inspeciona meticulosamente cada canto e fresta, passando as mãos pelas prateleiras e paredes, tentando encontrar uma passagem secreta. No entanto, por mais que procure, não parece haver uma maneira óbvia de desvendar o mistério.
    À medida que a frustração e a perplexidade começam a tomar conta, você não pode deixar de se sentir estupefato com a situação. O curandeiro e os aldeões saudáveis parecem ter desaparecido sem deixar rastros, deixando-o com mais perguntas do que respostas. Poderiam eles ter sentido sua presença e escapado sem serem notados? ->choices

===GatherThoughts===
Você encontra um momento de pausa para organizar seus pensamentos. Você se retira para um canto silencioso da vila, longe de olhares curiosos, e revisa meticulosamente as evidências acumuladas até agora.
Os aldeões saudáveis, aparentemente intocados pela peste, continuam a se destacar como um enigma. Sua saúde robusta, energia vibrante e imunidade inexplicável confundem a lógica. Eles são a própria personificação da vida em meio ao desespero que consome a vila.
No entanto, sua associação com o curandeiro levanta mais perguntas do que respostas. Se o curandeiro de fato tem cuidado da vila por gerações, ele deveria ser um homem idoso e frágil, mas isso está longe da verdade. A última vez que você o encontrou, ele parecia ser um homem no auge de sua vida, desafiando a passagem do tempo.
A descoberta do símbolo de Nurgle gravado em uma parede em ruínas sugere uma conexão possível com os boatos de cultistas. A presença de tal símbolo na vila lança uma sombra sinistra sobre sua atmosfera já sombria. 
Além disso, o frasco suspeito que você encontrou na moradia do curandeiro martela em seus pensamentos. {not found_vial: Seu conteúdo permanece não identificado, e a explicação do curandeiro levanta dúvidas sobre seu verdadeiro propósito. Poderia ser um agente do contágio, ou é genuinamente um remédio inocente como alegado?}{found_vial: Você tem certeza absoluta de que o conteúdo do frasco é usado para alimentar a epidemia. Quanto ao propósito? Isso ainda resta ser visto.}
Uma suspeita arrepiante cria raízes em sua mente. Poderia ser que o próprio curandeiro esteja de alguma forma ligado à peste e aos boatos de cultistas? Existe algo clandestino escondido sob a superfície de sua fachada benevolente? Com determinação renovada, você finalmente decide confrontar o curandeiro.
->ConfrontHealer

===ConfrontHealer===
{came_from(-> GatherThoughts): Impulsionado pela determinação, você entra na moradia do curandeiro mais uma vez, seus olhos aguçados por seus novos conhecimentos.} Ao se aproximar, os olhos do curandeiro encontram os seus. Há um momento de reconhecimento silencioso — a percepção de que a verdade foi descoberta.
Sentindo o peso de suas suspeitas, o rosto do curandeiro se contorce com uma mistura de medo e desespero. Sem uma palavra, ele se vira e corre em direção ao fundo da sala, em uma tentativa desesperada de escapar de seu escrutínio.
"Espere!" você grita, perseguindo-o enquanto ele alcança o fundo da moradia. Em um movimento rápido, ele revela um alçapão oculto, escancarando-o e desaparecendo nas profundezas abaixo. Você não hesita, seguindo logo atrás, descendo os degraus estreitos em direção à escuridão desconhecida. -> choices
    
    =choices
    *[Sem hesitação, você o segue, descendo os degraus estreitos rumo à escuridão desconhecida.] -> Descend
    

===Descend===
~ OpenCultistLairMission("TOR_quest_nurgle_lair_001")
...
{MadeDealWithCultists && not DealtWithCultists: Os olhos do líder do culto brilham com uma mistura de triunfo e satisfação ao sentir sua aquiescência. Seu cântico assume uma qualidade hipnótica, ressoando dentro de seu ser como se tecesse uma conexão irrevogável. A sensação que o envolve é estranha e inquietante, como se uma força de outro mundo começasse a se entranhar em sua própria essência. }
{MadeDealWithCultists && not DealtWithCultists: Uma transformação inefável começa, como o desenrolar de um sonho tecido a partir da realidade. Um surto de energia percorre suas veias, revigorando seu corpo e banindo o cansaço. Dores e feridas parecem cicatrizar, deixando para trás uma sensação renovada de vitalidade.}
{MadeDealWithCultists && not DealtWithCultists: Com a Dádiva aceita, você deixa a câmara, o peso de sua decisão pairando pesadamente sobre você. A vila recua na distância, os gritos abafados de seus residentes aflitos ecoando em seus ouvidos enquanto você se afasta.}
{MadeDealWithCultists && not DealtWithCultists: Sua jornada continua, assombrada pelos ecos de sua decisão. A Dádiva de Nurgle concedeu-lhe força e vitalidade, mas também o vinculou a um futuro incerto e tingido de remorso.}
{not DealtWithCultists && not MadeDealWithCultists: Seus golpes são repelidos e suas defesas tornam-se inúteis. A proeza maléfica do líder do culto está além de qualquer coisa que você antecipou e, com um golpe final e devastador, sua força lhe falha. A escuridão toma conta de seus sentidos enquanto a consciência se desfaz no esquecimento.}
{not DealtWithCultists && not MadeDealWithCultists: Horas, ou talvez uma eternidade depois, você desperta em meio ao clamor dos aflitos. Seu corpo dói, quebrado e castigado, os ecos de sua derrota ressoando através de cada fibra do seu ser. Desorientado e ferido, você se encontra entre os mesmos aldeões que buscou salvar.}
{not DealtWithCultists && not MadeDealWithCultists: Rastejando debilmente pela desolação, você navega pela paisagem de almas sofredoras, cada gemido e suspiro um testemunho do aperto implacável da peste. A percepção de seu fracasso pesa sobre você, o gosto da derrota amargo em sua língua.}
{not DealtWithCultists && not MadeDealWithCultists: Eventualmente, você consegue escapar da cena deplorável, seu corpo quebrado guiando-o de volta ao acampamento onde seu grupo se refugiou. Os olhos de seus camaradas encontram os seus, cheios de uma mistura de preocupação e empatia, ao compreenderem a extensão de sua derrota.}
{not DealtWithCultists && not MadeDealWithCultists: Sem dizer uma palavra, você reúne o que resta de sua força e determinação, deixando para trás a vila e sua população torturada. A memória de seu confronto com o líder do culto, seu fracasso em deter a peste, assombra cada um de seus passos.}
{not DealtWithCultists && not MadeDealWithCultists: Ao partir, a vila desaparece de vista, seu legado de sofrimento para sempre gravado em sua mente. O peso da derrota pressiona você, um lembrete indelével da escuridão que você foi incapaz de dissipar.}
{DealtWithCultists && not MadeDealWithCultists: A derrota do líder do culto reverbera pelo covil subterrâneo, seu impacto alcançando o próprio coração da vila assolada pela peste acima. Ao sair, você é recebido pela visão dos aldeões aflitos emergindo de seus casebres, suas expressões uma mistura de incredulidade e uma esperança recém-descoberta.}
{DealtWithCultists && not MadeDealWithCultists: A vila começa a se curar, seus residentes recuperando-se lenta mas confiavelmente do tormento que antes os prendia. Conforme seu grupo se reúne a você, seus rostos refletem a gratidão coletiva da vila.}
{DealtWithCultists && not MadeDealWithCultists: Com sua missão cumprida, você parte da vila, deixando para trás uma comunidade no caminho da recuperação. A memória de sua vitória, da batalha contra as trevas, permanece gravada nos corações dos aldeões como um testemunho da força do espírito humano.}

->END
