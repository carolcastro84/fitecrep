select case when nota < 8 then null else a.nome end as nome,
       n.nota,
       a.valor
  from alunos a,
       notas n
 where a.valor between n.valor_min and n.valor_max 
 order by nota desc, a.nome;