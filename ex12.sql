declare
   vr_retorno varchar2(500);
   
   
begin
  
   dbms_output.put_line(om_pkg_task.fn_find_team('BETA1', 'MT_0901/13TRF/E09516',vr_retorno));
   dbms_output.put_line( vr_retorno);
end;