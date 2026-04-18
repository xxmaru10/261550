//Global story tags
# title: O Despertar do Chefe
# frequency: Special
# development: false
# illustration: orc_boss_career_2

INCLUDE include.ink

//Variables setup
VAR QuestToStart = ""

->START

===START===
Isso vem de repente, não exatamente um pensamento, nem exatamente um sentimento. Algo mais próximo do instinto. Seu coração acelera. Há algo se agitando dentro de você: excitação. Urgência. Você precisa se mexer. Você precisa MATÁ.

Uma voz sussurra, depois ruge. Ela te impulsiona.

“Maió… mió… mais forte… matá… MATÁ… WAAAAAAAAAAAAAGH!”

Um sinal dos deuses? A voz te guia, te conduz. Ignorá-la seria convidar a ira dos próprios Gork e Mork.

Você foi escolhido. VOCÊ. Recebeu a chance de se provar diante dos deuses.
Você deve se erguer. Encarar desafios. Esmagar tudo. Mas, acima de tudo, você deve MATÁ.

+ [BORA FAZÊ ISSO!]
    ~ StartQuest("Quests.Careers.OrcBossQuest1")
    ~ CloseStory()
    -> END

    
    
