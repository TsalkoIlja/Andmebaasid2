--(localdb)\MSSQLLocalDB
use kordamineIKT25;
CREATE TABLE opilane(
opilaneId int Primary Key identity(1,1),
nimi varchar(50),
isikukood char(11) not null,
ryhmId int)

Create TABLE ryhm(
ryhmId int Primary Key identity(1,1),
ryhmNimi char(10) Unique,
opilasteArv int);

--tabeli kustutamine
DROP TABLE ...;

--välisvõti  - FK
ALTER TABLE opilane ADD FOREIGN KEY (ryhmId) REFERENCES ryhm(ryhmId);

GRANT SELECT TO Ilja2;
GRANT INSERT ON opilane TO Ilja2;
deny delete to Ilja2;

select * from opilane, ryhm
where opilane.ryhmId=ryhm.ryhmId;

Delete from opilane;

insert into opilane values ('Nikita', '12345678900', 1);

