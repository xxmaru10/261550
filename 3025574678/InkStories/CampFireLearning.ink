//Global story tags
# title: The Campfire
# frequency: Special
# development: false
# illustration: campfirenight

//Important Irregular Characters
    //| (Vertical Bar)

//Scenarios notes
    //Rarity: COMMON
    //Repeatable: YES

    //Triggers:
        //While traveling on the campaign map

    //Scenario Explanation (explain the main scenario and any major variations that you are planning to build in. If a variation is different enough consider making it its own file.)

        //Main: You are around a campfire and can listen to a story to gain xp or tell your men to rest.

        //Alt: You can get ambushed

    //Future Options/Additions
        //More possible variants in groupings
        //Magic and Faith XP options when proper restictions are in place

//Data Import/Export Section
    //Make sure you include this in all ink files to get access to integration functions
        INCLUDE include.ink

    //List of Data Being Imported (use this to help keep track of what data you are importing; will help with troubleshooting and testing.)

        //

    //Data Exported (use this to help keep track of what data you are exporting; will help with troubleshooting and testing.)

        //Skill XP

//Variables setup
    //IMPORTANT! Initial values are mandatory, but they can only be primitives (number, string, boolean). If we want to assign the return value of a function to the variable, we must do it on a separate line, see one line below

    //Seed
        //~ SEED_RANDOM(100) //Uncomment to lock an RNG testing seed for the randomness. Change number inside () for different seed

    //Learning sets (The groupings of exp by campfire story category)
        //Each option gives 3000 Xp total. So if a story has 2 skills attached they each get 1500 Xp. For 3 it is 1000 for each.
        //Grouping 1: War stories
            //1. The Hunt (Scouting, Random ranged weapon skill, Tactics)
            //2. The Ambush (Leadership, Tactics, Roguery)
            //3. The Charge (Riding, Polearm, Leadership)
            //4. Holding the Line (Random Melee skill, Leadership, Tactics)
            //5. The Brawl (All melee skills)
            //6. The Shootout (All ranged weapon skills)
        //Grouping 2: Talk about
            //1. Great Rulers (Steward, Leadership, Charm)
            //2. Craftsman (Smithing and Engineering) - smithing's skill object is called Crafting
            //3. Negotiation (Charm, Trade, Roguery)
            //4. Traveling (Riding and Athletics)
            //5. Survival (Medicine, Scouting, Athletics)

    //Random Selections
        //Melee Weapon
            VAR MeleeWeaponRandom = 0
                ~ MeleeWeaponRandom = RANDOM(1,3)
            VAR MeleeWeaponText = ""

                {MeleeWeaponRandom:
                    -1:
                        ~ MeleeWeaponText = "One Handed"
                    -2:
                        ~ MeleeWeaponText = "Two Handed"
                    -3:
                        ~ MeleeWeaponText = "Polearm"
                }


        //Ranged
            VAR RangedWeaponRandom = 0
                ~ RangedWeaponRandom = RANDOM(1,4)
            VAR RangedWeaponText = ""

                {RangedWeaponRandom:
                    -1:
                        ~ RangedWeaponText = "Bow"
                    -2:
                        ~ RangedWeaponText = "Crossbow"
                    -3:
                        ~ RangedWeaponText = "Throwing"
                    -4:
                        ~ RangedWeaponText = "Gunpowder"
                }

    //Group 1
        VAR StoryName = ""
        VAR StoryBranch = ""
        VAR StoryXpText = ""

        VAR StorySelect = 0
            ~ StorySelect = RANDOM(1,6)

            {StorySelect:
                -0: ERROR
                -1:
                    ~ StoryName = "The Hunt"
                    ~ StoryBranch = ->TheHunt
                    ~ StoryXpText = "(+1000 XP for Scouting, {RangedWeaponText}, and Tactics)"
                -2:
                    ~ StoryName = "The Ambush"
                    ~ StoryBranch = ->TheAmbush
                    ~ StoryXpText = "(+1000 XP for Leadership, Tactics, and Roguery)"
                -3:
                    ~ StoryName = "The Charge"
                    ~ StoryBranch = ->TheCharge
                    ~ StoryXpText = "(+1000 XP for Riding, Polearm, and Leadership)"
                -4:
                    ~ StoryName = "Holding the Line"
                    ~ StoryBranch = ->HoldingTheLine
                    ~ StoryXpText = "(+1000 XP for {MeleeWeaponText}, Leadership, and Tactics)"
                -5:
                    ~ StoryName = "The Brawl"
                    ~ StoryBranch = ->TheBrawl
                    ~ StoryXpText = "(+1000 XP for all melee weapon skills)"
                -6:
                    ~ StoryName = "The Shootout"
                    ~ StoryBranch = ->TheShootout
                    ~ StoryXpText = "(+750 XP for all ranged weapon skills)"
            }

    //Group 2
        VAR DiscussionName = ""
        VAR DiscussionBranch = ""
        VAR DiscussionXpText = ""

        VAR DiscussionSelect = 0
            ~ DiscussionSelect = RANDOM(1,5)

            {DiscussionSelect:
                -0: ERROR
                -1:
                    ~ DiscussionName = "Great Rulers"
                    ~ DiscussionBranch = ->GreatRulers
                    ~ DiscussionXpText = "(+1000 XP for Steward, Leadership, and Charm)"
                -2:
                    ~ DiscussionName = "Craftsman"
                    ~ DiscussionBranch = ->Craftsman
                    ~ DiscussionXpText = "(+1500 XP for Smithing and Engineering)"
                -3:
                    ~ DiscussionName = "Negotiation"
                    ~ DiscussionBranch = ->Negotiation
                    ~ DiscussionXpText = "(+1000 XP for Charm, Trade, and Roguery)"
                -4:
                    ~ DiscussionName = "Traveling"
                    ~ DiscussionBranch = ->Traveling
                    ~ DiscussionXpText = "(+1500 XP for Riding and Athletics)"
                -5:
                    ~ DiscussionName = "Survival"
                    ~ DiscussionBranch = ->Survival
                    ~ DiscussionXpText = "(+1000 XP for Medicine, Scouting, and Athletics)"
            }




//Variable Check (Use for sanity check. Uncomment variables to see what they are)
//{GiveSkillExperience("Throwing", 1000)}

-> Start

===Start===

Com o anoitecer, você e seus homens armam o acampamento. Conforme a noite avança, percebe que seus homens se dividiram em dois grupos. Um parece estar contando histórias de guerra, enquanto o outro apenas conversa. #STR_Start1
-> choice1

    =choice1
        O que você fará? //{MeleeWeaponRandom} {RangedWeaponRandom} //Uncomment for bug testing
            *[Ouvir a história de {StoryName} {StoryXpText}]
                ->StoryBranch
            *[Participar da discussão sobre {DiscussionName} {DiscussionXpText}]
                ->DiscussionBranch
            *[Mandar seus homens descansar (Todos os companheiros curados e todas as tropas feridas restauradas)]
                Você manda seus homens dormir cedo e descansar o quanto puderem.
                ~ HealPartyToFull()
                ->END

===TheHunt===
    Meio ao crepitar da fogueira, a voz de um soldado grisalho narrava uma história de furtividade e perseguição. As chamas tremeluzentes pareciam espelhar a expectativa nos olhos de seus companheiros enquanto se inclinavam para ouvir. #STR_TheHunt1

"Prestem atenção, rapazes e moças," o soldado começou, "deixem-me narrar a história de nossa última caça. Era uma noite sem lua, nossos passos guiados pelas sombras e pelo farfalhar das folhas. Nossos batedores avançavam entre a vegetação rasteira, olhos atentos e sentidos alerta enquanto pressentíamos um minotauro..." #STR_TheHunt2

À medida que a história se desenrolava, os soldados sentiam-se atraídos pela narrativa, vivenciando a emoção da perseguição e a tensão que pairava no ar. As palavras do narrador pintavam um quadro vívido de astúcia e estratégia, e quando a história chegou ao fim, os soldados tinham uma nova admiração pela exploração e pela arte da caça. #STR_TheHunt3

    //Give Xp
        ~ GiveSkillExperience("Scouting",1000)
        ~ GiveSkillExperience("Tactics",1000)

        {RangedWeaponRandom:
                    -1:
                        ~ GiveSkillExperience("Bow" ,1000)
                    -2:
                        ~ GiveSkillExperience("Crossbow" ,1000)
                    -3:
                        ~ GiveSkillExperience("Throwing" ,1000)
                    -4:
                        ~ GiveSkillExperience("Gunpowder" ,1000)
                }
    -> END

===TheAmbush===
    Entre as brasas crepitantes, a voz de um soldado ecoou com um brilho malicioso nos olhos. O brilho aconchegante da fogueira iluminava os rostos ansiosos de seus camaradas enquanto se acomodavam para ouvir a história. #STR_TheAmbush1

"Aproximem-se, homens," disse o soldado com um sorriso, "e deixem-me contar sobre a emboscada que sobrevivemos. Imaginem — uma noite iluminada pela Mannslieb, as bestas-homens inimigas avançando sem perceber. Nosso plano era astuto, nossos movimentos rápidos. Atacamos com surpresa e ferocidade, virando a maré a nosso favor..." #STR_TheAmbush2

Os soldados foram transportados para uma cena de astúcia calculada e execução veloz. Risos e acenos de aprovação seguiram a conclusão da história, deixando os soldados com uma compreensão mais profunda das táticas e do poder de uma emboscada bem executada. #STR_TheAmbush3

        //Give Xp
            ~ GiveSkillExperience("Leadership",1000)
            ~ GiveSkillExperience("Tactics",1000)
            ~ GiveSkillExperience("Roguery",1000)
    -> END

===TheCharge===
    O abraço caloroso do fogo projetava sombras dançantes sobre os rostos dos soldados reunidos ao redor. Sua atenção era absorta enquanto a voz de um guerreiro endurecido pela batalha enchia o ar. #STR_Charge1

"Ouçam bem, meus amigos," o soldado começou, "a história de nossa última batalha. Era um dia banhado pelo brilho do sol poente. Nossos cavalos estavam ansiosos, suas ferraduras escavando a terra. Com um grito trovejante, carregamos..." #STR_Charge2

Os soldados quase podiam sentir a rajada de vento em seus rostos e o troar dos cascos sob eles. A história pintou um quadro vívido de unidade e bravura, deixando os soldados com uma compreensão mais profunda da equitação, do uso de armas e do poder de uma carga bem coordenada. #STR_Charge3

    //Give Xp
        ~ GiveSkillExperience("Riding",1000)
        ~ GiveSkillExperience("Polearm",1000)
        ~ GiveSkillExperience("Leadership",1000)
    -> END

===HoldingTheLine===
    Meio ao suave crepitar da fogueira, a voz de um soldado carregava o peso da determinação. O brilho das chamas parecia espelhar a resolução nos olhos de seus companheiros. #STR_HoldingTheLine1

"Ouçam com atenção, meus amigos," o soldado falou com convicção inabalável, "a história de nossa última batalha. Foi um momento de unidade inquebrantável quando nos posicionamos para resistir, escudos travados em firme defesa. Enquanto o exército morto-vivo avançava, mantivemo-nos resolutos..." #STR_HoldingTheLine2

Os soldados sentiram uma onda de solidariedade tomar conta deles, como se estivessem lado a lado com os guerreiros da história. As palavras do narrador enfatizavam a importância da liderança e das táticas, deixando os soldados com uma maior admiração pela arte da defesa. #STR_HoldingTheLine3

    //Give Xp
            ~ GiveSkillExperience("Scouting",1000)

            ~ GiveSkillExperience("Tactics",1000)

            {MeleeWeaponRandom:
                    -1:
                        ~ GiveSkillExperience("OneHanded",1000)
                    -2:
                        ~ GiveSkillExperience("TwoHanded",1000)
                    -3:
                        ~ GiveSkillExperience("Polearm",1000)
                }
    -> END

===TheBrawl===
    À luz tremeluzente da fogueira, a voz de um soldado narrava uma história de camaradagem e competição amistosa. Risos se misturavam ao crepitar das chamas enquanto seus companheiros se inclinavam, ansiosos para ouvir. #STR_TheBrawl1

"Ah, meus camaradas," o soldado riu, "deixem-me contar o que aconteceu no último treinamento! Foi uma noite de alegria que se transformou em disputa animada. Testamos nossa têmpera de brincadeira, cada golpe e aparada uma dança de habilidade..." #STR_TheBrawl2

Os soldados trocaram olhares cúmplices, suas próprias memórias de disputas amistosas vindo à mente. As palavras do narrador enfatizavam os laços de camaradagem e as lições das técnicas de combate corpo a corpo, deixando os soldados com um senso de experiência compartilhada. #STR_TheBrawl3

    //Give Xp
            ~ GiveSkillExperience("OneHanded",1000)
            ~ GiveSkillExperience("TwoHanded",1000)
            ~ GiveSkillExperience("Polearm",1000)
    -> END

===TheShootout===
    Envoltos pelo calor aconchegante da fogueira, a voz de um soldado ergueu-se com um senso de expectativa. As chamas dançavam nos olhos de seus companheiros enquanto se acomodavam para ouvir a história. #STR_TheShootout1

"Ouçam com atenção, meus camaradas," o soldado começou, "a história de nossa última batalha. Imaginem um céu carregado de nuvens, preparando o cenário para uma demonstração de destreza à distância enquanto meu regimento mirava os bestiais que se aproximavam. Arcos, bestas, facas de arremesso e armas de pólvora ocuparam o centro das atenções..." #STR_TheShootout2

Os soldados trocaram acenos, suas mentes pintando vividamente cenas de flechas e projéteis cortando o ar. As palavras do narrador ressaltavam as nuances do combate à distância, deixando os soldados com uma compreensão mais profunda das diversas habilidades com armas à distância. #STR_TheShootout3

    //Give Xp
            ~ GiveSkillExperience("Bow",750)
            ~ GiveSkillExperience("Crossbow",750)
            ~ GiveSkillExperience("Throwing",750)
            ~ GiveSkillExperience("Gunpowder",750)
    -> END

===GreatRulers===
    Banhados pelo brilho aconchegante da fogueira, um grupo de soldados se engajava em uma conversa animada sobre os grandes governantes do Velho Mundo. Suas vozes carregavam admiração e respeito, suas histórias entrelaçadas com lições de liderança e estadismo. #STR_GreatRulers1

Um soldado começou, sua voz carregada de reverência: "Falemos dos lendários governantes que moldaram nossas terras. Da última vez que ouvi, o grande Karl Franz parecia manter bem sua reputação, pois é preciso muito para governar..." #STR_GreatRulers2

À medida que as histórias fluíam, os soldados contemplavam as qualidades que tornavam esses governantes excepcionais — seu domínio da administração, a arte da liderança e o carisma que unia seus súditos. Em suas mentes, as lições de administração, liderança e charme lançavam raízes, deixando-os com uma compreensão mais profunda das responsabilidades que o poder trazia. #STR_GreatRulers3

    //Give Xp
            ~ GiveSkillExperience("Steward",1000)
            ~ GiveSkillExperience("Leadership",1000)
            ~ GiveSkillExperience("Charm",1000)
    -> END

===Craftsman===
    Envolvidos pela camaradagem da fogueira, um grupo de soldados trocava histórias de habilidade artesanal e maravilhas da engenharia. Suas vozes carregavam admiração e reverência enquanto narravam os feitos de mestres artesãos e engenheiros engenhosos. #STR_Craftsman1

"Ouçam bem, camaradas," um soldado instou, "poucos sabem disso, mas tive a bênção de aprender sobre engenharia com um anão. As fortalezas Dawi são um testemunho da arte da ferraria..." #STR_Craftsman2

À medida que as histórias se desenrolavam, os soldados maravilhavam-se com os designs intrincados e a pura engenhosidade que impulsionava esses feitos. Suas discussões mergulhavam nos domínios da ferraria, engenharia e nas maravilhas nascidas das mentes de hábeis artesãos e artesãos-anões, deixando-os com uma nova apreciação por esses ofícios vitais. #STR_Craftsman3

    //Give Xp
            ~ GiveSkillExperience("Crafting",1500)
            ~ GiveSkillExperience("Engineering",1500)
    -> END

===Negotiation===
    Sob a luz tremeluzente das chamas, um grupo de soldados se entretinha com histórias de barganha e comércio. Risos se misturavam às suas vozes enquanto compartilhavam tanto negociações bem-sucedidas quanto histórias divertidas de quando as coisas saíram errado. #STR_Negotiation1

"Ah, meus camaradas," um soldado riu, "deixem-me compartilhar a arte da barganha e a dança do comércio. De trocar com os astutos halflings a enfrentar os perspicazes mercadores de Marienburg, o caminho para um bom negócio é pavimentado de sagacidade e astúcia..." #STR_Negotiation2

Os soldados inclinaram-se, cativados pelas histórias de sagacidade e gracejo que se desenrolavam nos movimentados mercados e bazares do Velho Mundo. Eles refletiram sobre o delicado equilíbrio entre o charme, a perspicácia no comércio e os tropeços ocasionais que vinham com o território, deixando-os com uma compreensão mais profunda da arte da negociação. #STR_Negotiation3

    //Give Xp
            ~ GiveSkillExperience("Charm",1000)
            ~ GiveSkillExperience("Trade",1000)
            ~ GiveSkillExperience("Roguery",1000)
    -> END

===Traveling===
   Ao redor do fogo crepitante, um grupo de soldados compartilhava histórias de suas viagens e experiências a cavalo. Suas vozes carregavam um senso de aventura e camaradagem enquanto narravam jornadas por paisagens traiçoeiras e encontros com os habitantes do Velho Mundo. #STR_Traveling1

"Manter um cavalo de batalha saudável," declarou um soldado, "é um desafio à parte. O vínculo entre cavaleiro e montaria é uma conexão como nenhuma outra..." #STR_Traveling2

À medida que as histórias teciam sua tapeçaria de aventura, os soldados se viam transportados a terras distantes e regiões selvagens indomáveis. Eles refletiram sobre as habilidades de equitação e o vínculo inquebrantável entre um cavaleiro e sua montaria, deixando-os com uma maior apreciação pela arte de viajar a cavalo. ##STR_Traveling3

    //Give Xp
            ~ GiveSkillExperience("Riding",1500)
            ~ GiveSkillExperience("Athletics",1500)
    -> END

===Survival===
    Meio ao suave crepitar do fogo, um grupo de soldados compartilhava sua sabedoria sobre sobreviver na natureza selvagem. Suas vozes carregavam o peso da experiência enquanto narravam histórias de engenhosidade e resistência diante dos desafios da natureza. #STR_Survival1

"Ouçam bem," um soldado começou, sua voz firme e segura, "pois vou transmitir a sabedoria de como sobreviver adequadamente nas matas mais densas. Desde forragear em busca de sustento até navegar pelas florestas densas e pântanos traiçoeiros, a chave está em compreender os ritmos da terra..." #STR_Survival2

À medida que as histórias se desenrolavam, os soldados se viam imersos na arte da sobrevivência, aprendendo a ler os sinais da natureza e a se adaptar às suas exigências. As histórias enfatizavam as habilidades de medicina, exploração e atletismo, deixando os soldados com um novo respeito pelo mundo implacável mas inspirador além da segurança da civilização. #STR_Survival3

    //Give Xp
            ~ GiveSkillExperience("Medicine",1000)
            ~ GiveSkillExperience("Scouting",1000)
            ~ GiveSkillExperience("Athletics",1000)
    -> END


-> END
