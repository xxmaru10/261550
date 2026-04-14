//Global story tags
# title: Cabin In The Woods
# frequency: Common
# development: false
# illustration: roadpoint2


//Important Irregular Characters
    //| (Vertical Bar)

//Scenarios notes
    //Rarity: COMMON
    //Repeatable: YES

    //Restrictions

    //Triggers:
        //While Travelling on the campaign map
        //After clearing a random bandit camp
        //Quests:
            //Bandit Bounty quest

    //Scenario Explanation (explain the main scenario and any major variations that you are planning to build in. If a variation is different enough consider making it its own file.)

        //Main: Party comes across a locked cabin. They must find a way in.

        //Alt1: Ambush by hostile party [Not Implemented]
        //Alt2: Dungeon hidden inside [Not Implemented]


    //Future Options/Additions
        //Faith check if party has a priest of Ranald
        //Someone answers when you knock on the door
        //Burn down the cabin
        //Hidden items in the cabin
            //Different ways item can be hidden (ex magically hidden, trap door)

INCLUDE include.ink

//Variables setup

        VAR PartyRogueryCheckText = 0
        VAR PartyRogueryCheckTest = 0
        VAR PartySpellcraftCheckText = 0
        VAR PartySpellcraftCheckTest = 0
        VAR PartyEngineeringCheckText = 0
        VAR PartyEngineeringCheckTest = 0
        VAR PartyCanCastSpell = false
        VAR PartyVigorCheckText = ""
        VAR PartyVigorCheckTest = 0

    VAR LockQuality = 0
        ~ LockQuality = RANDOM(1,3)

    VAR LockDifficulty = 0
        ~ LockDifficulty = LockQuality * 50

    VAR LockText = ""
        {
            - LockQuality == 1:
                ~ LockText = "weak"
            - LockQuality == 2:
                ~ LockText = "average"
            - LockQuality == 3:
                ~ LockText = "strong"
        }

    ~ SetTextVariable("LockText",LockQuality)

    VAR DoorQuality = 0
        ~ DoorQuality = RANDOM(1,3)

    VAR DoorDifficulty = 0
        ~ DoorDifficulty = DoorQuality * 50

    VAR DoorText = ""
        {
            - DoorQuality == 1:
                ~ DoorText = "weak"
            - DoorQuality == 2:
                ~ DoorText = "average"
            - DoorQuality == 3:
                ~ DoorText = "strong"
        }

    ~ SetTextVariable("DoorText",DoorQuality)
    //Reward
        VAR RewardRoll = 0
           ~ RewardRoll = RANDOM(0,2)

        VAR RewardText = ""
            {
                - RewardRoll == 0:
                    ~ RewardText = "5 grain"
                - RewardRoll == 1:
                    ~ RewardText = "2 steel ingots"
                - RewardRoll == 2:
                    ~ RewardText = "500 gold"
            }

    ~ SetTextVariable("RewardText",RewardRoll)

 //Variable Update: Update any variables before story start
    ~ PartyRogueryCheckText = print_party_skill_chance("Roguery", LockDifficulty)
    ~ PartyRogueryCheckTest = perform_party_skill_check("Roguery", LockDifficulty)

    ~ PartySpellcraftCheckText = print_party_skill_chance("Spellcraft", DoorDifficulty)
    ~ PartySpellcraftCheckTest = perform_party_skill_check("Spellcraft", DoorDifficulty)

    ~ PartyEngineeringCheckText = print_party_skill_chance("Engineering", LockDifficulty)
    ~ PartyEngineeringCheckTest = perform_party_skill_check("Engineering", LockDifficulty)

    ~ PartyVigorCheckText = print_party_attribute_chance("Vigor", DoorDifficulty / 30)
    ~ PartyVigorCheckTest = perform_party_attribute_check("Vigor", DoorDifficulty / 30)


-> Start

===Start===
    Enquanto seu grupo viaja, vocês se deparam com uma cabana na floresta. #STR_Start1

    *[Aproximar-se da cabana]->Approach
    *[Continuar o caminho (Sair)]Você decide que é melhor seguir em frente por ora.->END

===Approach===

Ao se aproximar da cabana, você pode ver que está fortemente barricada. A única porta parece estar bem trancada. Ao examinar a porta, você nota que ela é {DoorText} e que o cadeado nela é {LockText}. #STR_Approach1
->choice1

    =choice1
    O que seu grupo fará?
    *[Bater na porta]Você bate, mas ninguém responde.->Approach.choice1

    //Pick the lock (Roguery)
        *[Arrombar a fechadura da porta {PartyRogueryCheckText}]
            O melhor "ladino" do seu grupo tenta arrombar a fechadura.
            {PartyRogueryCheckTest: Seu grupo consegue abrir a fechadura. ->Inside | Seu grupo falha em arrombar a fechadura. ->Approach.choice1}

    //Disassemble the Lock (Engineering)
        *[Desmontar a fechadura {PartyEngineeringCheckText}]
            O melhor engenheiro do seu grupo tenta desmontar a fechadura.
            {PartyEngineeringCheckTest: Usando uma seleção de suas melhores ferramentas, incluindo chaves de fenda, formões e uma marreta, seu engenheiro desmonta a fechadura com maestria — tão "completa" é a desmontagem que a fechadura jamais voltará a ser remontada. ->Inside | Seu grupo falha em desmontar a fechadura. ->Approach.choice1}

    //Blow up the door (Spellcraft)
        *{PartyCanCastSpell == true}[Explodir a porta {PartySpellcraftCheckText}]
            O melhor mago do seu grupo tenta explodir a porta com magia.
            {PartySpellcraftCheckTest: Seu grupo arranca a porta completamente das dobradiças. ->Inside |Seu grupo falha em explodir a porta. ->Approach.choice1}

    //Break down the door (Vigor)
        *[Arrombar a porta {PartyVigorCheckText}]
            O membro mais forte do seu grupo tenta arrombar a porta.
            {PartyVigorCheckTest: Seu grupo derruba a porta completamente das dobradiças. ->Inside |Seu grupo falha em arrombar a porta. ->Approach.choice1}

    *[Continuar o caminho (Sair)]Você decide que é melhor seguir em frente por ora.->END

===Inside===

Seu grupo entra na cabana e descobre que alguém ou algo armazenou alguns suprimentos aqui. #STR_Inside1
->choice2

    =choice2
        *[Pegar os suprimentos ({RewardText})]
            Você pega os {RewardText} e os adiciona ao seu estoque antes de continuar em seu caminho.
            {RewardRoll:
                -0:
                    ~ GiveItem("grain",5)
                -1:
                    ~ GiveItem("ironIngot4", 2)
                -2:
                    ~ GiveGold(500)
            }
            ->END

        *[Sair]Você decide deixar os suprimentos e seguir seu caminho.->END
