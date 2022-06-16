create sequence om_record_sq
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50
order;
/
create sequence tcall_sq
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50
order;
/
create or replace procedure pc_refresh_record(pr_tipo    tcall.tipo%type,
                                              pr_subtipo tcall.tipo%type) is


 cursor cr_natureza (pr_tipo     om_record_natureza.tipo%type,
                     pr_subtipo  om_record_natureza.subtipo%type) is
 select natureza
   from om_record_natureza
  where tipo = pr_tipo
    and subtipo = pr_subtipo;

 vr_natureza   om_record_natureza.natureza%type;
begin

 open cr_natureza(pr_tipo, pr_subtipo);
 fetch cr_natureza into vr_natureza;

 if cr_natureza%notfound then
   vr_natureza := 0;
 end if;

 close cr_natureza;

 insert into om_record (oid, tipo, subtipo, natureza, data_criacao)
      values (om_record_sq.nextval, pr_tipo, pr_subtipo, vr_natureza, sysdate);


 exception
   when others then
     RAISE_application_error(-20500, SQLERRM);
     ROLLBACK;
end;
/
CREATE OR REPLACE TRIGGER TRG_TCALL_BFRINS
BEFORE INSERT ON TCALL

FOR EACH ROW

BEGIN

  IF :NEW.OID IS NULL THEN
    :NEW.OID := TCALL_SQ.NEXTVAL;
  END IF;
  
  PC_REFRESH_RECORD(:NEW.TIPO, :NEW.SUBTIPO);

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20100,'ERRO GERACAO SEQUENCE TCALL!');

END;
/
