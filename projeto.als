module sistema


abstract sig  Equipe{}

sig Desenvolvedores extends Equipe{}
sig Testadores extends Equipe{}

abstract sig PartePrograma{
	equipe: lone Equipe
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
	all p:PartePrograma | p in Testando => (p in Desenvolvido and  p not in (Desenvolvimento + Testado + Integrado + Entregue))
	all p:PartePrograma | p in Desenvolvimento => (p not in (Desenvolvido + Testando + Testado + Integrado + Entregue))
	
}


-- Se a parte estiver sendo desenvolvida por alguma equipe e 

fact{
	all p:PartePrograma |  #p.equipe = 1 <=> ( (p.equipe in Testadores <=> p in Testando) and (p.equipe in Desenvolvedores <=> p in Desenvolvimento))


}

--- Estados que as partes do programa podem estar 
sig Desenvolvimento in PartePrograma{}
sig Desenvolvido in PartePrograma{}
sig Testando in PartePrograma{}
sig Testado in PartePrograma{}
sig Integrado in PartePrograma{}
sig Entregue in PartePrograma{}

pred show[]{
}
run show for 9

