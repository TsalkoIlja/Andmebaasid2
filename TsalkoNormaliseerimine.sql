CREATE TABLE [Klient] (

  [KlientID] int IDENTITY(1,1) PRIMARY KEY,

  [KlientNimi] varchar(30) NOT NULL

);





CREATE TABLE [Aadress] (

  [aadressID] int IDENTITY(1,1) PRIMARY KEY,

  [aadress] varchar(50) NOT NULL,

  [KlientID] int NOT NULL,

  CONSTRAINT [FK_Aadress_Klient] 

    FOREIGN KEY ([KlientID]) REFERENCES [Klient]([KlientID])

);





CREATE TABLE [Kommityyp] (

  [KommityypID] int PRIMARY KEY,

  [Kommityyp] varchar(30) NOT NULL

);


CREATE TABLE [Kehtiv] (

  [KehtivID] int PRIMARY KEY,

  [Kehtivusaeg_kuu] int NOT NULL

);



CREATE TABLE [Kommid] (

  [kommID] int PRIMARY KEY,

  [KommNimetus] varchar(30) NOT NULL,

  [Hind] decimal(10,2) NOT NULL,

  [KommityypID] int NOT NULL,

  [KehtivID] int NOT NULL,

  CONSTRAINT [FK_Kommid_Kommityyp] 

    FOREIGN KEY ([KommityypID]) REFERENCES [Kommityyp]([KommityypID]),

  CONSTRAINT [FK_Kommid_Kehtiv] 

    FOREIGN KEY ([KehtivID]) REFERENCES [Kehtiv]([KehtivID])

);







CREATE TABLE [Pakkijad] (

  [PakkijadID] int PRIMARY KEY,

  [PakkijaNimi] varchar(30) NOT NULL,

  [PakkijaPerenimi] varchar(30) NOT NULL

);




CREATE TABLE [TellimuseKuupaev] (

  [TellimuseNrID] int IDENTITY(1,1) PRIMARY KEY,

  [Tellimuse_kuupaev] date NOT NULL,

  [Kogus_Kg] int NOT NULL,

  [AadressID] int NOT NULL,

  [KommID] int NOT NULL,

  [PakkijaID] int NOT NULL,

  CONSTRAINT [FK_Tellimus_Aadress] 

    FOREIGN KEY ([AadressID]) REFERENCES [Aadress]([aadressID]),

  CONSTRAINT [FK_Tellimus_Kommid] 

    FOREIGN KEY ([KommID]) REFERENCES [Kommid]([kommID]),

  CONSTRAINT [FK_Tellimus_Pakkijad] 

    FOREIGN KEY ([PakkijaID]) REFERENCES [Pakkijad]([PakkijadID])

); 

-- 1. Клиенты
INSERT INTO [Klient] ([KlientNimi]) VALUES 
('Maxima'), ('Selver'), ('Rimi'), ('Prisma');

-- 2. Адреса
INSERT INTO [Aadress] ([aadress], [KlientID]) VALUES 
('Mustakivi 1', 1),
('Kivimurru 32', 2),
('Toome 3', 1),
('Prisli 45', 3),
('Mustakivi 5', 3),
('Mustamäe 16', 4);

-- 3. Типы конфет
INSERT INTO [Kommityyp] ([KommityypID], [Kommityyp]) VALUES 
(1, 'šokolaad'),
(2, 'karamell'),
(3, 'vahukomm'),
(4, 'iriis');

-- 4. Сроки годности (в месяцах)
INSERT INTO [Kehtiv] ([KehtivID], [Kehtivusaeg_kuu]) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 5);

-- 5. Конфеты
INSERT INTO [Kommid] ([kommID], [KommNimetus], [Hind], [KommityypID], [KehtivID]) VALUES 
(1, 'Teekommid', 79.00, 1, 1),
(2, 'Barbariss', 36.00, 2, 2),
(3, 'Kometa', 83.00, 1, 1),
(4, 'Kis-Kis', 70.00, 4, 4),
(5, 'Vanill', 40.00, 3, 3),
(6, 'Klassikaline', 72.00, 4, 4);

-- 6. Упаковщики
INSERT INTO [Pakkijad] ([PakkijadID], [PakkijaNimi], [PakkijaPerenimi]) VALUES 
(1, 'Anna', 'Sidor'),
(2, 'Marina', 'Ivanova'),
(3, 'Darja', 'Tsvetkova');

-- 7. Заказы (kommiTellimus)
INSERT INTO [TellimuseKuupaev] ([Tellimuse_kuupaev], [Kogus_Kg], [AadressID], [KommID], [PakkijaID]) VALUES 
('2020-02-12', 3, 1, 1, 1),
('2020-02-13', 13, 2, 2, 2),
('2020-02-14', 7, 2, 3, 3),
('2020-02-15', 10, 3, 3, 2),
('2020-02-12', 5, 4, 2, 3),
('2020-02-13', 2, 4, 3, 3),
('2020-02-14', 10, 2, 5, 1),
('2020-02-15', 5, 5, 4, 1),
('2020-02-12', 30, 1, 5, 1),
('2020-02-13', 15, 6, 6, 2);
