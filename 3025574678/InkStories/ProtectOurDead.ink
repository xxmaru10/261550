//Global story tags
# title: Protejam Nossos Mortos
# frequency: Uncommon
# development: true
# illustration: campfirenight

INCLUDE include.ink

VAR PlayerWin = false
VAR PartyCanRaiseDead = false
            ~ PartyCanRaiseDead = PartyHasNecromancer(false)
VAR RaiseDeadSkillCheckTest = false
            ~ RaiseDeadSkillCheckTest = perform_party_skill_check("Spellcraft", 25)
//Scenarios notes
    //Rarity: COMMON
    //Repeatable: YES
    
    //Restrictions
        //Terrain: Empire, Bretonnia, Telia, Estalia, or Border Princes culture
    
    //Triggers:
        //While travelling on campaign map
    
    //Scenario Explanation
    
        //Main: You are traveling and a peasant asks you to rid the local graveyard of a necromancer.
		// Rewards: faith exp + small amount of gold or skeleton troops + staff.

->START

===START===
Ao final da marcha do dia, seus homens estão montando acampamento. Você sabe que o pôr do sol virá em breve, e estas terras são perigosas, especialmente à noite. #STR_Start1
De repente, um de seus homens grita um aviso. Olhando para cima, você vê um aldeão local se aproximando. Ele parece estar desarmado. #illustration: stranger #STR_Start2
O homem explica que um necromante recém-chegado começou a erguer os mortos do cemitério da aldeia. Embora o aldeão seja bastante pobre, ele diz que pagarão uma recompensa modesta a quem matar o necromante. #STR_Start3 
-> choices

    =choices
    *[Nós mataremos este necromante para você.] ->accept
    *[Isto é um ultraje, aqueles esqueletos deveriam me pertencer!] ->accept
    *[Talvez em outra hora. Temos assuntos mais urgentes para tratar.] -> deny
    
    =accept
    O aldeão explica que o necromante aparece todas as noites com alguns esqueletos. Com esse conhecimento, você traça um plano para emboscá-lo no cemitério.  #STR_Accept1
    
    ->enterArena
    
    =deny
    ->END

    =enterArena
    //~ OpenGraveyardMission()
    ...
    {PlayerWin: Conforme o necromante cai, você agradece a insert_deity_name. #STR_PlayerWin1}

    ->BattleResult
    
===BattleResult===
        *[Retornar à aldeia e reivindicar a recompensa {GiveGold(500)}{GiveSkillExperience("Faith",1000)}]
		-> END
		
        //Necromancer option
        *{PartyCanRaiseDead}[Tentar vincular os esqueletos derrotados à sua vontade, {print_party_skill_chance("Spellcraft", 25)}]
                {RaiseDeadSkillCheckTest: -> raiseSucceed | -> raiseFail}
    
        =raiseSucceed
        Tendo erguido os mortos com sucesso, você revira o necromante em busca de algo de valor. {GiveItem("tor_vc_weapon_staff_nm_001", 1)} #STR_HelpNecromancerSuccess
            
            ~ChangePartyTroopCount("tor_vc_skeleton",8)
            -> END
        
        =raiseFail
        Você pode ter falhado em erguer os mortos, mas ao menos o necromante deixou um cajado útil para trás. {GiveItem("tor_vc_weapon_staff_nm_001", 1)} #STR_HelpNecromancerFail
            -> END

