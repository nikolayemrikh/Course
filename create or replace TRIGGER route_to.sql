create or replace TRIGGER route_to
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