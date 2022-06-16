create table TEAMS
(
  oid     NUMBER not null,
  nome    VARCHAR2(100),
  nome_b1 VARCHAR2(100),
  nome_b2 VARCHAR2(100),
  nome_b3 VARCHAR2(100),
  status  INTEGER
);
/
alter table TEAMS
  add constraint OID_PK primary key (OID)
  using index;
/
alter table TEAMS
  add constraint STATUS_CK
  check (status in (0,1));
/
create table TASK
(
  oid                NUMBER not null,
  nome               VARCHAR2(100),
  data_criacao       DATE,
  equipe_responsavel NUMBER
);
/
alter table TASK
  add constraint OIDTASK_PK primary key (OID)
  using index;
/
create table LOGPROC
(
  oid       NUMBER not null,
  data      DATE,
  codigo    NUMBER,
  descricao VARCHAR2(500)
);
/
-- Create/Recreate primary, unique and foreign key constraints 
alter table LOGPROC
  add constraint OIDLOG_PK primary key (OID)
  using index;
/
create sequence tteams_sq
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50
order;
/
create sequence ttask_sq
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50
order;
/
create sequence tlogproc_sq
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 50
order;
/
CREATE OR REPLACE TRIGGER TRG_TEAMS_BFRINS
BEFORE INSERT ON TEAMS

FOR EACH ROW

BEGIN

  IF :NEW.OID IS NULL THEN
    :NEW.OID := TTEAMS_SQ.NEXTVAL;
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20100,'ERRO GERACAO SEQUENCE TEAMS!');
END;
/
CREATE OR REPLACE TRIGGER TRG_TASK_BFRINS
BEFORE INSERT ON TASK

FOR EACH ROW

BEGIN

  IF :NEW.OID IS NULL THEN
    :NEW.OID := TTASK_SQ.NEXTVAL;
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20100,'ERRO GERACAO SEQUENCE TASK!');
END;
/
CREATE OR REPLACE TRIGGER TRG_TLOGPROC_BFRINS
BEFORE INSERT ON LOGPROC

FOR EACH ROW

BEGIN

  IF :NEW.OID IS NULL THEN
    :NEW.OID := TLOGPROC_SQ.NEXTVAL;
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20100,'ERRO GERACAO SEQUENCE LOGPROC!');
END;
/
INSERT INTO TEAMS (NOME, NOME_B1, NOME_B2, NOME_B3,STATUS) VALUES ('ALPHA1', 'MT_07019', '13TRF','E08796',0);
/
INSERT INTO TEAMS (NOME, NOME_B1, NOME_B2, NOME_B3,STATUS) VALUES ('BETA2', 'MT_11606', '13TRF','E08115',1);
/
INSERT INTO TEAMS (NOME, NOME_B1, NOME_B2, NOME_B3,STATUS) VALUES ('BETA1', 'MT_07019', '13TRF','E09516',1);
/
COMMIT;
/