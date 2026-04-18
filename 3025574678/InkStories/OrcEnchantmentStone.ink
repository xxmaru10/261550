//Global story tags
# title: Pedra de Encantamento
# frequency: Special
# development: false
# illustration: gs_enchant_tablet_1

INCLUDE include.ink

->START

===START===
#illustration: gs_enchant_tablet_1
Cê achou uma pedra chata com uns desenho nela. Esse lado mostra umas coisa brilhante e umas linha torta — parece coisa de magia, né? 
+ [Virá essa coisa]->SecondSide
+ [Coisa burra, vai embora]->END

===SecondSide===
#illustration: gs_enchant_tablet_2
Viro ela, né! Esse lado tem desenho diferente — mais coisa brilhante e um picadô de verdade no fim com uns brilinho nele! 
+ [Virá essa coisa de novo]->ThirdSide
+ [Coisa burra, vai embora]->END

===ThirdSide===
#illustration: none
Cê tá procurando o quê? Pedra não pode tê 3 lado, seu tonto! 

+ [Virá essa coisa de NOVO]->START
+ [Coisa burra, vai embora]->END
