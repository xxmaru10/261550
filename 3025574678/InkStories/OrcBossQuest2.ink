//Global story tags
# title: A Ascens�o do Grande Chefe
# frequency: Special
# development: false
# illustration: orc_boss_career_2

INCLUDE include.ink

//Variables setup
VAR QuestToStart = ""

->START

===START===
Sob o olhar atento de Gork e Mork, você se provou repetidas vezes. Você é um Chefe, um guerreiro, você é a morte no campo de batalha e incontáveis cadáveres jazem em seu rastro.

Seu bando de mulekes te segue, te teme, te respeita. Eles sabem que você os guiará para as maiores lutas e os melhores saques.

Você se tornou um chefe entre chefes, mas os deuses não estão satisfeitos — nunca estão, nunca estarão. Ainda há mais a ser feito.

+ [EU VÔ SÊ O MAIÓ QUE JÁ TEVE!!]
    -> confirm_big_boss

===confirm_big_boss===
Você olha para seus mulekes; eles estão inquietos, estão prontos. Você olha para o horizonte; a estrada tem sido longa, está repleta de saques, brilhantes e os cadáveres de todos os nanicos que se opuseram a você.

Nenhum inimigo ousa te encarar em batalha aberta, então você deve levar a luta até eles, arrancá-los de suas muralhas e arrastá-los gritando de suas casas.

A hora é agora, a maré verde sob seu comando vai afogar o mundo.

+ [ESMAGÁ TODO MUNDO!! WAAAAAAAAAAAAAAAAGH!!!]
    ~ StartQuest("Quests.Careers.OrcBossQuest2")
    ~ CloseStory()
    -> END
