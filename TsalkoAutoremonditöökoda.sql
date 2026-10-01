CREATE TABLE Arve (
    ArveID int  NOT NULL IDENTITY(1, 1),
    kuupaev date  NOT NULL,
    VariosaRemondisID int  NOT NULL,
    maksmiseTahtaeg date  NOT NULL,
    staatus varchar(50)  NOT NULL,
    CONSTRAINT Arve_pk PRIMARY KEY  (ArveID)
);

-- Table: Ladu
CREATE TABLE Ladu (
    LaduID int  NOT NULL IDENTITY(1, 1),
    nimetus varchar(100)  NOT NULL,
    aadress varchar(200)  NULL,
    CONSTRAINT Ladu_pk PRIMARY KEY  (LaduID)
);

-- Table: LaduVaruosa
CREATE TABLE LaduVaruosa (
    LaduvaruosaID int  NOT NULL IDENTITY(1, 1),
    varuosaID int  NOT NULL,
    laduID int  NOT NULL,
    kogus int  NOT NULL DEFAULT 0,
    CONSTRAINT LaduVaruosa_pk PRIMARY KEY  (LaduvaruosaID)
);

-- Table: Remonditoo
CREATE TABLE Remonditoo (
    RemonditooID int  NOT NULL IDENTITY(1, 1),
    kuupäev date  NOT NULL,
    kategooriaID int  NOT NULL,
    kirjeldus varchar(max)  NULL,
    Regnumber varchar(20)  NOT NULL,
    CONSTRAINT Remonditoo_pk PRIMARY KEY  (RemonditooID)
);

-- Table: Varuosa
CREATE TABLE Varuosa (
    varuosaID int  NOT NULL IDENTITY(1, 1),
    nimetus varchar(100)  NOT NULL,
    tootja varchar(100)  NULL,
    hind decimal(10,2)  NOT NULL,
    laoseis int  NOT NULL DEFAULT 0,
    CONSTRAINT Varuosa_pk PRIMARY KEY  (varuosaID)
);

-- Table: VaruosaRemondis
CREATE TABLE VaruosaRemondis (
    varuosaRemondisID int  NOT NULL IDENTITY(1, 1),
    LaduvaruosaID int  NOT NULL,
    RemonditooID int  NOT NULL,
    tkkogus int  NOT NULL DEFAULT 1,
    CONSTRAINT VaruosaRemondis_pk PRIMARY KEY  (varuosaRemondisID)
);

-- Table: amet
CREATE TABLE amet (
    ametID int  NOT NULL IDENTITY(1, 1),
    nimetus varchar(100)  NOT NULL,
    kirjeldus varchar(max)  NULL,
    CONSTRAINT amet_pk PRIMARY KEY  (ametID)
);

-- Table: ametimaaratus
CREATE TABLE ametimaaratus (
    ametimaaratusID int  NOT NULL IDENTITY(1, 1),
    alguskuupäev date  NOT NULL,
    tootajaID int  NOT NULL,
    ametID int  NOT NULL,
    CONSTRAINT ametimaaratus_pk PRIMARY KEY  (ametimaaratusID)
);

-- Table: auto
CREATE TABLE auto (
    RegNumber varchar(20)  NOT NULL,
    mark varchar(50)  NOT NULL,
    mudel varchar(50)  NOT NULL,
    V_aasta int  NOT NULL,
    läbisgit int  NOT NULL,
    CONSTRAINT auto_pk PRIMARY KEY  (RegNumber)
);

-- Table: kategooria
CREATE TABLE kategooria (
    kategooriaID int  NOT NULL IDENTITY(1, 1),
    kategooria varchar(100)  NOT NULL,
    kirjeldus varchar(max)  NULL,
    kestus int  NULL,
    CONSTRAINT kategooria_pk PRIMARY KEY  (kategooriaID)
);

-- Table: kliendiauto
CREATE TABLE kliendiauto (
    kliendiautoID int  NOT NULL IDENTITY(1, 1),
    klientID int  NOT NULL,
    regNumber varchar(20)  NOT NULL,
    kuupäev date  NOT NULL,
    CONSTRAINT kliendiauto_pk PRIMARY KEY  (kliendiautoID)
);

-- Table: klient
CREATE TABLE klient (
    klientID int  NOT NULL IDENTITY(1, 1),
    nimi varchar(100)  NOT NULL,
    tel varchar(20)  NULL,
    e_post varchar(100)  NULL,
    CONSTRAINT klient_pk PRIMARY KEY  (klientID)
);

-- Table: tarneVaruosa
CREATE TABLE tarneVaruosa (
    tarneVaruosaID int  NOT NULL IDENTITY(1, 1),
    tarnijaID int  NOT NULL,
    VaruosaID int  NOT NULL,
    hind decimal(10,2)  NOT NULL,
    CONSTRAINT tarneVaruosa_pk PRIMARY KEY  (tarneVaruosaID)
);

-- Table: tarnija
CREATE TABLE tarnija (
    tarnijaID int  NOT NULL IDENTITY(1, 1),
    nimetus varchar(100)  NOT NULL,
    kontakt varchar(100)  NULL,
    aadress varchar(200)  NULL,
    CONSTRAINT tarnija_pk PRIMARY KEY  (tarnijaID)
);

-- Table: tootaja
CREATE TABLE tootaja (
    tootajaID int  NOT NULL IDENTITY(1, 1),
    eesnimi varchar(50)  NOT NULL,
    perenimi varchar(50)  NOT NULL,
    isikukood varchar(11)  NOT NULL,
    tel varchar(20)  NULL,
    aadress varchar(200)  NULL,
    CONSTRAINT tootaja_pk PRIMARY KEY  (tootajaID)
);

-- Table: tootajaRemont
CREATE TABLE tootajaRemont (
    tootajaRemontID int  NOT NULL IDENTITY(1, 1),
    RemonditooID int  NOT NULL,
    tootajaID int  NOT NULL,
    status varchar(50)  NULL,
    CONSTRAINT tootajaRemont_pk PRIMARY KEY  (tootajaRemontID)
);

-- foreign keys
-- Reference: FK_0 (table: ametimaaratus)
ALTER TABLE ametimaaratus ADD CONSTRAINT FK_0
    FOREIGN KEY (tootajaID)
    REFERENCES tootaja (tootajaID);

-- Reference: FK_1 (table: ametimaaratus)
ALTER TABLE ametimaaratus ADD CONSTRAINT FK_1
    FOREIGN KEY (ametID)
    REFERENCES amet (ametID);

-- Reference: FK_10 (table: VaruosaRemondis)
ALTER TABLE VaruosaRemondis ADD CONSTRAINT FK_10
    FOREIGN KEY (LaduvaruosaID)
    REFERENCES LaduVaruosa (LaduvaruosaID);

-- Reference: FK_11 (table: VaruosaRemondis)
ALTER TABLE VaruosaRemondis ADD CONSTRAINT FK_11
    FOREIGN KEY (RemonditooID)
    REFERENCES Remonditoo (RemonditooID);

-- Reference: FK_12 (table: tarneVaruosa)
ALTER TABLE tarneVaruosa ADD CONSTRAINT FK_12
    FOREIGN KEY (tarnijaID)
    REFERENCES tarnija (tarnijaID);

-- Reference: FK_13 (table: tarneVaruosa)
ALTER TABLE tarneVaruosa ADD CONSTRAINT FK_13
    FOREIGN KEY (VaruosaID)
    REFERENCES Varuosa (varuosaID);

-- Reference: FK_14 (table: Arve)
ALTER TABLE Arve ADD CONSTRAINT FK_14
    FOREIGN KEY (VariosaRemondisID)
    REFERENCES VaruosaRemondis (varuosaRemondisID);

-- Reference: FK_2 (table: kliendiauto)
ALTER TABLE kliendiauto ADD CONSTRAINT FK_2
    FOREIGN KEY (klientID)
    REFERENCES klient (klientID);

-- Reference: FK_3 (table: kliendiauto)
ALTER TABLE kliendiauto ADD CONSTRAINT FK_3
    FOREIGN KEY (regNumber)
    REFERENCES auto (RegNumber);

-- Reference: FK_4 (table: Remonditoo)
ALTER TABLE Remonditoo ADD CONSTRAINT FK_4
    FOREIGN KEY (kategooriaID)
    REFERENCES kategooria (kategooriaID);

-- Reference: FK_5 (table: Remonditoo)
ALTER TABLE Remonditoo ADD CONSTRAINT FK_5
    FOREIGN KEY (Regnumber)
    REFERENCES auto (RegNumber);

-- Reference: FK_6 (table: tootajaRemont)
ALTER TABLE tootajaRemont ADD CONSTRAINT FK_6
    FOREIGN KEY (RemonditooID)
    REFERENCES Remonditoo (RemonditooID);

-- Reference: FK_7 (table: tootajaRemont)
ALTER TABLE tootajaRemont ADD CONSTRAINT FK_7
    FOREIGN KEY (tootajaID)
    REFERENCES tootaja (tootajaID);

-- Reference: FK_8 (table: LaduVaruosa)
ALTER TABLE LaduVaruosa ADD CONSTRAINT FK_8
    FOREIGN KEY (varuosaID)
    REFERENCES Varuosa (varuosaID);

-- Reference: FK_9 (table: LaduVaruosa)
ALTER TABLE LaduVaruosa ADD CONSTRAINT FK_9
    FOREIGN KEY (laduID)
    REFERENCES Ladu (LaduID);


    -- 1. Ametikohad (amet) ja töötajad (tootaja, ametimaaratus)
INSERT INTO amet (nimetus, kirjeldus) VALUES 
('Meister', 'Tööde vastuvõtt ja juhendamine'),
('Mehaanik', 'Mootorite ja veermiku remont'),
('Diagnostik', 'Elektri- ja arvutidiagnostika'),
('Vastuvõtja', 'Klienditeenindus');

INSERT INTO tootaja (eesnimi, perenimi, isikukood, tel, aadress) VALUES 
('Mait', 'Kask', '38505120123', '+3725123456', 'Tallinn, Pärnu mnt 10'),
('Jaan', 'Tamm', '39001010456', '+3725654321', 'Tartu, Riia mnt 5');

INSERT INTO ametimaaratus (alguskuupäev, tootajaID, ametID) VALUES 
('2022-01-15', 1, 1),
('2023-03-01', 2, 2);

-- 2. Kliendid ja autod (klient, auto, kliendiauto)
INSERT INTO klient (nimi, tel, e_post) VALUES 
('Mari Maasik', '+3725011223', 'mari.maasik@gmail.com'),
('OÜ Veosed', '+3726001122', 'info@veosed.ee');

INSERT INTO auto (RegNumber, mark, mudel, V_aasta, läbisgit) VALUES 
('123ABC', 'Audi', 'A4', 2018, 145000),
('999XYZ', 'Volkswagen', 'Passat', 2020, 82000);

INSERT INTO kliendiauto (klientID, regNumber, kuupäev) VALUES 
(1, '123ABC', '2023-05-10'),
(2, '999XYZ', '2024-01-15');

-- 3. Remonditööde kategooriad ja tööd (kategooria, Remonditoo, tootajaRemont)
INSERT INTO kategooria (kategooria, kirjeldus, kestus) VALUES 
('Õlivahetus', 'Mootoriõli ja filtri vahetus', 60),
('Pidurite remont', 'Piduriklotside ja -ketaste vahetus', 120),
('Rehvide vahetus', 'Hooajaline rehvivahetus', 45),
('Mootori remont', 'Mootori detailne remont', 300),
('Diagnostika', 'Kompuuterdiagnostika', 30);

INSERT INTO Remonditoo (kuupäev, kategooriaID, kirjeldus, Regnumber) VALUES 
('2026-03-01', 1, 'Õlivahetus ja üldine kontroll', '123ABC'),
('2026-03-02', 2, 'Esipiduri klotside vahetus', '999XYZ');

INSERT INTO tootajaRemont (RemonditooID, tootajaID, status) VALUES 
(1, 1, 'Lõpetatud'),
(2, 2, 'Töös');

-- 4. Varuosad, ladu ja kasutatud varuosad (Varuosa, Ladu, LaduVaruosa, VaruosaRemondis)
INSERT INTO Varuosa (nimetus, tootja, hind, laoseis) VALUES 
('Mootoriõli 5W30', 'Castrol', 45.00, 20),
('Õlifilter', 'MANN-FILTER', 12.50, 15),
('Piduriklotsid', 'Brembo', 65.00, 8);

INSERT INTO Ladu (nimetus, aadress) VALUES 
('Põhiladu', 'Kadaka tee 4, Tallinn');

INSERT INTO LaduVaruosa (varuosaID, laduID, kogus) VALUES 
(1, 1, 20),
(2, 1, 15),
(3, 1, 8);

INSERT INTO VaruosaRemondis (LaduvaruosaID, RemonditooID, tkkogus) VALUES 
(1, 1, 1),
(2, 1, 1),
(3, 2, 1);

-- 5. Tarnijad ja tarnevaruosad (tarnija, tarneVaruosa)
INSERT INTO tarnija (nimetus, kontakt, aadress) VALUES 
('Inter Cars Eesti OÜ', '+3726789000', 'Tallinn'),
('Autoasi AS', '+3726554433', 'Tallinn');

INSERT INTO tarneVaruosa (tarnijaID, VaruosaID, hind) VALUES 
(1, 1, 32.00),
(2, 3, 48.00);

-- 6. Arved (Arve)
INSERT INTO Arve (kuupaev, VariosaRemondisID, maksmiseTahtaeg, staatus) VALUES 
('2026-03-01', 1, '2026-03-15', 'Makstud'),
('2026-03-02', 3, '2026-03-16', 'Ootel');