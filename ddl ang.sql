#Testowane dla MySQL 5.5.62

CREATE DATABASE IF NOT EXISTS narodowy_program_szczepien;

USE narodowy_program_szczepien;

DROP TABLE IF EXISTS `Dostawa`;
DROP TABLE IF EXISTS `NOP`;
DROP TABLE IF EXISTS `Szczepienie`;
DROP TABLE IF EXISTS `Lekarz`;
DROP TABLE IF EXISTS `Punkt_szczepien`;
DROP TABLE IF EXISTS `Ozdrowieniec`;
DROP TABLE IF EXISTS `Certyfikat`;
DROP TABLE IF EXISTS `Osoba`;
DROP TABLE IF EXISTS `Wyszczepienie`;
DROP TABLE IF EXISTS `Szczepionka`;
DROP TABLE IF EXISTS `Producent`;

CREATE TABLE `Producent`
(
	`ID_Producenta` INT PRIMARY KEY AUTO_INCREMENT,
    `Nazwa` VARCHAR(25) NOT NULL,
    `Kraj` VARCHAR(25) NOT NULL
);

CREATE TABLE `Szczepionka`
(
	`ID_Szczepionki` INT PRIMARY KEY AUTO_INCREMENT,
    `ID_Producenta` INT NOT NULL,
    `Typ` VARCHAR(15) NOT NULL,
    `Nazwa` VARCHAR(25) NOT NULL,
    `Liczba_dawek` TINYINT NOT NULL,
    `Wymagany_wiek` TINYINT NOT NULL,
    `Przeciwwskazania` TEXT NULL DEFAULT NULL,
    `Cena` FLOAT NOT NULL,
    CONSTRAINT FK_Szczepionka_Producent FOREIGN KEY (ID_Producenta) REFERENCES Producent(ID_Producenta) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT CHK_wiek_dodatni CHECK(Wymagany_wiek >= 0),
    CONSTRAINT CHK_dawki_dodatnie CHECK(Liczba_dawek > 0),
    CONSTRAINT CHK_cena CHECK(Cena > 0)
);

CREATE TABLE `Wyszczepienie`
(
	`Miasto` VARCHAR(25) PRIMARY KEY,
    `Procent` FLOAT NOT NULL DEFAULT 0
);

DROP PROCEDURE IF EXISTS oblicz_wyszczepienie;
DELIMITER $$
CREATE PROCEDURE oblicz_wyszczepienie()
BEGIN
	DECLARE temp_miast VARCHAR(25);
    DECLARE proc FLOAT DEFAULT 0.0;
    DECLARE koniec BOOL DEFAULT FALSE;
	
	DECLARE cur CURSOR FOR
		SELECT P.Miasto, COUNT(C.PESEL) / COUNT(P.PESEL)
		FROM Osoba P LEFT JOIN Certyfikat C ON P.PESEL = C.PESEL
        GROUP BY P.Miasto;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET koniec = TRUE;
    
    OPEN cur;
    REPEAT
        FETCH cur INTO temp_miast, proc;
        UPDATE Wyszczepienie SET Procent = proc WHERE Miasto = temp_miast;
    UNTIL koniec  = TRUE END REPEAT;
    CLOSE cur;
END $$
DELIMITER ;

CREATE TABLE `Osoba`
(
	`PESEL` CHAR(11) PRIMARY KEY,
    `Imie` VARCHAR(25) NOT NULL,
    `Nazwisko` VARCHAR(30) NOT NULL,
    `Ulica` VARCHAR(25) NOT NULL,
    `Budynek` VARCHAR(5) NOT NULL,
    `Mieszkanie` SMALLINT NULL DEFAULT NULL,
    `Miasto` VARCHAR(25) NOT NULL,
    `Telefon` CHAR(11) NOT NULL, #48 123456789
    `Email` VARCHAR(50) NOT NULL,
    CONSTRAINT CHK_Osoba_Mail CHECK( Email LIKE '%@%.%')
);

DROP FUNCTION IF EXISTS data_certyfikatu;
Delimiter $$
CREATE FUNCTION data_certyfikatu()
RETURNS DATE
BEGIN
	RETURN CURDATE() + INTERVAL 270 DAY;
END $$
Delimiter ;

CREATE TABLE `Certyfikat`
(
	`ID_Certyfikatu` INT PRIMARY KEY AUTO_INCREMENT,
    `PESEL` CHAR(11) NOT NULL UNIQUE,
    `Czy_w_pelni_zaszczepiony` BOOL NOT NULL DEFAULT FALSE,
    `Wazny_do` DATE NOT NULL,
    CONSTRAINT FK_Certyfikat_Osoba FOREIGN KEY (PESEL) REFERENCES Osoba(PESEL) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE `Ozdrowieniec`
(
	`ID_Ozdrowienca` INT PRIMARY KEY AUTO_INCREMENT,
    `PESEL` CHAR(11) NOT NULL,
    `Data_Testu` DATE NOT NULL,
    `Data_wyzdrowienia` DATE NULL,
    CONSTRAINT FK_Ozdrowieniec_Osoba FOREIGN KEY (PESEL) REFERENCES Osoba(PESEL) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT CHK_Ozdrowieniec_Daty CHECK(Data_Wyzdrowienia > Data_Testu)
);

CREATE TABLE `Punkt_Szczepien`
(
	`ID_Punktu` INT PRIMARY KEY AUTO_INCREMENT,
    `Ulica` VARCHAR(25) NOT NULL,
    `Budynek` VARCHAR(5) NOT NULL,
    `Mieszkanie` SMALLINT NULL DEFAULT NULL,
    `Miasto` VARCHAR(25) NOT NULL,
    `Telefon` CHAR(11) NOT NULL #48 123456789
);

CREATE TABLE `Lekarz`
(
	`ID_Lekarza` INT PRIMARY KEY AUTO_INCREMENT,
    `Imie` VARCHAR(25) NOT NULL,
    `Nazwisko` VARCHAR(30) NOT NULL,
    `Specjalizacja` VARCHAR(25) NOT NULL
);

DROP FUNCTION IF EXISTS dopuscic_do_szczepienia;
DELIMITER $$
CREATE FUNCTION dopuscic_do_szczepienia (id CHAR(11), szcz INT, dawka INT)
RETURNS BOOL
NOT DETERMINISTIC
BEGIN
    DECLARE wiek INT;
    DECLARE ozdrow DATE;
    DECLARE ost_szcz DATE;
    DECLARE szcz_wiek INT;
    DECLARE szcz_daw INT;
    IF CAST( SUBSTR(id, 3, 2) AS SIGNED INT) > 12 THEN SET wiek = YEAR(CURDATE()) - CAST(LEFT(id, 2) AS SIGNED INT) - 2000;
    ELSE SET wiek = YEAR(CURDATE()) - CAST(LEFT(id, 2) AS SIGNED INT) - 1900;
    END IF;
    (SELECT Wymagany_wiek INTO szcz_wiek FROM Szczepionka WHERE ID_Szczepionki = szcz);
    IF wiek < szcz_wiek THEN RETURN FALSE; END IF;
    (SELECT Data_Testu INTO ozdrow FROM Ozdrowieniec WHERE PESEL = id);
    IF (ozdrow IS NOT NULL AND ozdrow + INTERVAL 30 DAY > CURDATE()) THEN RETURN FALSE; END IF;
    (SELECT Liczba_dawek INTO szcz_daw FROM Szczepionka WHERE ID_Szczepionki = szcz);
    IF dawka > szcz_daw THEN
		(SELECT `Data` INTO ost_szcz FROM Szczepienie WHERE (PESEL = id) AND (`Data` + INTERVAL 180 DAY >= CURDATE()) );
        IF ost_szcz IS NOT NULL THEN RETURN FALSE; END IF;
    END IF;
	RETURN TRUE;
END; $$
DELIMITER ;

CREATE TABLE `Szczepienie`
(
	`ID_Szczepienia` INT PRIMARY KEY AUTO_INCREMENT,
    `PESEL` CHAR(11) NOT NULL,
    `ID_Szczepionki` INT NOT NULL,
    `ID_Punktu` INT NOT NULL,
    `ID_Lekarza` INT NOT NULL,
    `Data` DATE NOT NULL,
    `Dawka` TINYINT NOT NULL,
    `Czy_wykonane` BOOL NULL,
    CONSTRAINT FK_Szczepienie_Osoba FOREIGN KEY (PESEL) REFERENCES Osoba(PESEL) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT FK_Szczepienie_Punkt FOREIGN KEY (ID_Punktu) REFERENCES Punkt_Szczepien(ID_Punktu) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT FK_Szczepienie_Lekarz FOREIGN KEY (ID_Lekarza) REFERENCES Lekarz(ID_Lekarza) ON UPDATE CASCADE ON DELETE RESTRICT
    #,CONSTRAINT CHK_czy_dopuszczalny CHECK( dopuscic_do_szczepienia(PESEL, ID_Szczepionki, Dawka) ) #Nie działa w niektórych systemach
);

DELIMITER $$ #Wymagany root lokalny
DROP TRIGGER IF EXISTS nie_mozna_zaszczepic;
CREATE TRIGGER nie_mozna_zaszczepic BEFORE INSERT ON Szczepienie
FOR EACH ROW
	IF NOT dopuscic_do_szczepienia(NEW.PESEL, NEW.ID_Szczepionki) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nie mozna zaszczepic tej osoby!';
	END IF;
END; $$

DROP TRIGGER IF EXISTS nowe_szczepienie;
CREATE TRIGGER nowe_szczepienie AFTER INSERT ON Szczepienie
FOR EACH ROW
	CALL oblicz_wyszczepienie();
END; $$
DELIMITER ;

CREATE TABLE `NOP`
(
	`ID_NOP` INT PRIMARY KEY AUTO_INCREMENT,
    `ID_Szczepienia` INT NOT NULL,
    `Data` DATE NOT NULL,
    `Opis` TEXT NOT NULL,
    CONSTRAINT FK_NOP_Szczepienie FOREIGN KEY (ID_Szczepienia) REFERENCES Szczepienie(ID_Szczepienia) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE `Dostawa`
(
	`ID_Dostawy` INT PRIMARY KEY AUTO_INCREMENT,
    `ID_Punktu` INT NOT NULL,
    `ID_Szczepionki` INT NOT NULL,
    `Ilosc` INT NOT NULL,
    CONSTRAINT FK_Dostawa_Punkt FOREIGN KEY (ID_Punktu) REFERENCES Punkt_Szczepien(ID_Punktu) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT FK_Dostawa_Szczepionka FOREIGN KEY (ID_Szczepionki) REFERENCES Szczepionka(ID_Szczepionki) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT CHK_Dostawa_Ilosc CHECK(Ilosc > 0)
);

DROP VIEW IF EXISTS Zaszczepieni;
CREATE VIEW zaszczepieni AS (
SELECT P.Imie, P.Nazwisko, Va.Nazwa AS "Szczepionka", V.Dawka, V.Data, C.Wazny_do
FROM Szczepienie V INNER JOIN Osoba P
	ON V.PESEL = P.PESEL
    INNER JOIN Szczepionka Va
    ON V.ID_Szczepionki = Va.ID_Szczepionki
    INNER JOIN Certyfikat C
    ON P.PESEL = C.PESEL
ORDER BY 2 ASC, 1 ASC);

DROP VIEW IF EXISTS Ozdrowiency;
CREATE VIEW Ozdrowiency AS (
SELECT P.Imie, P.Nazwisko, R.Data_Testu, R.Data_Wyzdrowienia
FROM Ozdrowieniec R INNER JOIN Osoba P
	ON R.PESEL = P.PESEL
ORDER BY 2 ASC, 1 ASC);
