module sistema


sig Equipe {
	alunos: set Aluno
}

abstract sig Aluno {}

sig Desenvolvedor extends Equipe  {}
sig Testador extends Equipe {}

fact {
	all e:Equipe| some e.alunos
	#Desenvolvedor = 2
	#Testador = 1


	// para todo aluno, ele está contido em apenas um set de alunos
	all e:Aluno{
		one e.~alunos
	}
}

--- Programa que está sendo desenvolvido possui 4 estados diferentes.
sig Programa {}

sig Desenvolvimento in Programa{}
sig Testando in Programa{}
sig Integrado in Programa{}
sig Entregue in Programa{}




pred show[]{
}
run show for 9

