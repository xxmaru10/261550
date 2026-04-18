//Global story tags
# title: Carro�a Virada
# frequency: Common
# development: false
# illustration: cart_accident

INCLUDE include.ink

        VAR InjuryDifficulty = 2
            {InjuryRoll:
                -1: 
                    ~InjuryDifficulty = 100
                -2: 
                    ~InjuryDifficulty = 250
            }
        
        VAR Settlement = ""
            ~ Settlement = GetNearestSettlement("town")
                
        VAR Notable = ""
            ~ Notable = GetRandomNotableFromSpecificSettlement(Settlement)
                
        VAR NotableChange = false
                
        VAR PartyCanRaiseDead = false
            ~ PartyCanRaiseDead = PartyHasNecromancer(false)
                
        VAR RaiseDeadSkillCheckText = ""
            ~ RaiseDeadSkillCheckText = print_party_skill_chance("Spellcraft", 25)
                
        VAR RaiseDeadSkillCheckTest = false
            ~ RaiseDeadSkillCheckTest = perform_party_skill_check("Spellcraft", 25)
                
        VAR MedicineSkillCheckText = ""
            ~ MedicineSkillCheckText = print_party_skill_chance("Medicine", InjuryDifficulty)
                
        VAR MedicineSkillCheckTest = false
            ~ MedicineSkillCheckTest = perform_party_skill_check("Medicine", InjuryDifficulty)
                
        VAR SpellcraftSkillCheckText = ""
            ~ SpellcraftSkillCheckText = print_party_skill_chance("Spellcraft", InjuryDifficulty)
                
        VAR SpellcraftSkillCheckTest = false
            ~ SpellcraftSkillCheckTest = perform_party_skill_check("Spellcraft", InjuryDifficulty)
                
        VAR LoreOfLifeInParty = false
                ~ LoreOfLifeInParty = DoesPartyKnowSchoolOfMagic(false, "LoreOfLife")

        VAR InjuryRoll = 2
            ~ InjuryRoll = RANDOM(0,2)
            
        VAR InjuryText1 = ""
            {InjuryRoll:
                -0: 
                    ~InjuryText1 = "ileso"
                -1: 
                    ~InjuryText1 = "levemente ferido"
                -2: 
                    ~InjuryText1 = "gravemente ferido"
            }
        
        VAR InjuryText2 = ""
            {InjuryRoll:
                -0: 
                    ~InjuryText2 = "pede"
                -1: 
                    ~InjuryText2 = "implora"
                -2: 
                    ~InjuryText2 = "ofega"
            }
        
        VAR InjuryText3 = ""
            {InjuryRoll:
                -0: 
                    ~InjuryText3 = "se levanta"
                -1: 
                    ~InjuryText3 = "mal consegue se levantar"
                -2: 
                    ~InjuryText3 = "permanece ali tentando não morrer"
            }
            
        VAR InjuryText4 = ""
            {InjuryRoll:
                -0: 
                    ~InjuryText4 = ""
                -1: 
                    ~InjuryText4 = "parece ficar um pouco deprimido sabendo que ficará incapacitado por algum tempo"
                -2: 
                    ~InjuryText4 = "morre"
            }
    
        VAR HorsesAround = 0
            ~HorsesAround = RANDOM(0,1)

        //Ask for info
        VAR HasAsked = false
        
        //Profession of the stuck man
        VAR ProfessionRoll = 0
            ~ ProfessionRoll = RANDOM(0,2)
            
        VAR Profession = ""
            {ProfessionRoll:
                -0: 
                    ~Profession = "mercante"
                -1: 
                    ~Profession = "fazendeiro"
                -2: 
                    ~Profession = "ferreiro"
            }
        
        VAR RewardText = ""
            {ProfessionRoll:
                -0: 
                    ~RewardText = "500 moedas de ouro"
                -1: 
                    ~RewardText = "5 sacos de grãos"
                -2: 
                    ~RewardText = "2 lingotes de aço"
            }

        VAR HasExtorted = false
        
        //Bonus Reward
        VAR BonusRoll = 0

        VAR ManAlive = true
        
         ~ SetTextVariable("HorsesAround",HorsesAround)
        ~ SetTextVariable("InjuryText1",InjuryText1)
        ~ SetTextVariable("InjuryText2",InjuryText2)
        ~ SetTextVariable("InjuryText3",InjuryText3)
        ~ SetTextVariable("InjuryText4",InjuryText4)
        
        ~ SetTextVariable("Profession",Profession)
        ~ SetTextVariable("Settlement",Settlement)
        ~ SetTextVariable("Notable",Notable)
        ~ SetTextVariable("RewardText",RewardText)
        
        ~ SetTextVariable("RaiseDeadSkillCheckText",RaiseDeadSkillCheckText)
         
        ~ SetTextVariable("HasExtorted1",HasExtorted)
        ~ SetTextVariable("HasExtorted2",HasExtorted)
        

-> Start

===Start===
    Enquanto seu grupo viaja, você vê uma carroça à distância. #STR_Start1
    Ao se aproximar, você percebe que ela quebrou e tombou. #STR_Start2
    {HorsesAround: Você também nota alguns cavalos pastando em um campo próximo; presumivelmente, eles estavam puxando a carroça antes do incidente. #STR_StartHorse}

    *[Aproximar-se da carroça]->Approach
    *[Seguir seu caminho] Você decide ignorar a carroça tombada e continuar sua jornada. ->END

===Approach===

    Você se aproxima da carroça e encontra um homem preso debaixo dela. Quando ele vê você se aproximando, grita por socorro. #STR_Approach1
    Você nota que o homem preso sob a carroça está {InjuryText1}. #STR_Approach2
    Conforme você se aproxima, ele {InjuryText2} para você: "Por favor, me ajude".  #STR_Approach3
    O que você fará? #STR_Approach4
    ->choices
    
    =choices
        *[Perguntar o que ele pode fazer por você se o ajudar] #STR_RewardForHelp0
            Você pergunta ao homem o que ele pode fazer por você. #STR_RewardForHelp1
            O homem responde: "Sou apenas um simples {Profession} de {Settlement}. Não posso lhe dar outra recompensa além do meu agradecimento." #STR_RewardForHelp2
            Após um momento, ele diz: "Sou amigo de {Notable} e falarei bem de você." #STR_RewardForHelp3
            Enquanto ele fala, você não pode deixar de notar que ainda parece haver alguma carga na carroça. #STR_RewardForHelp4
            ~HasAsked = true
            ->choices
        
            *{not HasAsked}[Ajudá-lo (Misericórdia++)]
                Você decide ajudá-lo. #STR_HelpNoReward1
                ~ AddTraitInfluence("Mercy", 160)
                ->AfterLift
                
            *{HasAsked}[Ajudá-lo (+Relações com {Notable}, Misericórdia+)]
                Você decide ajudá-lo. #STR_HelpRelation1
                ~ AddTraitInfluence("Mercy", 80)
                ~ NotableChange = true
                ->AfterLift
        
            *{HasAsked}[Extorqui-lo por uma recompensa (Misericórdia-)]
                Você diz ao {Profession} que ele não deve ser tão modesto. Ele é claramente um homem de algumas posses e pode facilmente ceder {RewardText} como compensação pela assistência. #STR_HelpExtort1
                O homem, acreditando não ter outra opção, concorda. #STR_HelpExtort2
                ~ AddTraitInfluence("Mercy", -80)
                ~ HasExtorted = true
                ->AfterLift
            
            *{HasAsked && HorsesAround}[Exigir um dos cavalos (Misericórdia-)]
                Você diz que, como ele claramente é incapaz de controlar dois cavalos, não deve haver problema em lhe dar um como pagamento. #STR_HelpExtortHorse1
                O homem, vendo que não tem outra opção, concorda. #STR_HelpExtortHorse2
                ~ AddTraitInfluence("Mercy", -80)
                ~ HasExtorted = true
                ~ SetTextVariable("HasExtorted1",HasExtorted)
                ~ SetTextVariable("HasExtorted2",HasExtorted)
                ->AfterLift
        
            *{HorsesAround}[Levar os cavalos e partir (Misericórdia--)]
                Você decide que, em vez de ajudar o homem, prefere ir domar os dois cavalos; como são claramente cavalos selvagens que de forma alguma tiveram dono anterior, isso é perfeitamente legal. #STR_HelpTakeHorse1
                Depois de assumir o controle dos cavalos e partir, você ouve os gritos do homem preso implorando para você voltar e ajudar, sumindo na distância. #STR_HelpTakeHorse1
                ~ AddTraitInfluence("Mercy", -160)
                ~ GiveItem("old_horse",2)
                ->END
                
        //Necromancer option
            *{PartyCanRaiseDead}[Matar o homem, erguer seu cadáver como um esqueleto, {HorsesAround: levar os cavalos,} e saquear sua carroça (Misericórdia---) {print_party_skill_chance("Spellcraft", 25)}]
                Uma ideia brilhante lhe ocorre. Como o homem é claramente inútil como condutor de carroça, talvez ele possa encontrar valor tornando-se um de seus lacaios mortos-vivos. #STR_HelpNecromancer1
                Em um movimento rápido, você mata o homem e passa a erguê-lo como um esqueleto. Seu grupo faz uma tentativa e {RaiseDeadSkillCheckTest: tem sucesso | falha }.#STR_HelpNecromancerSummon
                {RaiseDeadSkillCheckTest: -> raiseSucceed | -> raiseFail}
    
    =raiseSucceed
    Tendo erguido o morto com sucesso, você decide celebrar pegando todos os pertences do homem. #STR_HelpNecromancerSuccess
        {ProfessionRoll:
            -0: 
                ~GiveGold(500)
            -1: 
                ~GiveItem("grain", 5)
            -2: 
                ~GiveItem("ironIngot4", 2)
        }
        {HorsesAround: {GiveItem("old_horse",2)}}
        ~ ChangePartyTroopCount("tor_vc_skeleton",1)
        -> END
    
    =raiseFail
    Tendo falhado, você decide pegar todos os pertences do homem morto como compensação por perder seu tempo. #STR_HelpNecromancerFail
        {ProfessionRoll:
            -0: 
                ~GiveGold(500)
            -1: 
                ~GiveItem("grain", 5)
            -2: 
                ~GiveItem("ironIngot4", 2)
        }
        {HorsesAround: {GiveItem("old_horse",2)}}
        -> END

===AfterLift===
    Seu grupo levanta a carroça de cima do homem e ele {InjuryText3}. #STR_AfterLiftMedicine1

    //Is Injured?
        {InjuryRoll:
            -0:     ->Reward
            -else:  ->Injury
        }

        =Injury
            Como você tratará o ferimento dele? #STR_AfterLiftMedicine2
                *[Tratá-lo com medicina {MedicineSkillCheckText}]
                    Seu melhor médico começa a trabalhar tentando tratar o homem. #STR_AfterLiftMedicine
                        {MedicineSkillCheckTest: ->Success | ->Fail}
                        
                *{LoreOfLifeInParty}[Tratá-lo com magia {SpellcraftSkillCheckText}]
                    Um conjurador em seu grupo evoca os ventos de Ghyran para curar as feridas do homem. #STR_AfterLiftMagic
                        {SpellcraftSkillCheckTest: ->Success | ->Fail}
                    
        =Success
            Seu tratamento é bem-sucedido e o homem ficará bem agora. #STR_AfterLiftHealSuccess
                ~ BonusRoll = RANDOM(0,100)
                ->Reward
            
        =Fail
            Seu tratamento falha e o homem {InjuryText4}. #STR_AfterLiftHealFail
                {InjuryRoll:
                    -2:
                        ~ ManAlive = false
                }
            ->Reward
            
===Reward===

    {ManAlive:->LiveReward|->DeadReward}

    =LiveReward
        Tendo sido salvo, o homem agradece {HasExtorted: relutantemente} por sua ajuda{HasExtorted: e lhe entrega a recompensa prometida}.#STR_RewardAlive1 
        {NotableChange: Enquanto ele começa a recolher suas coisas, diz: "Contarei a {Notable} sobre seus feitos assim que chegar em casa."#STR_RewardAliveNotable} 
        {HasExtorted == false && BonusRoll >=50: O homem, parando por um momento, diz: "Eu sei que disse que não tinha muito, mas por favor, aceite isto ({RewardText}). É o mínimo que posso fazer por sua bondade."#STR_RewardAliveChance} 
        
        {HasExtorted || (not HasExtorted && BonusRoll >=50):
            -true:
                {ProfessionRoll:
                    -0: 
                        ~GiveGold(500)
                    -1: 
                        ~GiveItem("grain", 5)
                    -2: 
                        ~GiveItem("ironIngot4", 2)
                }
        }
        {NotableChange: {ChangeRelations(Notable, 5)}}
        ->END
        
    =DeadReward
        O que seu grupo fará a seguir? #STR_RewardDead1 
            *[Enterrar o homem (Misericórdia+)]
                Você decide enterrar o homem, esperando que ele possa encontrar paz. #STR_RewardDeadBury 
                {AddTraitInfluence("Mercy", 160)}
                ->DeadReward
            *[Saquear a carroça {HorsesAround: e levar os cavalos} ({RewardText}{HorsesAround:, +2 cavalos tier 0})]
                Agora que o homem faleceu, ele obviamente não precisará mais dos suprimentos. #STR_RewardDeadLoot 
                {ProfessionRoll:
                    -0: 
                        ~GiveGold(500)
                    -1: 
                        ~GiveItem("grain", 5)
                    -2: 
                        ~GiveItem("ironIngot4", 2)
                }
                {HorsesAround: {GiveItem("old_horse",2)}}
                ->DeadReward
            *{PartyCanRaiseDead}[Erguê-lo como um esqueleto (+1 esqueleto){RaiseDeadSkillCheckText}]
                Como um homem morto não tem uso para seu corpo, você decide erguê-lo como um esqueleto. #STR_RewardDeadRiseDead 
                Seu grupo faz uma tentativa e {RaiseDeadSkillCheckTest: tem sucesso| falha}. #STR_RewardRiseDead2
                
                {RaiseDeadSkillCheckTest:
                    -true: O corpo do homem se ergue e se arrasta para se juntar ao resto do seu exército. #STR_RewardDeadRiseDeadSuccess
                        ~ ChangePartyTroopCount("tor_vc_skeleton",1)
                }
                ->DeadReward
            *[Partir (sair)]
                Você decide que é hora de seguir em frente e continuar sua jornada. #STR_RewardDeadLeave
                ->END

