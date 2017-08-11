module sistema


abstract sig Equipe {
	alunos: some Aluno
}

sig Aluno {}

sig Desenvolvedores extends Equipe  {}

sig Testadores extends Equipe {}

fact {
	// Um aluno está contido em um único set de alunos
	all a:Aluno | one a.~alunos
}


fact{
	#Desenvolvedores = 2
	#Testadores = 1


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

