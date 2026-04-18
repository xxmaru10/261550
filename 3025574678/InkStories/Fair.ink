//Global story tags
# title: A Feira na Floresta
# frequency: Uncommon
# development: false
# illustration: trader

INCLUDE include.ink

VAR HorsePrice = 2000
VAR FoodPrice = 10
VAR HorseBetPrice = 500
VAR HorseBetPayout = 2500
VAR WinHorseRace = 0
    ~ WinHorseRace = RANDOM(0,1)
VAR TurnipPrice = 50

-> Start

===Start===




Enquanto seu exército viaja, uma clareira repentina revela uma visão surpreendente — uma feira agitada conhecida como a Folia de Morrslieb. Tendas erguem-se orgulhosas, cores dançando sob a luz do sol filtrada pelas árvores. Risos misturam-se aos bufos dos cavalos, o coração desta reunião alegre. #STR_Start1

Mercadores acenam, seus olhos brilhando de travessura, vendendo cavalos com desconto em relação às taxas padrão que você encontraria nos pergaminhos. O ar carrega os aromas tentadores de carne assada, cerveja espumante e vinho encorpado. Em meio à multidão festiva, um fazendeiro sorri, oferecendo um nabo que estranhamente se assemelha ao famoso cometa de duas caudas. Seu por apenas um centavo, uma chance de possuir esta curiosa maravilha. #STR_Start2
    ->choices

    =choices
    * [Juntar-se à multidão no mercado de cavalos.]->HorseStalls 
    * [Saborear os sabores da feira.]->FoodStalls
    * [Testar sua sorte nas corridas de cavalos.]->HorseRaces
    * [Examinar o nabo peculiar.]->Turnip
    * [Continuar sua jornada pela floresta.]->Leave

===HorseStalls===
O coração da feira bate mais forte no mercado de cavalos. Garanhões orgulhosos empinam, seus olhos ferozes e selvagens. Um cavalo, em particular, captura sua atenção. Ele tem uma pelagem de ébano lisa que brilha sob a luz do sol, e seus olhos parecem conter um brilho conhecedor. #STR_HorseStalls1
    ->choices

    =choices
    + [Aceitar o acordo do mercador pelo cavalo. ({HorsePrice} moedas de ouro)]->BuyHorse
    * [Persuadir o mercador a baixar o preço. {print_player_skill_chance("Charm",150)}]->PersuadeMerchant
    * [Retornar ao coração da feira.]->Start.choices

===BuyHorse===
{HasEnoughGold(HorsePrice): Você fecha negócio com o mercador. Você troca moedas por uma sela resistente e rédeas. Com uma onda de antecipação, você monta no cavalo. A conexão entre vocês é imediata; o cavalo parece responder ao seu toque com confiança e entusiasmo. {GiveGold(-HorsePrice)} {GiveItem("t2_empire_horse",1)} | Você não tem ouro suficiente. #STR_BuyHorse1NOTENOUGHGOLD }  #STR_BuyHorse1

* [Retornar à folia]->Start.choices

===PersuadeMerchant===
{perform_player_skill_check("Charm",150): -> success | -> fail}

    =success
    Suas palavras fazem mágica e o mercador concorda em baixar o preço em 50%. O mercador resmunga, mas respeita suas habilidades de negociação. #STR_PersuadeMerchant_Success
    ~HorsePrice = 1000
    ->HorseStalls.choices

    =fail
    Apesar de suas melhores tentativas de pechinchar, o mercador permanece firme no preço. #STR_PersuadeMerchant_Fail
    ->HorseStalls.choices
    

===FoodStalls===
Aromas giram e tentam, guiando você para um banquete de sabores. Carnes chiam e a cerveja espuma — um carnaval para os sentidos. Há comida abundante disponível, e a escolha de participar é sua. #STR_FoodStalls1

* [Deliciar-se com o banquete da feira. ({FoodPrice} moedas de ouro)]->BuyFood
* [Seguir adiante, resistindo à tentação.]->Start

===BuyFood===
{HasEnoughGold(FoodPrice): A indulgência vence. Você banqueteia, os sabores da feira são uma sinfonia deliciosa em sua língua. Mercadores acenam em aprovação enquanto você participa. {GiveGold(-FoodPrice)} | Você não tem ouro suficiente. #STR_BuyFood1NOTENOUGHGOLD}#STR_BuyFood1

* [Retornar à diversão.]->Start.choices

===HorseRaces===
Gritos de alegria irrompem de um anfiteatro. Cavalos trovejam, cavaleiros instando-os à glória. #STR_HorseRaces
->choices

    =choices
    * [Fazer uma aposta em um cavalo de corrida. ({HorseBetPrice} moedas de ouro — pagamento de 5x em caso de vitória)]->PlaceBet
    * [Você decide que não deve testar sua sorte.]->Start.choices

===PlaceBet===
{not HasEnoughGold(HorseBetPrice): Você não tem ouro suficiente. #STR_PlaceBet_NOTENOUGHGOLD -> HorseRaces.choices } 
~GiveGold(-HorseBetPrice)
{WinHorseRace: ->success | ->fail}
    =success
    Seu coração acelera ao fazer sua aposta. O cavalo que você escolheu avança impetuoso, e a sorte dança a seu favor. Risos e o tilintar de moedas cercam você. #STR_PlaceBet_Success
    ~ GiveGold(HorseBetPayout)
    * [Retornar à multidão de foliões.]->Start.choices

    =fail
    Seu coração acelera ao fazer sua aposta. O cavalo que você escolheu avança rápido no início, mas os outros cavaleiros logo o alcançam. Eventualmente, seu cavalo diminui o ritmo a ponto de conquistar apenas uma posição tardia. Risos e o tilintar de moedas cercam você.
        #STR_PlaceBet_Fail
    * [Retornar à multidão de foliões.]->Start.choices

===Turnip===
A intriga aguça seus sentidos enquanto você contempla o nabo em forma de cometa — uma maravilha excêntrica. Um fazendeiro sorri, convidando-o a participar de uma rifa. #STR_Turnip1
    ->choices

    =choices
    * [Tentar a sorte com um bilhete de rifa. ({TurnipPrice} moedas de ouro)]->BuyTicket
    * [Usar sua percepção para encontrar pistas escondidas sobre o nabo. {print_player_skill_chance("Roguery", 80)}]->PerceiveTurnip
    * [Seguir em frente, deixando o curioso nabo para trás.]->Start.choices

===BuyTicket===
{HasEnoughGold(TurnipPrice): Com uma moeda e um sorriso, você garante sua chance na rifa. Quem sabe? O nabo beijado pelo cometa pode ser seu, afinal. {GiveGold(-TurnipPrice)} | Você não tem ouro suficiente. #STR_BuyTicket1NOTENOUGHGOLD  -> Turnip.choices}  #STR_BuyTicket1

Com antecipação no ar, a rifa começa e, quando o locutor anuncia o número do bilhete premiado, você segura o fôlego. No entanto, a sorte não está do seu lado desta vez. O número vencedor não é o seu, e uma pontada de decepção o atinge. #STR_BuyTicket2

* [Retornar à folia festiva.]->Start.choices

=== PerceiveTurnip ===
{perform_player_skill_check("Roguery", 80): -> success | ->fail}

    =success
    Seus olhos aguçados percebem detalhes sutis que outros podem deixar passar. O nabo parece não ter marcações estranhas que sugiram sua importância. É completamente comum.   #STR_PerceiveTurnip_Success
    ->Turnip.choices
    
    =fail
    Seu exame não revela nada de incomum no nabo. #STR_PerceiveTurnip_Success
    ->Turnip.choices

===Leave===
Conforme a alegria da feira desaparece, você retorna ao abraço da natureza selvagem, deixando para trás os risos da folia. #STR_Leave1
->END

