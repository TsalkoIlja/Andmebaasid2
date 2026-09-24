-- 1. Таблица Факультетов
CREATE TABLE [Teaduskond] (
    [TeaduskondID] int PRIMARY KEY,
    [TeaduskondNimi] varchar(50)
);

-- 2. Таблица Групп
CREATE TABLE [Ruhm] (
    [RuhmID] int PRIMARY KEY,
    [RuhmNimi] varchar(10),
    [TeaduskondID] int,
    CONSTRAINT [FK_Ruhm_Teaduskond] 
        FOREIGN KEY ([TeaduskondID]) REFERENCES [Teaduskond]([TeaduskondID])
);

-- 3. Таблица Студентов
CREATE TABLE [Opilane] (
    [Matrikkel_nr] int PRIMARY KEY,
    [Perekonnanimi] varchar(50),
    [RuhmID] int,
    CONSTRAINT [FK_Opilane_Ruhm] 
        FOREIGN KEY ([RuhmID]) REFERENCES [Ruhm]([RuhmID])
);

-- 4. Таблица Преподавателей
CREATE TABLE [Oppejoud] (
    [OppejoudID] int PRIMARY KEY,
    [Nimi] varchar(50)
);

-- 5. Таблица Предметов
CREATE TABLE [Oppeaine] (
    [OppeaineID] int PRIMARY KEY,
    [OppeaineNimi] varchar(50),
    [OppejoudID] int,
    CONSTRAINT [FK_Oppeaine_Oppejoud] 
        FOREIGN KEY ([OppejoudID]) REFERENCES [Oppejoud]([OppejoudID])
);

-- 6. Таблица Видов работ (Справочник Töö liik)
CREATE TABLE [TooLiik] (
    [TooLiikID] int PRIMARY KEY,
    [Nimetus] varchar(50)
);


CREATE TABLE [Sooritus] (
    [SooritusID] int IDENTITY(1,1) PRIMARY KEY,
    [Matrikkel_nr] int,
    [OppeaineID] int,
    [Semester] int,
    [TooLiikID] int,
    [Hinne] varchar(20),
    CONSTRAINT [FK_Sooritus_Opilane] 
        FOREIGN KEY ([Matrikkel_nr]) REFERENCES [Opilane]([Matrikkel_nr]),
    CONSTRAINT [FK_Sooritus_Oppeaine] 
        FOREIGN KEY ([OppeaineID]) REFERENCES [Oppeaine]([OppeaineID]),
    CONSTRAINT [FK_Sooritus_TooLiik] 
        FOREIGN KEY ([TooLiikID]) REFERENCES [TooLiik]([TooLiikID])
);

-- =============================================
-- ВСТАВКА ДАННЫХ (INSERT INTO)
-- =============================================

-- 1. Факультеты
INSERT INTO [Teaduskond] ([TeaduskondID], [TeaduskondNimi]) VALUES 
(1, 'F1'),
(2, 'F2');

-- 2. Группы
INSERT INTO [Ruhm] ([RuhmID], [RuhmNimi], [TeaduskondID]) VALUES 
(1, 'G1', 1),
(2, 'G2', 1),
(3, 'G3', 2);

-- 3. Студенты
INSERT INTO [Opilane] ([Matrikkel_nr], [Perekonnanimi], [RuhmID]) VALUES 
(1, 'Panov', 1),
(2, 'Turov', 2),
(3, 'Serov', 3);

-- 4. Преподаватели
INSERT INTO [Oppejoud] ([OppejoudID], [Nimi]) VALUES 
(1, 'Somov'),
(2, 'Petrov'),
(3, 'Lvov');

-- 5. Предметы
INSERT INTO [Oppeaine] ([OppeaineID], [OppeaineNimi], [OppejoudID]) VALUES 
(1, 'Keemia', 1),
(2, 'Füüsika', 2),
(3, 'Ajalugu', 3);

-- 6. Виды работ
INSERT INTO [TooLiik] ([TooLiikID], [Nimetus]) VALUES 
(1, 'Eksam');

-- 7. Оценки
INSERT INTO [Sooritus] ([Matrikkel_nr], [OppeaineID], [Semester], [TooLiikID], [Hinne]) VALUES 
(1, 1, 1, 1, 'Väga hea'),
(1, 2, 1, 1, 'Väga hea'),
(1, 3, 1, 1, 'Väga hea'),
(2, 1, 1, 1, 'Hea'),
(2, 2, 1, 1, 'Väga hea'),
(2, 3, 1, 1, 'Hea'),
(3, 1, 1, 1, 'Väga hea'),
(3, 2, 1, 1, 'Väga hea'),
(3, 3, 1, 1, 'Rahuldav');