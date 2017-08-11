

sig Equipe {
	alunos: set Aluno

}

abstract sig Aluno {

}
sig Desenvolvedor extends Aluno  {

}


sig Testador extends Aluno {
	
}

fact {

	
	all e:Equipe| some e.alunos

 
	 all e:Aluno{
one e.~alunos
}

}

pred show[]{
}

run show for 3
