//Global story tags
# title: Mercador Viajante
# frequency: Abundant
# development: false
# illustration: trader

INCLUDE include.ink

->START

===START===
Enquanto viaja pelas estradas empoeiradas, uma visão única se revela diante de seus olhos — uma caravana colorida, um empório móvel em meio à paisagem silenciosa. #STR_Start1
Ao se aproximar, um mercador viajante vem ao seu encontro. Com um sorriso acolhedor, ele compartilha contos de reinos distantes e o convida a examinar suas mercadorias. #STR_Start2
->choices
    
    =choices
    +[Ver as mercadorias]
        ~ OpenInventoryAsTrade()
    ->AfterShopping
    *[Continuar sua jornada (Sair)] 
        Você decide que é melhor seguir viagem por ora. #STR_Leave
        ->END

===AfterShopping===
Você conclui sua exploração da variedade de tesouros do mercante e, com uma reverência respeitosa, ele expressa sua gratidão pelo seu interesse e escolhas. #STR_AfterShopping
    -> END

