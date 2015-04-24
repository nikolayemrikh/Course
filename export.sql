--------------------------------------------------------
--  File created - Wednesday-April-08-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence CUSTOMER_S
--------------------------------------------------------

   CREATE SEQUENCE  "CUSTOMER_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence DISTANCE_S
--------------------------------------------------------

   CREATE SEQUENCE  "DISTANCE_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 31 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence LOGON_S
--------------------------------------------------------

   CREATE SEQUENCE  "LOGON_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 61 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence PERSON_S
--------------------------------------------------------

   CREATE SEQUENCE  "PERSON_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 3 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ROUTE_S
--------------------------------------------------------

   CREATE SEQUENCE  "ROUTE_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 68 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SCHEDULE_S
--------------------------------------------------------

   CREATE SEQUENCE  "SCHEDULE_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 163 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence STATUS_S
--------------------------------------------------------

   CREATE SEQUENCE  "STATUS_S"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table CUSTOMER
--------------------------------------------------------

  CREATE TABLE "CUSTOMER" 
   (	"ID" NUMBER(4,0), 
	"FIRST_NAME" VARCHAR2(20), 
	"ADDRESS" VARCHAR2(400), 
	"E_MAIL" VARCHAR2(100), 
	"PHONE_NUMBER" VARCHAR2(100)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table DISTANCE
--------------------------------------------------------

  CREATE TABLE "DISTANCE" 
   (	"DISTANCE_ID" NUMBER(4,0), 
	"DIST" NUMBER(9,0), 
	"FIRSTCITY" VARCHAR2(40), 
	"LASTCITY" VARCHAR2(40), 
	"ROUTE_ID" VARCHAR2(20)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table DISTANCE_ALTER_TABLE
--------------------------------------------------------

  CREATE TABLE "DISTANCE_ALTER_TABLE" 
   (	"DIST" NUMBER(9,0), 
	"DISTANCE_ID" NUMBER(4,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table LOGON_
--------------------------------------------------------

  CREATE TABLE "LOGON_" 
   (	"ID" NUMBER(4,0), 
	"PERSON" NUMBER(4,0), 
	"IPADDRESS" VARCHAR2(15), 
	"DATE_" DATE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table PERSON
--------------------------------------------------------

  CREATE TABLE "PERSON" 
   (	"ID" NUMBER(4,0), 
	"STATUS" NUMBER(4,0), 
	"LASTNAME" VARCHAR2(50), 
	"FIRSTNAME" VARCHAR2(50), 
	"MIDDLENAME" VARCHAR2(50), 
	"LOGIN" VARCHAR2(9), 
	"PASSWORD" VARCHAR2(32)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table ROUTE
--------------------------------------------------------

  CREATE TABLE "ROUTE" 
   (	"ROUTE_ID" NUMBER(4,0), 
	"FIRSTCITY" VARCHAR2(9), 
	"LASTCITY" VARCHAR2(9), 
	"DT" TIMESTAMP (6), 
	"TPD" NUMBER(9,0), 
	"DIST" NUMBER(9,0), 
	"INTER" INTERVAL DAY (9) TO SECOND (3), 
	"SPEED" NUMBER(3,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table SCHEDULE
--------------------------------------------------------

  CREATE TABLE "SCHEDULE" 
   (	"SCH_ID" NUMBER(4,0), 
	"FIRSTCITY" VARCHAR2(40), 
	"LASTCITY" VARCHAR2(40), 
	"TRAVEL_TIME" VARCHAR2(40), 
	"DT" VARCHAR2(40), 
	"AT" VARCHAR2(40), 
	"DIST" NUMBER(9,0), 
	"ROUTE_ID" NUMBER(9,0), 
	"HELP_ID" NUMBER(4,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table STATUS
--------------------------------------------------------

  CREATE TABLE "STATUS" 
   (	"ID" NUMBER(4,0), 
	"NAME" VARCHAR2(9)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into CUSTOMER
SET DEFINE OFF;
Insert into CUSTOMER (ID,FIRST_NAME,ADDRESS,E_MAIL,PHONE_NUMBER) values (38,'qe12','sad','weq','wqe');
Insert into CUSTOMER (ID,FIRST_NAME,ADDRESS,E_MAIL,PHONE_NUMBER) values (39,'qwedsa','weqdsa','wqd','qdsa');
Insert into CUSTOMER (ID,FIRST_NAME,ADDRESS,E_MAIL,PHONE_NUMBER) values (40,'wsda','wqesq','tryuy','ioplkj');
REM INSERTING into DISTANCE
SET DEFINE OFF;
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (25,14,'koza','spb','66');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (26,4,'krsk','kozulka','66');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (27,500,'kozulka','achi','67');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (28,16,'msk','koza','7');
Insert into DISTANCE (DISTANCE_ID,DIST,FIRSTCITY,LASTCITY,ROUTE_ID) values (29,2,'awe','qwe','66');
REM INSERTING into DISTANCE_ALTER_TABLE
SET DEFINE OFF;
Insert into DISTANCE_ALTER_TABLE (DIST,DISTANCE_ID) values (685,66);
REM INSERTING into LOGON_
SET DEFINE OFF;
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (1,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (2,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (3,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (4,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (5,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (6,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (7,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (8,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (9,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (10,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (11,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (12,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (13,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (14,1,'127.0.0.1',to_date('27-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (15,1,'127.0.0.1',to_date('28-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (16,1,'127.0.0.1',to_date('28-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (17,1,'127.0.0.1',to_date('28-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (18,1,'127.0.0.1',to_date('28-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (19,1,'127.0.0.1',to_date('28-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (20,1,'127.0.0.1',to_date('28-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (21,1,'127.0.0.1',to_date('28-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (22,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (23,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (24,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (25,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (26,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (27,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (28,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (29,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (30,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (31,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (32,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (33,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (34,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (35,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (36,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (37,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (38,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (39,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (40,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (41,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (42,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (43,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (44,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (45,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (46,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (47,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (48,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (49,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (50,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (51,1,'127.0.0.1',to_date('29-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (52,1,'127.0.0.1',to_date('30-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (53,1,'127.0.0.1',to_date('30-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (54,1,'127.0.0.1',to_date('30-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (55,1,'127.0.0.1',to_date('30-MAR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (56,1,'127.0.0.1',to_date('04-APR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (57,1,'127.0.0.1',to_date('07-APR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (58,1,'127.0.0.1',to_date('07-APR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (59,1,'127.0.0.1',to_date('07-APR-15','DD-MON-RR'));
Insert into LOGON_ (ID,PERSON,IPADDRESS,DATE_) values (60,1,'127.0.0.1',to_date('08-APR-15','DD-MON-RR'));
REM INSERTING into PERSON
SET DEFINE OFF;
Insert into PERSON (ID,STATUS,LASTNAME,FIRSTNAME,MIDDLENAME,LOGIN,PASSWORD) values (1,1,'Emrikh','Nikolay','Andreevich','redishko','789pp369');
Insert into PERSON (ID,STATUS,LASTNAME,FIRSTNAME,MIDDLENAME,LOGIN,PASSWORD) values (2,2,'Er','sda','dsa','wqed','789pp369');
REM INSERTING into ROUTE
SET DEFINE OFF;
Insert into ROUTE (ROUTE_ID,FIRSTCITY,LASTCITY,DT,TPD,DIST,INTER,SPEED) values (66,'msk','spb',to_timestamp('24-MAR-15 12.06.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),4,20,'+00 04:00:00.000000',60);
Insert into ROUTE (ROUTE_ID,FIRSTCITY,LASTCITY,DT,TPD,DIST,INTER,SPEED) values (67,'krsk','achi',to_timestamp('08-MAR-15 01.24.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),3,500,'+00 03:00:00.000000',90);
REM INSERTING into SCHEDULE
SET DEFINE OFF;
Insert into SCHEDULE (SCH_ID,FIRSTCITY,LASTCITY,TRAVEL_TIME,DT,AT,DIST,ROUTE_ID,HELP_ID) values (156,'msk','spb','20','24.03.2015 00:06','24.03.2015 00:26',20,66,1);
Insert into SCHEDULE (SCH_ID,FIRSTCITY,LASTCITY,TRAVEL_TIME,DT,AT,DIST,ROUTE_ID,HELP_ID) values (157,'msk','spb','20','24.03.2015 04:06','24.03.2015 04:26',20,66,2);
Insert into SCHEDULE (SCH_ID,FIRSTCITY,LASTCITY,TRAVEL_TIME,DT,AT,DIST,ROUTE_ID,HELP_ID) values (158,'msk','spb','20','24.03.2015 08:06','24.03.2015 08:26',20,66,3);
Insert into SCHEDULE (SCH_ID,FIRSTCITY,LASTCITY,TRAVEL_TIME,DT,AT,DIST,ROUTE_ID,HELP_ID) values (159,'msk','spb','20','24.03.2015 12:06','24.03.2015 12:26',20,66,4);
Insert into SCHEDULE (SCH_ID,FIRSTCITY,LASTCITY,TRAVEL_TIME,DT,AT,DIST,ROUTE_ID,HELP_ID) values (160,'krsk','achi','333.333333333333333333333333333333333334','08.03.2015 01:24','08.03.2015 06:57',500,67,1);
Insert into SCHEDULE (SCH_ID,FIRSTCITY,LASTCITY,TRAVEL_TIME,DT,AT,DIST,ROUTE_ID,HELP_ID) values (161,'krsk','achi','333.333333333333333333333333333333333334','08.03.2015 04:24','08.03.2015 09:57',500,67,2);
Insert into SCHEDULE (SCH_ID,FIRSTCITY,LASTCITY,TRAVEL_TIME,DT,AT,DIST,ROUTE_ID,HELP_ID) values (162,'krsk','achi','333.333333333333333333333333333333333334','08.03.2015 07:24','08.03.2015 12:57',500,67,3);
REM INSERTING into STATUS
SET DEFINE OFF;
Insert into STATUS (ID,NAME) values (1,'Guest');
Insert into STATUS (ID,NAME) values (2,'User');
Insert into STATUS (ID,NAME) values (3,'Admin');
--------------------------------------------------------
--  DDL for Index CUSTOMER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CUSTOMER_PK" ON "CUSTOMER" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index DISTANCE_ALTER_TABLE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DISTANCE_ALTER_TABLE_PK" ON "DISTANCE_ALTER_TABLE" ("DISTANCE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table CUSTOMER
--------------------------------------------------------

  ALTER TABLE "CUSTOMER" ADD CONSTRAINT "CUSTOMER_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
 
  ALTER TABLE "CUSTOMER" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DISTANCE
--------------------------------------------------------

  ALTER TABLE "DISTANCE" ADD PRIMARY KEY ("DISTANCE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Constraints for Table SCHEDULE
--------------------------------------------------------

  ALTER TABLE "SCHEDULE" ADD PRIMARY KEY ("SCH_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Constraints for Table DISTANCE_ALTER_TABLE
--------------------------------------------------------

  ALTER TABLE "DISTANCE_ALTER_TABLE" ADD CONSTRAINT "DISTANCE_ALTER_TABLE_PK" PRIMARY KEY ("DISTANCE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
 
  ALTER TABLE "DISTANCE_ALTER_TABLE" MODIFY ("DISTANCE_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table STATUS
--------------------------------------------------------

  ALTER TABLE "STATUS" MODIFY ("NAME" NOT NULL ENABLE);
 
  ALTER TABLE "STATUS" ADD CHECK (name IN ('Guest','User','Admin')) ENABLE;
 
  ALTER TABLE "STATUS" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Constraints for Table ROUTE
--------------------------------------------------------

  ALTER TABLE "ROUTE" ADD PRIMARY KEY ("ROUTE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Constraints for Table PERSON
--------------------------------------------------------

  ALTER TABLE "PERSON" MODIFY ("LASTNAME" NOT NULL ENABLE);
 
  ALTER TABLE "PERSON" MODIFY ("FIRSTNAME" NOT NULL ENABLE);
 
  ALTER TABLE "PERSON" MODIFY ("LOGIN" NOT NULL ENABLE);
 
  ALTER TABLE "PERSON" MODIFY ("PASSWORD" NOT NULL ENABLE);
 
  ALTER TABLE "PERSON" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
 
  ALTER TABLE "PERSON" ADD UNIQUE ("LOGIN")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Constraints for Table LOGON_
--------------------------------------------------------

  ALTER TABLE "LOGON_" MODIFY ("PERSON" NOT NULL ENABLE);
 
  ALTER TABLE "LOGON_" MODIFY ("IPADDRESS" NOT NULL ENABLE);
 
  ALTER TABLE "LOGON_" MODIFY ("DATE_" NOT NULL ENABLE);
 
  ALTER TABLE "LOGON_" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
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
/
ALTER TRIGGER "ALTER_TRIG" ENABLE;
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
/
ALTER TRIGGER "CUSTOMER_T" ENABLE;
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
/
ALTER TRIGGER "DISTANCE_T" ENABLE;
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
/
ALTER TRIGGER "DR_IUD_T" ENABLE;
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
/
ALTER TRIGGER "LOGON_T" ENABLE;
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
/
ALTER TRIGGER "PERSON_T" ENABLE;
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
/
ALTER TRIGGER "ROUTE_T" ENABLE;
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
/
ALTER TRIGGER "ROUTE_TO" ENABLE;
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
/
ALTER TRIGGER "SCHEDULE_T" ENABLE;
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
/
ALTER TRIGGER "STATUS_T" ENABLE;
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
/
ALTER TRIGGER "TEST_TRIG" ENABLE;
