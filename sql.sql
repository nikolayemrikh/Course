--------------------------------------------------------
--  File created - Wednesday-April-15-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence CUSTOMER_S
--------------------------------------------------------

   CREATE SEQUENCE  "CUSTOMER_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Sequence DISTANCE_S
--------------------------------------------------------

   CREATE SEQUENCE  "DISTANCE_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 47 NOCACHE  ORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Sequence LOGON_S
--------------------------------------------------------

   CREATE SEQUENCE  "LOGON_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 143 NOCACHE  ORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Sequence PERSON_S
--------------------------------------------------------

   CREATE SEQUENCE  "PERSON_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 15 NOCACHE  ORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Sequence ROUTE_S
--------------------------------------------------------

   CREATE SEQUENCE  "ROUTE_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 71 NOCACHE  ORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Sequence SCHEDULE_S
--------------------------------------------------------

   CREATE SEQUENCE  "SCHEDULE_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 175 NOCACHE  ORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Sequence STATUS_S
--------------------------------------------------------

   CREATE SEQUENCE  "STATUS_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Table CUSTOMER
--------------------------------------------------------

  CREATE TABLE "CUSTOMER" ("ID" NUMBER(4,0), "FIRST_NAME" VARCHAR2(20), "ADDRESS" VARCHAR2(400), "E_MAIL" VARCHAR2(100), "PHONE_NUMBER" VARCHAR2(100))
--------------------------------------------------------
--  DDL for Table DISTANCE
--------------------------------------------------------

  CREATE TABLE "DISTANCE" ("DISTANCE_ID" NUMBER(4,0), "DIST" NUMBER(9,0), "FIRSTCITY" VARCHAR2(40), "LASTCITY" VARCHAR2(40), "ROUTE_ID" VARCHAR2(20))
--------------------------------------------------------
--  DDL for Table DISTANCE_ALTER_TABLE
--------------------------------------------------------

  CREATE TABLE "DISTANCE_ALTER_TABLE" ("DIST" NUMBER(9,0), "DISTANCE_ID" NUMBER(4,0))
--------------------------------------------------------
--  DDL for Table LOGON_
--------------------------------------------------------

  CREATE TABLE "LOGON_" ("ID" NUMBER(4,0), "PERSON" NUMBER(4,0), "IPADDRESS" VARCHAR2(15), "DATE_" DATE)
--------------------------------------------------------
--  DDL for Table PERSON
--------------------------------------------------------

  CREATE TABLE "PERSON" ("ID" NUMBER(4,0), "STATUS" NUMBER(4,0), "LASTNAME" VARCHAR2(50), "FIRSTNAME" VARCHAR2(50), "MIDDLENAME" VARCHAR2(50), "LOGIN" VARCHAR2(9), "PASSWORD" VARCHAR2(32))
--------------------------------------------------------
--  DDL for Table ROUTE
--------------------------------------------------------

  CREATE TABLE "ROUTE" ("ROUTE_ID" NUMBER(4,0), "FIRSTCITY" VARCHAR2(9), "LASTCITY" VARCHAR2(9), "DT" TIMESTAMP (6), "TPD" NUMBER(9,0), "DIST" NUMBER(9,0), "INTER" INTERVAL DAY (9) TO SECOND (3), "SPEED" NUMBER(3,0))
--------------------------------------------------------
--  DDL for Table SCHEDULE
--------------------------------------------------------

  CREATE TABLE "SCHEDULE" ("SCH_ID" NUMBER(4,0), "FIRSTCITY" VARCHAR2(40), "LASTCITY" VARCHAR2(40), "TRAVEL_TIME" VARCHAR2(40), "DT" VARCHAR2(40), "AT" VARCHAR2(40), "DIST" NUMBER(9,0), "ROUTE_ID" NUMBER(9,0), "HELP_ID" NUMBER(4,0))
--------------------------------------------------------
--  DDL for Table STATUS
--------------------------------------------------------

  CREATE TABLE "STATUS" ("ID" NUMBER(4,0), "NAME" VARCHAR2(9))
/*REM INSERTING into DISTANCE
SET DEFINE OFF;
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (25,14,'koza','spb','66');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (26,66,'krsk','kozulka','66');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (33,44,'qwe','wqe','66');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (28,167,'msk','koza','68');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (44,12,'qwe','e','66');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (37,167,'msk','koza','167');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (38,12,'msk','koza','70');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (39,44,'qwe','wqe','66');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (45,122,'sad','sda','122');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (46,12,'sad','qwe','70');*/
REM INSERTING into DISTANCE_ALTER_TABLE
SET DEFINE OFF;
Insert into DISTANCE_ALTER_TABLE (DIST,DISTANCE_ID) values (24,70);
REM INSERTING into PERSON
SET DEFINE OFF;
Insert into PERSON (ID,STATUS,LASTNAME,FIRSTNAME,MIDDLENAME,LOGIN,PASSWORD) values (1,1,'Emrikh','Nikolay','Andreevich','redishko','b5ae98b0f27a04f7529c60808b9faae9');
Insert into PERSON (ID,STATUS,LASTNAME,FIRSTNAME,MIDDLENAME,LOGIN,PASSWORD) values (12,2,'knjk','bkbjk','mnk','kjnj','6dfd0557632d59e2a12b8e04b3d0b588');
Insert into PERSON (ID,STATUS,LASTNAME,FIRSTNAME,MIDDLENAME,LOGIN,PASSWORD) values (3,2,'dsa','sda','sad','redsa','b5ae98b0f27a04f7529c60808b9faae9');
Insert into PERSON (ID,STATUS,LASTNAME,FIRSTNAME,MIDDLENAME,LOGIN,PASSWORD) values (13,1,'sd','asd','qwe','redishko1','6dfd0557632d59e2a12b8e04b3d0b588');
Insert into PERSON (ID,STATUS,LASTNAME,FIRSTNAME,MIDDLENAME,LOGIN,PASSWORD) values (14,2,'sdad','ewqq','weqe','qsadc','6dfd0557632d59e2a12b8e04b3d0b588');
Insert into PERSON (ID,STATUS,LASTNAME,FIRSTNAME,MIDDLENAME,LOGIN,PASSWORD) values (11,1,'klnjh','bknjml','mlklmkl','nkjhvu','b5ae98b0f27a04f7529c60808b9faae9');
/*REM INSERTING into ROUTE
SET DEFINE OFF;
Insert into ROUTE (ROUTE_ID,FIRSTCITY,LASTCITY,DT,TPD,DIST,INTER,SPEED) values (66,'msk','spb',to_timestamp('24-MAR-15 12.06.00.000000000','DD-MON-RR HH.MI.SSXFF'),4,192,'+00 02:00:00.000000',60);
Insert into ROUTE (ROUTE_ID,FIRSTCITY,LASTCITY,DT,TPD,DIST,INTER,SPEED) values (70,'qw','sad',to_timestamp('08-MAR-15 01.24.00.000000000','DD-MON-RR HH.MI.SSXFF'),2,24,'+00 03:25:00.000000',90);
Insert into ROUTE (ROUTE_ID,FIRSTCITY,LASTCITY,DT,TPD,DIST,INTER,SPEED) values (68,'krsk','achi',to_timestamp('08-MAR-15 01.24.00.000000000','DD-MON-RR HH.MI.SSXFF'),3,623,'+00 03:00:00.000000',90);*/
REM INSERTING into STATUS
SET DEFINE OFF;
Insert into STATUS (ID,NAME) values (1,'Guest');
Insert into STATUS (ID,NAME) values (2,'User');
Insert into STATUS (ID,NAME) values (3,'Admin');
--------------------------------------------------------
--  DDL for Index CUSTOMER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CUSTOMER_PK" ON "CUSTOMER" ("ID")
--------------------------------------------------------
--  DDL for Index DISTANCE_ALTER_TABLE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DISTANCE_ALTER_TABLE_PK" ON "DISTANCE_ALTER_TABLE" ("DISTANCE_ID")
--------------------------------------------------------
--  Constraints for Table CUSTOMER
--------------------------------------------------------

  ALTER TABLE "CUSTOMER" ADD CONSTRAINT "CUSTOMER_PK" PRIMARY KEY ("ID") ENABLE
 
  ALTER TABLE "CUSTOMER" MODIFY ("ID" NOT NULL ENABLE)
--------------------------------------------------------
--  Constraints for Table DISTANCE
--------------------------------------------------------

  ALTER TABLE "DISTANCE" ADD PRIMARY KEY ("DISTANCE_ID") ENABLE
--------------------------------------------------------
--  Constraints for Table SCHEDULE
--------------------------------------------------------

  ALTER TABLE "SCHEDULE" ADD PRIMARY KEY ("SCH_ID") ENABLE
--------------------------------------------------------
--  Constraints for Table DISTANCE_ALTER_TABLE
--------------------------------------------------------

  ALTER TABLE "DISTANCE_ALTER_TABLE" ADD CONSTRAINT "DISTANCE_ALTER_TABLE_PK" PRIMARY KEY ("DISTANCE_ID") ENABLE
 
  ALTER TABLE "DISTANCE_ALTER_TABLE" MODIFY ("DISTANCE_ID" NOT NULL ENABLE)
--------------------------------------------------------
--  Constraints for Table STATUS
--------------------------------------------------------

  ALTER TABLE "STATUS" MODIFY ("NAME" NOT NULL ENABLE)
 
  ALTER TABLE "STATUS" ADD CHECK (name IN ('Guest','User','Admin')) ENABLE
 
  ALTER TABLE "STATUS" ADD PRIMARY KEY ("ID") ENABLE
--------------------------------------------------------
--  Constraints for Table ROUTE
--------------------------------------------------------

  ALTER TABLE "ROUTE" ADD PRIMARY KEY ("ROUTE_ID") ENABLE
--------------------------------------------------------
--  Constraints for Table PERSON
--------------------------------------------------------

  ALTER TABLE "PERSON" MODIFY ("LASTNAME" NOT NULL ENABLE)
 
  ALTER TABLE "PERSON" MODIFY ("FIRSTNAME" NOT NULL ENABLE)
 
  ALTER TABLE "PERSON" MODIFY ("LOGIN" NOT NULL ENABLE)
 
  ALTER TABLE "PERSON" MODIFY ("PASSWORD" NOT NULL ENABLE)
 
  ALTER TABLE "PERSON" ADD PRIMARY KEY ("ID") ENABLE
 
  ALTER TABLE "PERSON" ADD UNIQUE ("LOGIN") ENABLE
--------------------------------------------------------
--  Constraints for Table LOGON_
--------------------------------------------------------

  ALTER TABLE "LOGON_" MODIFY ("PERSON" NOT NULL ENABLE)
 
  ALTER TABLE "LOGON_" MODIFY ("IPADDRESS" NOT NULL ENABLE)
 
  ALTER TABLE "LOGON_" MODIFY ("DATE_" NOT NULL ENABLE)
 
  ALTER TABLE "LOGON_" ADD PRIMARY KEY ("ID") ENABLE
--------------------------------------------------------
--  DDL for Trigger ALTER_TRIG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ALTER_TRIG" 
AFTER UPDATE ON distance
DECLARE dis NUMBER(9);
 rid NUMBER(9);
BEGIN
SELECT distance_id INTO rid FROM distance_alter_table;
SELECT SUM(dist) INTO dis FROM distance WHERE route_id = rid;
UPDATE distance_alter_table SET dist = dis;
END;
ALTER TRIGGER "ALTER_TRIG" ENABLE
--------------------------------------------------------
--  DDL for Trigger CUSTOMER_T
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "CUSTOMER_T" 
BEFORE INSERT ON customer 
FOR EACH ROW 
BEGIN
    SELECT customer_s.NEXTVAL 
    INTO :new.id FROM DUAL; 
END;
ALTER TRIGGER "CUSTOMER_T" ENABLE
--------------------------------------------------------
--  DDL for Trigger DISTANCE_T
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DISTANCE_T" 
BEFORE INSERT ON distance
FOR EACH ROW 
BEGIN
SELECT distance_s.NEXTVAL 
INTO :new.distance_id FROM DUAL; 
END;
ALTER TRIGGER "DISTANCE_T" ENABLE
--------------------------------------------------------
--  DDL for Trigger DR_IUD_T
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DR_IUD_T" 
AFTER INSERT OR DELETE OR UPDATE ON distance
FOR EACH ROW
DECLARE dis NUMBER(9);
BEGIN
IF inserting THEN
    UPDATE route SET route.dist = (NVL(route.dist,0) + (:new.dist))
    WHERE (route.route_id IN (:new.route_id));
ELSIF deleting THEN
    UPDATE route SET route.dist = (NVL(route.dist,0) - (:old.dist))
    WHERE (route.route_id IN (:old.route_id));
ELSIF updating THEN
    --SELECT SUM(dist) INTO dis FROM distance WHERE route_id = :new.route_id;
    UPDATE distance_alter_table SET distance_id = :new.route_id;
END IF;
END;
ALTER TRIGGER "DR_IUD_T" ENABLE
--------------------------------------------------------
--  DDL for Trigger LOGON_T
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "LOGON_T" 
BEFORE INSERT ON logon_ 
FOR EACH ROW 
BEGIN 
SELECT logon_s.NEXTVAL 
INTO :new.id FROM DUAL; 
END;
ALTER TRIGGER "LOGON_T" ENABLE
--------------------------------------------------------
--  DDL for Trigger PERSON_T
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PERSON_T" 
BEFORE INSERT ON person 
FOR EACH ROW 
BEGIN 
SELECT person_s.NEXTVAL 
INTO :new.id FROM DUAL; 
END;
ALTER TRIGGER "PERSON_T" ENABLE
--------------------------------------------------------
--  DDL for Trigger ROUTE_T
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ROUTE_T" 
BEFORE INSERT ON route 
FOR EACH ROW 
BEGIN
    SELECT route_s.NEXTVAL 
    INTO :new.route_id FROM DUAL; 
END;
ALTER TRIGGER "ROUTE_T" ENABLE
--------------------------------------------------------
--  DDL for Trigger ROUTE_TO
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ROUTE_TO" 
after INSERT OR DELETE OR UPDATE ON route
FOR EACH ROW
DECLARE
k number(4);
tpd_local NUMBER(9);
next_DT TIMESTAMP(6);
next_AT TIMESTAMP(6);
max_k NUMBER(4);
BEGIN
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF inserting THEN
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
k:=1;
tpd_local  := :new.TPD;
next_DT := :new.DT;
 
INSERT INTO schedule(firstCity, lastCity, travel_time, DT, AT, dist, route_id, help_id) VALUES (:new.firstCity, :new.lastCity, 
  (:new.dist / :new.speed)*60, TO_CHAR(:new.DT, 'DD.MM.YYYY HH24:MI'), TO_CHAR((NUMTODSINTERVAL((:new.dist / :new.speed), 'HOUR') + :new.DT),'DD.MM.YYYY HH24:MI'), :new.dist, :new.route_id, k);
 
IF (tpd_local = 2 OR tpd_local > 2) THEN
FOR i IN 2..tpd_local
LOOP
k := k+1;
next_DT := next_DT + :new.inter;
next_AT := (NUMTODSINTERVAL((:new.dist / :new.speed), 'HOUR') + next_DT);
INSERT INTO schedule(firstCity, lastCity, travel_time, DT, AT, dist, route_id, help_id) VALUES (:new.firstCity, :new.lastCity, 
  (:new.dist / :new.speed)*60, TO_CHAR(next_DT, 'DD.MM.YYYY HH24:MI'), TO_CHAR(next_AT, 'DD.MM.YYYY HH24:MI'), :new.dist, :new.route_id, k);
END LOOP;
END IF;
 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ELSIF deleting THEN
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
DELETE FROM schedule WHERE schedule.route_id = :old.route_id;
 
 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ELSIF updating THEN
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF :new.TPD > :old.TPD THEN
 
tpd_local  := :new.TPD;
next_DT := :new.DT;
 
FOR i IN 1..tpd_local
LOOP
k:=k+1;
next_DT := next_DT + :new.inter;
next_AT := (NUMTODSINTERVAL((:new.dist / :new.speed), 'HOUR') + next_DT);
UPDATE schedule
SET firstCity = :new.firstCity, lastCity = :new.lastCity, travel_time = (:new.dist / :new.speed)*60, DT = TO_CHAR(next_DT, 'DD.MM.YYYY HH24:MI'), AT = TO_CHAR(next_AT, 'DD.MM.YYYY HH24:MI'), dist = :new.dist
WHERE route_id = :new.route_id AND help_id = k;
END LOOP;

SELECT MAX(help_id) INTO max_k FROM schedule WHERE route_id = :new.route_id;
SELECT DT INTO next_DT FROM schedule WHERE route_id = :new.route_id AND help_id = max_k;
SELECT AT INTO next_AT FROM schedule WHERE route_id = :new.route_id AND help_id = max_k;
k := max_k+1;
FOR i IN k..tpd_local
LOOP
next_DT:=next_DT+:new.inter;
next_AT:=next_AT+:new.inter;
INSERT INTO schedule(firstCity, lastCity, travel_time, DT, AT, dist, route_id, help_id) VALUES (:new.firstCity, :new.lastCity, 
  (:new.dist / :new.speed)*60, TO_CHAR(next_DT, 'DD.MM.YYYY HH24:MI'), TO_CHAR(next_AT, 'DD.MM.YYYY HH24:MI'), :new.dist, :new.route_id, k);
  k:=k+1;
   
END LOOP;
 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ELSIF :new.TPD < :old.TPD THEN
SELECT MAX(help_id) INTO max_k FROM schedule;
k := :new.TPD + 1;
FOR i IN :new.TPD..max_k
LOOP
DELETE FROM schedule
WHERE route_id = :new.route_id AND help_id = k;
k := k + 1;
END LOOP;
 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ELSIF :new.TPD = :old.TPD THEN
k:=1;
tpd_local  := :new.TPD;
next_DT := :new.DT;
next_AT := (NUMTODSINTERVAL((:new.dist / :new.speed), 'HOUR') + next_DT);
FOR i IN 1..tpd_local
LOOP
UPDATE schedule
SET firstCity = :new.firstCity, lastCity = :new.lastCity, travel_time = (:new.dist / :new.speed)*60, DT = TO_CHAR(next_DT, 'DD.MM.YYYY HH24:MI'), AT = TO_CHAR(next_AT, 'DD.MM.YYYY HH24:MI'), dist = :new.dist
WHERE route_id = :new.route_id AND help_id = k;
k:=k+1;
next_DT := next_DT + :new.inter;
next_AT := (NUMTODSINTERVAL((:new.dist / :new.speed), 'HOUR') + next_DT);
END LOOP;
END IF;
 
 
END IF;
END;
ALTER TRIGGER "ROUTE_TO" ENABLE
--------------------------------------------------------
--  DDL for Trigger SCHEDULE_T
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SCHEDULE_T" 
BEFORE INSERT ON schedule 
FOR EACH ROW 
BEGIN
    SELECT schedule_s.NEXTVAL 
    INTO :new.sch_id FROM DUAL; 
END;
ALTER TRIGGER "SCHEDULE_T" ENABLE
--------------------------------------------------------
--  DDL for Trigger STATUS_T
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "STATUS_T" 
BEFORE INSERT ON status
FOR EACH ROW 
BEGIN 
SELECT status_s.NEXTVAL 
INTO :new.id FROM DUAL; 
END;
ALTER TRIGGER "STATUS_T" ENABLE
--------------------------------------------------------
--  DDL for Trigger TEST_TRIG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TEST_TRIG" 
AFTER UPDATE ON distance_alter_table
DECLARE dis NUMBER(4);
 rid NUMBER(9);
BEGIN
SELECT dist INTO dis FROM distance_alter_table;
SELECT DISTANCE_ID INTO rid FROM distance_alter_table;
UPDATE route SET dist = dis WHERE route_id = rid;
END;
ALTER TRIGGER "TEST_TRIG" ENABLE
