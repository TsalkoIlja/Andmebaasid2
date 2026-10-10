use IljaKohvik;



-- 1. Amet
INSERT INTO ametSet (amet_Nimetus)
VALUES ('Kokk'), ('Kelner'), ('Baarmen');

-- 2. Töötaja
INSERT INTO TootajaSet (nimi, isikukood, telefon, amet_ametId)
VALUES
('Jaan Tamm', '39001010001', '5551001', 1),
('Mari Kask', '49502020002', '5551002', 2),
('Karl Saar', '39903030003', '5551003', 3);

-- 3. Töögraafik
INSERT INTO ToograafikSet (kuupaev, Tootaja_TootajaId)
VALUES
('2026-10-10', 1),
('2026-10-11', 2),
('2026-10-12', 3);

-- 4. Klient
INSERT INTO klientSet (nimi)
VALUES ('Anna Ivanova'), ('Martin Sepp'), ('Olga Petrova');

-- 5. Laud
INSERT INTO laudSet (laud_number, kohtade_arv)
VALUES ('1', '2'), ('2', '4'), ('3', '6');

-- 6. Broneerimine
INSERT INTO broneerimineSet
(kuupaev, inimeste_arv, kellaeg, klient_klientId, laud_laudId)
VALUES
('2026-10-12', '2', '18:00', 1, 1),
('2026-10-13', '4', '19:00', 2, 2),
('2026-10-14', '3', '17:30', 3, 3);

-- 7. Kategooria
INSERT INTO kategooriaSet (nimi)
VALUES ('Joogid'), ('Pearoad'), ('Magustoidud');

-- 8. Toode
INSERT INTO ToodeSet
(Nimetus, kirjeldus, hind, kategooria_kategooriaId)
VALUES
('Kohv', 'Kuum kohv', '3.50', 1),
('Pizza', 'Juustupizza', '9.00', 2),
('Kook', 'Sokolaadikook', '5.00', 3);

-- 9. Koostisosa
INSERT INTO KoostisosaSet (nimi)
VALUES ('Kohvioad'), ('Juust'), ('Sokolaad');

-- 10. TooteKoostisosa
INSERT INTO TooteKoostisosaSet
(kogus, Toode_ToodeId, Koostisosa_koostisosaId)
VALUES
('20', 1, 1),
('150', 2, 2),
('100', 3, 3);

-- 11. Tellimus
INSERT INTO TellimusSet
(kuupaev, kellaeg, Tootaja_TootajaId,
 klient_klientId, TooteKoostisosa_tooteKoostisosaId)
VALUES
('2026-10-10', '12:00', 2, 1, 1),
('2026-10-10', '13:30', 2, 2, 2),
('2026-10-10', '15:00', 3, 3, 3);

-- 12. TellimusToode
INSERT INTO TellimusToodeSet
(kogus, Tellimus_TellimusId, Toode_ToodeId)
VALUES
('2', 1, 1),
('1', 2, 2),
('1', 3, 3);

-- 13. Makse
INSERT INTO makseSet
(kuupaev, summa, makseviis, Tellimus_TellimusId)
VALUES
('2026-10-10', '7.00', 'Kaart', 1),
('2026-10-10', '9.00', 'Sularaha', 2),
('2026-10-10', '5.00', 'Kaart', 3);

-- 14. Tarnija
INSERT INTO TarnijaSet (nimi)
VALUES ('Kohvi OU'), ('Toit AS'), ('Magus OU');

-- 15. Tooraine
INSERT INTO TooraineSet
(nimi, kogus, hind, Tarnija_TaarnijaId)
VALUES
('Kohvioad', '10', '25.00', 1),
('Juust', '20', '15.00', 2),
('Sokolaad', '15', '12.00', 3);

SELECT * FROM ametSet;
SELECT * FROM TootajaSet;
SELECT * FROM ToograafikSet;
SELECT * FROM klientSet;
SELECT * FROM laudSet;
SELECT * FROM broneerimineSet;
SELECT * FROM kategooriaSet;
SELECT * FROM ToodeSet;
SELECT * FROM KoostisosaSet;
SELECT * FROM TooteKoostisosaSet;
SELECT * FROM TellimusSet;
SELECT * FROM TellimusToodeSet;
SELECT * FROM makseSet;
SELECT * FROM TarnijaSet;
SELECT * FROM TooraineSet;


SELECT
    t.nimi AS Tootaja,
    a.amet_Nimetus AS Amet
FROM TootajaSet t
JOIN ametSet a
ON t.amet_ametId = a.ametId;

SELECT
    k.nimi AS Klient,
    b.kuupaev,
    b.kellaeg,
    l.laud_number
FROM broneerimineSet b
JOIN klientSet k
ON b.klient_klientId = k.klientId
JOIN laudSet l
ON b.laud_laudId = l.laudId;

SELECT
    k.nimi AS Klient,
    p.Nimetus AS Toode,
    tt.kogus AS Kogus,
    p.hind AS Hind
FROM TellimusSet t
JOIN klientSet k
ON t.klient_klientId = k.klientId
JOIN TellimusToodeSet tt
ON t.TellimusId = tt.Tellimus_TellimusId
JOIN ToodeSet p
ON tt.Toode_ToodeId = p.ToodeId;