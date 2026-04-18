//Global story tags
# title: O Chamado dos Deuses
# frequency: Special
# development: false
# illustration: orc_shaman_career_2

INCLUDE include.ink

//Variables setup
VAR QuestToStart = ""

->START

===START===
Depois de uma noite de dança prolongada, você acorda com uma dor de cabeça horrível. Você já teve dores de cabeça antes, mas esta é diferente.

É uma dor latejante, como se os próprios deuses estivessem sacudindo você.

Alguns rapazes se reúnem ao seu redor, observando com admiração e medo. Você cai de joelhos e vomita bile verde na terra.

Na papa malcheirosa, você vê pedaços de carne e lascas de osso organizados na imagem de um santuário, ídolos para Gork e Mork.

Os deuses estão chamando, é hora de responder.

+ [Onde fica esse lugar lazarento!?]
    ~ StartQuest("Quests.Careers.OrcShamanQuest1")
    ~ CloseStory()
    -> END

