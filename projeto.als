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
sig Desenvolvimento in PartePrograma{	equipeDesenvolvedora: one Desenvolvedores  }


sig Desenvolvido in PartePrograma{}
/* Quando a parte do programa está sendo testado, apenas a equipe de testadores pode ser relacionada a ela*/
sig Testando in PartePrograma{   equipeTestadora: one Testadores   }
sig Testado in PartePrograma{}
sig Integrado in PartePrograma{}
sig Entregue in PartePrograma{}

/* Nenhuma parte esta no estado entregue */
pred nehumaParteEntregue[p:PartePrograma]{
	 p not in Entregue
}

/* Pelo menos uma parte sendo testada */
pred parteSendoTestada[p:Testando]{
	some p
}

/* O programa tem exatamente 3 partes */
pred ProgramaQCom3Partes[p:Programa]{
	 #p.partes = 3
}

assert ProgramaComNpartes{
		all p:PartePrograma | one p.~partes
}

assert QuantidadeEquipe{
		#Programa = 1
		#Desenvolvedores = 2
		#Testadores = 1
}



--- Testes


assert ProgramaEmDesenvolvimento{
		all p:PartePrograma | p in Desenvolvimento => (p not in (naoDesenvolvendo))
}
assert ProgramaEmTeste{
		all p:PartePrograma | p in Testando => (p in Desenvolvido and  p not in (naoTestando))
}
assert ProgramaIntegrado{
		all p:PartePrograma | p in Integrado => (p not in (naoIntegrado) and p in (desenvolvidoETestado))
}
assert ProgramaEntregue{
		all p:PartePrograma | p in Entregue => (p not in(naoEntregue) and p in (prontoParaEntrega))
}

assert ParteSendoDesenvolvida {
		all p:PartePrograma | p in Desenvolvimento => #(p.equipeDesenvolvedora) > 0
}

assert ParteSendoTestada {
		all p:PartePrograma | p in Testando => #(p.equipeTestadora) > 0
}

check ProgramaEntregue
check ProgramaIntegrado
check ProgramaEmTeste
check ProgramaEmDesenvolvimento
check QuantidadeEquipe
check ProgramaComNpartes
check ParteSendoDesenvolvida
check ParteSendoTestada




pred show[]{
}

run show for 9

