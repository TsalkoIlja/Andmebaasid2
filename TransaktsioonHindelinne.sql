CREATE DATABASE TsalkoTransaktsioonHindeline;
use TsalkoTransaktsioonHindeline;

-- 1. Loome tabeli tblProduct nagu videos
CREATE TABLE tblProduct (
    ProductId INT PRIMARY KEY,
    Name VARCHAR(50),
    UnitPrice INT,
    QtyAvailable INT
);

-- 2. Lisame algandmed (Laptops = 100, Desktops = 20)
INSERT INTO tblProduct VALUES (1, 'Laptops', 2340, 100);
INSERT INTO tblProduct VALUES (2, 'Desktops', 3467, 20);

-- Kontrollime andmeid
SELECT * FROM tblProduct;

-- 3. Alustame transaktsiooni ja muudame koguse 50-ks
BEGIN TRANSACTION;
UPDATE tblProduct SET QtyAvailable = 50 WHERE ProductId = 1;

-- Samas aknas näeme muudatust (50)
SELECT * FROM tblProduct;

-- 4. Tühistame transaktsiooni (ROLLBACK)
ROLLBACK TRANSACTION;

-- Kontrollime uuesti – algne väärtus 100 taastus
SELECT * FROM tblProduct;




-- Loo postiaadressi tabel
CREATE TABLE tblMailingAddress (
    AddressId INT PRIMARY KEY NOT NULL,
    EmployeeNumber INT,
    HouseNumber VARCHAR(50),
    StreetAddress VARCHAR(50),
    City VARCHAR(10),
    PostalCode VARCHAR(50)
);

-- Loo tegeliku aadressi tabel
CREATE TABLE tblPhysicalAddress (
    AddressId INT PRIMARY KEY NOT NULL,
    EmployeeNumber INT,
    HouseNumber VARCHAR(50),
    StreetAddress VARCHAR(50),
    City VARCHAR(10),
    PostalCode VARCHAR(50)
);

-- Lisa andmed postiaadressi tabelisse
INSERT INTO tblMailingAddress (AddressId, EmployeeNumber, HouseNumber, StreetAddress, City, PostalCode)
VALUES (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW');

-- Lisa andmed tegeliku aadressi tabelisse
INSERT INTO tblPhysicalAddress (AddressId, EmployeeNumber, HouseNumber, StreetAddress, City, PostalCode)
VALUES (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW');

select * from tblMailingAddress;
select * from tblPhysicalAddress;

Create Procedure spUpdateAddress
as
Begin
    Begin Try
        Begin Transaction
            Update tblMailingAddress set City = 'LONDON'
            where AddressId = 1 and EmployeeNumber = 101

            Update tblPhysicalAddress set City = 'LONDON LONDON'
            where AddressId = 1 and EmployeeNumber = 101
        Commit Transaction
    End Try
    Begin Catch
        Rollback Transaction
    End Catch
End

EXEC spUpdateAddress;

DROP PROCEDURE spUpdateAddress;

Alter Procedure spUpdateAddress
as
Begin
    Begin Try
        Begin Transaction
            Update tblMailingAddress set City = 'LONDON1'
            where AddressId = 1 and EmployeeNumber = 101

            Update tblPhysicalAddress set City = 'LONDON LONDON'
            where AddressId = 1 and EmployeeNumber = 101
        Commit Transaction
        Print 'Transaction Committed'
    End Try
    Begin Catch
        Rollback Transaction
        Print 'Transaction Rolled Back'
    End Catch
End



EXEC spUpdateAddress;

-- 1. Loome tabelid tblArveldusarve ja tblHoiusarve koos CHECK-piiranguga
CREATE TABLE tblArveldusarve (
    KontoId INT PRIMARY KEY NOT NULL,
    KliendiNr INT,
    Omanik NVARCHAR(30),
    Saldo DECIMAL(10,2) CHECK (Saldo >= 0)
);

CREATE TABLE tblHoiusarve (
    KontoId INT PRIMARY KEY NOT NULL,
    KliendiNr INT,
    Omanik NVARCHAR(30),
    Saldo DECIMAL(10,2) CHECK (Saldo >= 0)
);

-- Lisame algandmed (Mari Maasikas)
INSERT INTO tblArveldusarve VALUES (1, 201, 'Mari Maasikas', 500.00);
INSERT INTO tblHoiusarve VALUES (1, 201, 'Mari Maasikas', 1000.00);

-- 2. Kontrollime mõlema tabeli andmeid
SELECT * FROM tblArveldusarve;
SELECT * FROM tblHoiusarve;

-- 2. Loome protseduuri spUlekanne (200 € ülekanne)
CREATE PROCEDURE spUlekanne
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            -- Esimene UPDATE: hoiuskontole tuleb 200 € juurde
            UPDATE tblHoiusarve 
            SET Saldo = Saldo + 200 
            WHERE KontoId = 1 AND KliendiNr = 201;

            -- Teine UPDATE: arvelduskontolt läheb 200 € maha
            UPDATE tblArveldusarve 
            SET Saldo = Saldo - 200 
            WHERE KontoId = 1 AND KliendiNr = 201;

        COMMIT TRANSACTION
        PRINT 'Ülekanne õnnestus (Transaction Committed)';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT 'Viga! Tehing tühistati (Transaction Rolled Back)';
    END CATCH
END;
GO

-- Käivitame protseduuri ja kontrollime tulemust (ootus: 300.00 ja 1200.00)
EXEC spUlekanne;

SELECT * FROM tblArveldusarve;
SELECT * FROM tblHoiusarve;

-- 3. Muudame protseduuri: ülekande summa on 1000 € (rikub CHECK-piirangut)
ALTER PROCEDURE spUlekanne
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            -- Esimene UPDATE õnnestub ajutiselt (1200 + 1000 = 2200)
            UPDATE tblHoiusarve 
            SET Saldo = Saldo + 1000 
            WHERE KontoId = 1 AND KliendiNr = 201;

            -- Teine UPDATE ebaõnnestub (300 - 1000 = -700 < 0 -> CHECK viga)
            UPDATE tblArveldusarve 
            SET Saldo = Saldo - 1000 
            WHERE KontoId = 1 AND KliendiNr = 201;

        COMMIT TRANSACTION
        PRINT 'Ülekanne õnnestus (Transaction Committed)';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT 'Viga! Tehing tühistati (Transaction Rolled Back)';
    END CATCH
END;
GO

-- Käivitame ja kontrollime (ootus: saldod jäävad 300.00 ja 1200.00)
EXEC spUlekanne;

SELECT * FROM tblArveldusarve;
SELECT * FROM tblHoiusarve;


-- 4. Käivitame sammu 4 kaks UPDATE-lauset otse, ilma transaktsioonita
UPDATE tblHoiusarve 
SET Saldo = Saldo + 1000 
WHERE KontoId = 1 AND KliendiNr = 201;

UPDATE tblArveldusarve 
SET Saldo = Saldo - 1000 
WHERE KontoId = 1 AND KliendiNr = 201;

-- Kontrollime saldosid
SELECT * FROM tblArveldusarve;
SELECT * FROM tblHoiusarve;