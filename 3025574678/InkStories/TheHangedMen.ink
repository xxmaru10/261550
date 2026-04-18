//Global story tags
# title: Os Homens Enforcados
# frequency: Common
# development: false
# illustration: hangedman

//Important Irregular Characters
    //| (Vertical Bar)

//Scenarios notes
    //Rarity: COMMON
    //Repeatable: YES
    
    //Triggers:
        //While Travelling on Campaign map
    
    //Scenario Explanation (explain the main scenario and any major variations that you are planning to build in. If a variation is different enough consider making it its own file.)
    
        //Main: You come across a bunch of hanged men with a sword in the ground underneath them. There is a body buried under the sword.

        //Alt:
        
    //Future Options/Additions
        //Add ability to gain relations or gain faith skill for people who have a death god (ex. Morr)
        //Remove certain choices if the player is not Order (Undead, Chaos, Greenskin)
        //Make sure the spellcraft skill used for raise dead comes from a necromancer in the party
        //Add in a murder mystery available by speaking to the dead
            //Necro can make Spirit hosts instead of zombies
        //Take skulls option for chaos
        //Change skeleton to zombie
        //Defile corpses

INCLUDE include.ink

//Variables setup

    //Party can raise departed
        VAR PartyCanRaiseDead = false
            ~ PartyCanRaiseDead = PartyHasNecromancer(false)
                
    //Spellcraft (Highest In Party)
        VAR PartySpellcraftCheckText = 0 //Not important initial value
            ~ PartySpellcraftCheckText = print_party_skill_chance("Spellcraft", RaiseDeadDifficulty)
                
        VAR PartySpellcraftCheckTest = 0 //Not important initial value
            ~ PartySpellcraftCheckTest = perform_party_skill_check("Spellcraft", RaiseDeadDifficulty)
                
    //Give Items
        VAR HaveSword = false
        VAR TookSword = false
        VAR LootedBody = false

    //Raise Dead
        VAR RaiseDeadDifficulty = 50
        VAR SkeletonSuccess = false

    //Grave Interaction
        VAR DugUpGrave = false
        VAR CryptGuardSuccess = false


-> Start

===Start===
    Você encontra uma árvore com três homens pendurados e uma espada cravada no chão abaixo deles. Ao se aproximar, vê que a palavra "Traidores" foi entalhada no tronco e que a espada serve como marcador para uma cova. #STR_Start1
    ->choice1

    //What to do with the hanging bodies
    =choice1
        O que seu grupo fará com os corpos pendurados? #STR_Start2
        
            *[Não fazer nada]
                Você decide não fazer nada com os corpos pendurados. #STR_DoNothing
                ->Grave
        
            *[Enterrar os corpos pendurados (Misericórdia+)]
                Você corta as cordas e sepulta os corpos para que descansem. #STR_Bury
                ~ AddTraitInfluence("Mercy", 80)
                ->Grave
        
            *[Saquear os corpos pendurados (Misericórdia-)]
                Você corta as cordas e saqueia os cadáveres, levando os trapos esfarrapados com os quais foram executados. #STR_Loot
                ~ AddTraitInfluence("Mercy", -80)
                ~ GiveItem("wrapped_headcloth",3)
                ~ GiveItem("ragged_robes",3)
                ~ GiveItem("leather_shoes",3)
                ->Grave
            
        //Raise the hanging bodies as skeletons
            *{PartyCanRaiseDead}[Erguer os corpos pendurados como esqueletos (Misericórdia--) {print_party_skill_chance("Spellcraft", RaiseDeadDifficulty)}]
                ~ AddTraitInfluence("Mercy", -200)
                {perform_party_skill_check("Spellcraft", RaiseDeadDifficulty):
                    -true:
                        ~ ChangePartyTroopCount("tor_vc_skeleton",3)
                        ~ SkeletonSuccess = true
                }
                Seu grupo tenta ressuscitar os cadáveres como esqueletos {SkeletonSuccess: e consegue. ->Grave | e falha.->choice1} #STR_Loot

===Grave===
    //Needed for intermission text 
        Após decidir o que fazer com os corpos pendurados, você volta sua atenção para a cova marcada pela espada. #STR_Grave
        ->choice2
        
    //What to do with the buried body
    =choice2
        
        //Variable Update
        ~ RaiseDeadDifficulty = 100
        O que você fará com a cova? #STR_Grave
        *[Deixar este lugar (Sair)]
            ->Leave
            
        *[Fazer uma prece (Misericórdia+)]
            Você faz uma prece pelos falecidos, esperando que encontrem paz. #STR_Prayer
            ~ AddTraitInfluence("Mercy", 80)
            ->Leave


        *[Pegar a espada (1 espada nível 3, Misericórdia-)]
            Você toma a espada em suas mãos. #STR_TakeSword
            ~ AddTraitInfluence("Mercy", -80)
            ~ HaveSword = true
            ~ TookSword = true
            ->choice2
            
        *[Cavar a cova (Misericórdia-)]
            Você cava a cova e encontra um guerreiro enterrado com sua armadura. É possível notar que parte da armadura está danificada, provavelmente por causa dos "traidores". #STR_Dig
            ~ AddTraitInfluence("Mercy", -80)
            ~ DugUpGrave = true
            ->choice2
        
        *{DugUpGrave == true}[Saquear o corpo enterrado (2 peças de armadura nível 3, Misericórdia-)]
            Você despe o corpo de toda a armadura que ainda está intacta. #STR_DigLoot
            ~LootedBody = true
            ~AddTraitInfluence("Mercy", -80)
            
                //Loot Rolls
                    {RANDOM(0,1):
                        -0: 
                            ~GiveItem("roundkettle_over_imperial_leather",1)
                        -1: 
                            ~GiveItem("imperial_padded_cloth",1)
                    }
                    {RANDOM(0,1):
                        -0: 
                            ~GiveItem("mail_mitten",1)
                        -1: 
                            ~GiveItem("mail_chausses",1)
                        }

            ->choice2
            
        *{DugUpGrave && PartyCanRaiseDead && not LootedBody}[Ressuscitar o corpo enterrado como um fastio (+1 Guarda de Cripta, Misericórdia--) {print_party_skill_chance("Spellcraft", RaiseDeadDifficulty)}]
            ~AddTraitInfluence("Mercy", -200)
                
                //Raise Dead
                    {perform_party_skill_check("Spellcraft", RaiseDeadDifficulty):
                        -true:
                            ~ ChangePartyTroopCount("tor_vc_crypt_guard",1)
                            ~ CryptGuardSuccess = true
                            ~ HaveSword = false
                        -false:
                    }

                Seu grupo tenta ressuscitar o cadáver como um fastio {CryptGuardSuccess: e consegue. O fastio se ergue {TookSword: e estende a mão como se pedisse sua espada de volta. Você devolve a arma} e então ele marcha para se juntar ao restante de suas forças. ->Leave | e falha.->choice2} #STR_DigResurrect
            ->Leave

===Leave===
    Tendo tomado suas decisões, você segue seu caminho. #STR_Leave1
    {HaveSword: 
        ~GiveItem("vlandia_sword_1_t2",1)
    }
-> END
















