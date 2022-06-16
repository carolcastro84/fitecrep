CREATE OR REPLACE PACKAGE om_pkg_task IS
  function fn_find_team (  pr_nome   IN teams.nome%type,
                           pr_area   IN varchar2,
                           pr_return OUT varchar2) return integer;

end;
/
CREATE OR REPLACE PACKAGE BODY om_pkg_task IS

   function fn_find_team ( pr_nome   IN teams.nome%type,
                           pr_area   IN varchar2,
                           pr_return OUT varchar2) return integer is
                           
     cursor cr_team (pr_area varchar2) is
     select status,
            oid
       from teams
      where nome_b1 || '/' || nome_b2  || '/' || nome_b3 = pr_area
      order by status desc;
      
     vr_oid    teams.oid%type;
     vr_status teams.status%type; 
     vr_retorno number := 0;
     
     ex_broke exception;
     begin
        pr_return := 'Operação finalizada com sucesso, existe equipe ativa na área solicitada!';
        
        open cr_team(pr_area);
        fetch cr_team into   vr_status, vr_oid;
        if cr_team%notfound then
          pr_return := 'Operação finalizada com sucesso, não existe equipe na área solicitada!';
          vr_oid := 0;
          vr_retorno := -1;
        elsif vr_status = 0 then
          pr_return := 'Operação finalizada com sucesso, não existe equipe ativa na área solicitada!';
          vr_oid := 0;
          vr_retorno := -2;
        end if;
        
        insert into task (oid, nome, data_criacao, equipe_responsavel)
               values ( ttask_sq.nextval, pr_nome, sysdate, vr_oid);
       -- raise ex_broke;
        insert into logproc(oid, data,codigo,descricao)
            values (tlogproc_sq.nextval, sysdate, vr_retorno, pr_return);
        
        COMMIT;
        
        return vr_retorno;
     EXCEPTION 
       WHEN OTHERS THEN
         pr_return := SQLERRM || ' Operação finalizada com erro. Consulte log!' ;
         ROLLBACK;
         insert into logproc(oid, data,codigo,descricao)
            values (tlogproc_sq.nextval, sysdate, vr_retorno, pr_return);
         commit;
         return -3;
     end;
END;
/
