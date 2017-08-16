module sistema


abstract sig  Equipe{}

sig Desenvolvedores extends Equipe{}
sig Testadores extends Equipe{}

abstract sig PartePrograma{
}

sig Programa {
	partes: some PartePrograma
}

fact{
	all p:PartePrograma | one p.~partes
	all p:PartePrograma | p in (Desenvolvimento + Desenvolvido + Testando + Testado + Integrado +  Entregue)
}


--- Um unico programa está sendo desenvolvido 
fact{
	#Programa = 1
	#Desenvolvedores = 2
	#Testadores = 1

}

fact{
	all p:PartePrograma | p in Testando => (p in Desenvolvido and  p not in (naoTestando))
	all p:PartePrograma | p in Desenvolvimento => (p not in (naoDesenvolvendo))
	all p:PartePrograma | p in Integrado => (p not in (naoIntegrado) and p in (desenvolvidoETestado))
	all p:PartePrograma | p in Entregue => (p not in(naoEntregue) and p in (prontoParaEntrega))
}

/*Funcoes que retornam um conjunto de estados das partes do programa */
fun naoTestando: set PartePrograma{   	(Desenvolvimento + Testado + Integrado + Entregue)   }

fun naoDesenvolvendo: set PartePrograma{ 	(Desenvolvido + Testando + Testado + Integrado + Entregue)  }

fun desenvolvidoETestado: set PartePrograma {  (Desenvolvido & Testado)  } 

fun prontoParaEntrega: set PartePrograma {	(Desenvolvido & Testado & Integrado)   }

fun naoIntegrado: set PartePrograma{ 	(Desenvolvimento + Testando)   }

fun naoEntregue: set PartePrograma{	(Desenvolvimento + Testando)   }


-- Estados que as partes do programa podem estar.

/* Quando a parte do programa está em desenvolvimento, apenas a equipe de desenvolvedores pode ser relacionada a ela*/
sig Desenvolvimento in PartePrograma{	equipe: one Desenvolvedores  }

/* Quando a parte do programa está sendo testado, apenas a equipe de testadores pode ser relacionada a ela*/
sig Desenvolvido in PartePrograma{}
sig Testando in PartePrograma{   equipe3: one Testadores   }
sig Testado in PartePrograma{}
sig Integrado in PartePrograma{}
sig Entregue in PartePrograma{}

pred nehumaParteEntregue[p:PartePrograma]{
	#p.equipe >= 1
}

pred parteSendoTestada[p:Testando]{
	some p
}

pred ProgramaCom3Partes[p:Programa]{
	 #p.partes = 3
}

pred show[]{
}

run show for 9

