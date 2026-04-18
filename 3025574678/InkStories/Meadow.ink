//Global story tags
# title: O Prado
# frequency: Common
# development: false
# illustration: meadow

//Important Irregular Characters
    //| (Vertical Bar)

//Scenarios notes
    //Rarity: COMMON
    //Repeatable: YES
    
    //Restrictions
        //Terrain: Not dessert,
    
    //Triggers:
        //While travelling on campaign map
    
    //Scenario Explanation (explain the main scenario and any major variations that you are planning to build in. If a variation is different enough consider making it its own file.)
    
        //Main: You are travelling and come across a meadow.

        //Alt: If encountered while in a chaos area it gets weird.
        
    //Future Options/Additions
        //Make it so the player does not have to click through each time they do a loop.
        //More options
            //Search for animals (capture animals like horses)
            //If a lore of life wizard is present they can channel to regain some magic
            //Spend some time training
        //Add choices/effects for nature gods
            //Hunting success chance improved by Priest of Tall
            //Healing success chance improved by Pries of Rhya or Shallya
            //Foraging success chance improved by Priest of Rhya
        //Add choices/effects for wizards (Lore of Life, Lore of Beasts, ...)
            //Hunting success chance improved by lore of beasts
            //Healing success chance improved by Lore of Life
            //Foraging improved by lore of Life
        //?Add olives as a future option
        //Add randomness to the amount of plant and animal life as well as the difficulty of success
            //Randomize elements of Foraging
            //Randomize elements of Hunting
        
//Data Import/Export Section
    //Make sure you include this in all ink files to get access to integration functions
        INCLUDE include.ink
        
    //List of Data Being Imported (use this to help keep track of what data you are importing; will help with troubleshooting and testing.)
    
        //Scouting Highest In party
            //Used in hunting skill check
                VAR PartyScoutingCheckText = 0
                    //~ PartyScoutingCheckText = print_party_skill_chance("Scouting", HuntDifficulty) [Variable Update]
                
                VAR PartyScoutingCheckTest = 0
                    //~ PartyScoutingCheckTest = perform_party_skill_check("Scouting", HuntDifficulty) [Variable Update]
        //Medicine (Highest in Party)
            //Used in party recovery skill check
                VAR WoundedCount = 1
                    ~ WoundedCount = GetTotalPartyWoundedCount() + 1

                VAR MedicineDifficulty = 1
                    ~ MedicineDifficulty = 3*WoundedCount
                    
                    
                VAR PartyMedicineCheckText = 2
                    ~ PartyMedicineCheckText = print_party_skill_chance("Medicine", MedicineDifficulty)
                
                VAR PartyMedicineCheckTest = 2
                    ~ PartyMedicineCheckTest = perform_party_skill_check("Medicine", MedicineDifficulty)
                    
        //Ranged Weapon Skill Highest In the party
            //Bows, Crossbows, Throwing, Gunnery
                //Bow
                    VAR BowHighestInParty = 0
                        ~ BowHighestInParty = GetPartySkillValue("Bow")

                //Crossbow
                    VAR CrossbowHighestInParty = 0
                        ~ CrossbowHighestInParty = GetPartySkillValue("Crossbow")

                //Bow
                    VAR ThrowingHighestInParty = 0
                        ~ ThrowingHighestInParty = GetPartySkillValue("Throwing")
                //Bow
                    VAR GunpowderHighestInParty = 0
                        ~ GunpowderHighestInParty = GetPartySkillValue("Gunpowder")
                        
            //Comparison
                VAR SkillText1 = ""
                VAR SkillText2 = ""
                VAR SkillTextFinal = ""
                
                VAR BowVsCrossbow = 0
                    {
                        - BowHighestInParty >= CrossbowHighestInParty:
                            ~ BowVsCrossbow = BowHighestInParty
                            ~ SkillText1 = "Bow"
                        - else:
                            ~ BowVsCrossbow = CrossbowHighestInParty
                            ~ SkillText1 = "Crossbow"
                    }
                    
                VAR ThrowingVsGunpowder = 0
                    {
                        - ThrowingHighestInParty >= GunpowderHighestInParty:
                            ~ ThrowingVsGunpowder = ThrowingHighestInParty
                            ~ SkillText2 = "Throwing"
                        - else:
                            ~ ThrowingVsGunpowder = GunpowderHighestInParty
                            ~ SkillText2 = "Gunpowder"
                    }
                    
                VAR FinalComparison = 0
                    {
                        - BowVsCrossbow >= ThrowingVsGunpowder:
                            ~ FinalComparison = BowVsCrossbow
                            ~ SkillTextFinal = SkillText1
                        - else:
                            ~ FinalComparison = ThrowingVsGunpowder
                            ~ SkillTextFinal = SkillText2
                    }
 
            //RangedSkillCheck
                VAR PartyRangedSkillCheckText = 1
                    //~ PartyRangedSkillCheckText = print_party_skill_chance(SkillTextFinal, 200) [Variable Update]
                    
            //Wizards in party
                //Lore of life
                    VAR LoreOfLifeInParty = false
                        ~ LoreOfLifeInParty = DoesPartyKnowSchoolOfMagic(false, "LoreOfLife")
                //Lore of life
                    VAR LoreOfBeastsInParty = false
                        ~ LoreOfBeastsInParty = DoesPartyKnowSchoolOfMagic(false, "LoreOfBeasts")
                        
    //Data Exported (use this to help keep track of what data you are exporting; will help with troubleshooting and testing.)
        //Give Items
            
        
//Variables setup
    //IMPORTANT! Initial values are mandatory, but they can only be primitives (number, string, boolean). If we want to assign the return value of a function to the variable, we must do it on a separate line, see one line below

    //Seed
        //~ SEED_RANDOM(100) //Uncomment to lock an RNG testing seed for the randomness. Change number inside () for different seed
        
    //Hunt
        VAR HuntDifficulty = 150
            
        VAR HuntLoops = 3
        
        VAR HideSuccessful = false
        
    //Forage
        VAR ForageDifficulty = 50
        
        VAR ForageLoops = 5
        
    //Was X attempt successful
        VAR AttemptSuccessful = false
        
    //Reward Roll
        VAR RewardRoll = 0
        

//Variable Update (Update any variables here)
    ~ PartyScoutingCheckText = print_party_skill_chance("Scouting", HuntDifficulty)
                
    //~ PartyScoutingCheckTest = perform_party_skill_check("Scouting", HuntDifficulty) Needs to be done each loop

    ~ PartyRangedSkillCheckText = print_party_skill_chance(SkillTextFinal, HuntDifficulty*2)
    
    
    
//Variable Check (Use for sanity check. Uncomment variables to see what they are)
    
     ~ SetTextVariable("IsNight",IsNight())

-> Start

===Start===

    Você e seu grupo têm avançado penosamente por um caminho sinuoso, quando a paisagem começa a mudar gradualmente. O ar torna-se mais suave, e os sons, mais pacíficos. #STR_Start1
    Então, vocês entram em uma clareira, e um suspiro escapa de seus lábios. Diante de vocês estende-se um prado como nenhum outro que viram em muito tempo. A grama é uma rica tapeçaria verde, ondulando suavemente na brisa. Uma multidão de flores silvestres pinta a cena com matizes vibrantes de vermelho, roxo e amarelo. #STR_Start2
    {IsNight(): O luar prateado | A luz dourada do sol } filtra-se através da copa das árvores, banhando o prado em calor. Um aroma suave de flores desabrochando perfuma o ar. Pássaros cantam suas melodias, preenchendo a clareira com uma sinfonia que parece um bálsamo para seu espírito cansado. #STR_Start3
        ->choice1
        
    =choice1
        O que você ordenará que seu grupo faça? #STR_Start4
            *[Procurar plantas silvestres (Diferentes tentativas com {LoreOfLifeInParty: 75% de chance (Melhorado pelo Saber da Vida)| 50% de chance} de sucesso na colheita)] 
            Você ordena que seu grupo procure entre as plantas do prado. #STR_Forage1
            
                //Lore of Life in Party Increases success chance
                    {LoreOfLifeInParty:
                        -true: 
                            Um mago em seu grupo clama pelo Vento de Ghyran para auxiliar seus homens na busca. #STR_Forage_LoreOFLifeInParty
                            ~ ForageDifficulty = ForageDifficulty - 25
                        -false:
                        -else: ERROR
                    }
                    
                ->ForageLoop

            *[Caçar animais (Múltiplas chances de obter carne, couro ou pele {PartyRangedSkillCheckText})]
                
                //Bonus Attempts from Lore of Beasts
                    {LoreOfBeastsInParty:
                        -true: 
                            Um mago em seu grupo clama pelo Vento de Ghur para auxiliar seus homens na busca. (+1 tentativa) #STR_Hunt_LoreOFBeastInParty
                            ~ HuntLoops = HuntLoops + 1
                        -false:
                        -else: ERROR
                    }
                    
                //Bonus attempt from Scouting
                    {perform_party_skill_check("Scouting", HuntDifficulty):
                        -true: 
                            Seus batedores conseguem localizar alguns animais extras. (Batedor)(+1 tentativa) #STR_Hunt_Scout
                            ~HuntLoops = HuntLoops + 1
                        -false:
                        -else: ERROR
                    }
                    
                ->HuntLoop
                
            *[Fazer seus homens descansarem (Companheiros curados e tropas feridas recuperadas {PartyMedicineCheckText})]
                
                Você tenta dar um descanso aos seus homens, esperando que o breve repouso ajude em sua recuperação. Vocês montam um acampamento improvisado na borda do prado. #STR_Rest1
                
                {PartyMedicineCheckTest:
                    -true: 
                        ~ HealPartyToFull()
                    -false:
                    -else: "ERROR"
                }
                
                {PartyMedicineCheckTest: Seu grupo aproveita a pausa para cuidar dos feridos.| Infelizmente, assim que os homens começam a descansar, uma grande tempestade surge e força o grupo a se mover para encontrar abrigo.} #STR_Rest2
                
                ->Leave
                
            *[Partir] Você decide que o grupo não tem tempo para descansar e parte imediatamente.->END

    =ForageLoop
        //Decrease number of loops remaining
            ~ ForageLoops = ForageLoops - 1
        
        //Was attempt successful
            {RANDOM(0,100)>=ForageDifficulty:
                -true:
                    ~ AttemptSuccessful = true
                -false:
                    ~ AttemptSuccessful = false
                -else: ERROR
            }

        //Reward if successful
            {AttemptSuccessful:
                -true:
                    ~ RewardRoll = RANDOM(1,4)
                -false:
                    ~ RewardRoll = 0
            }
            
            {RewardRoll:
                -0:
                    A coleta não rendeu frutos, seus homens retornam de mãos vazias. #ForageLoop0
                -1:
                    Seus homens encontram grãos selvagens. (+1 Grãos) #ForageLoop1
                    ~ GiveItem("grain",1)
                -2:
                    Seus homens encontram bagas silvestres. (+1 Uvas) #ForageLoop2
                    ~ GiveItem("grape",1)
                -3:
                    Seus homens encontram linho selvagem. (+1 Linho) #ForageLoop3
                    ~ GiveItem("flax",1)
                -4:
                    Seus homens encontram especiarias selvagens. (+1 Especiaria) #ForageLoop4
                    ~ GiveItem("spice",1)
            }
            
        //End of Loop
            {ForageLoops > 0 : ->ForageLoop | ->Leave}
        
    ->END
    
    =HuntLoop
        //Decrease number of loops remaining
            ~HuntLoops = HuntLoops - 1
        
        //Trouble assistance shooting each loop
            //{FinalComparison}
            //{print_party_skill_chance("Scouting", HuntDifficulty)}
            //{perform_party_skill_check("Scouting", HuntDifficulty)}
        
        //Was attempt successful
            {perform_party_skill_check(SkillTextFinal, HuntDifficulty):
                -true:
                    ~ AttemptSuccessful = true
                -false:
                    ~ AttemptSuccessful = false
                -else: ERROR
            }
            
            //Roll for bonus hide
                ~ HideSuccessful = perform_party_skill_check(SkillTextFinal, HuntDifficulty*2)
            
                {HideSuccessful:
                    -true:
                        ~ RewardRoll = RANDOM(1,2)
                    -false:
                        ~ RewardRoll = 0
                }
            
        //Reward
            {
                - AttemptSuccessful == true && RewardRoll == 0:
                    Seus homens tiveram sucesso e retornam com alguns faisões. (+1 Carne) #HuntLoop0
                    ~ GiveItem("meat",1)
                    ~ GiveItem("hides",1)
                - AttemptSuccessful == true && RewardRoll == 1:
                    Seus homens tiveram sucesso e retornam com um cervo. (+1 Carne, +1 Couro) #HuntLoop1
                    ~ GiveItem("meat",1)
                    ~ GiveItem("hides",1)
                - AttemptSuccessful == true && RewardRoll == 2:
                    Seus homens tiveram sucesso e retornam com um javali selvagem. (+1 Carne, +1 Pele) #HuntLoop2
                    ~ GiveItem("meat",1)
                    ~ GiveItem("fur",1)
                - AttemptSuccessful == false:
                    A caça escapou, seus homens retornam de mãos vazias. #HuntLoop3
                -else: ERROR
            }
                    
        //End of Loop
            {HuntLoops > 0 : ->HuntLoop | ->Leave}
        
    ->END
    
===Leave===
    Tendo passado seu tempo no prado, você decide seguir viagem. #STR_Leave

    ~ MakePartyDisorganized()
    
-> END

