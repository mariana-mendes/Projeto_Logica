module sistema


sig Equipe {
	alunos: set Aluno
}

abstract sig Aluno {}

sig Desenvolvedor extends Aluno  {}
sig Testador extends Aluno {}

fact {
	all e:Equipe| some e.alunos
	#Equipe = 3
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
run show for 3
