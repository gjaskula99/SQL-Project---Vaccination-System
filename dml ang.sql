#Testowane dla MySQL 5.5.62

USE narodowy_program_szczepien;

INSERT INTO Producent VALUES(1, 'Pfizer BionTech', 'Niemcy');
INSERT INTO Producent VALUES(2, 'Astra Zeneca', 'Wielka Brytania');
INSERT INTO Producent VALUES(3, 'Novavax', 'USA');
INSERT INTO Producent VALUES(4, 'Moderna', 'USA'); 
INSERT INTO Producent VALUES(5, 'Spikevax', 'USA'); 

INSERT INTO Szczepionka VALUES(1, 1, 3, 'Pfizer Covid Vacc', 2, 18, NULL, 12.49);
INSERT INTO Szczepionka VALUES(2, 2, 1, 'Astra Zeneca Covid Vacc', 4, 18, NULL, 17.99);
INSERT INTO Szczepionka VALUES(3, 3, 2, 'Novavax Covid Vacc', 2, 15, NULL, 20.10);
INSERT INTO Szczepionka VALUES(4, 4, 3, 'Moderna Covid Vacc', 3, 12, NULL, 18.50);
INSERT INTO Szczepionka VALUES(5, 5, 1, 'Spikevax Covid Vacc', 3, 12, NULL, 20.99);

INSERT INTO Wyszczepienie VALUES ('Poznan', 0.0);
INSERT INTO Wyszczepienie VALUES ('Warszawa', 0.0);
INSERT INTO Wyszczepienie VALUES ('Gdansk', 0.0);
INSERT INTO Wyszczepienie VALUES ('Bygoszcz', 0.0);
INSERT INTO Wyszczepienie VALUES ('Rzeszow', 0.0);
INSERT INTO Wyszczepienie VALUES ('Sandomierz', 0.0);
INSERT INTO Wyszczepienie VALUES ('Szczecin', 0.0);
INSERT INTO Wyszczepienie VALUES ('Miedzyzdroje', 0.0);
INSERT INTO Wyszczepienie VALUES ('Wadowice', 0.0);

INSERT INTO Punkt_Szczepien VALUES (1, 'Piotrowo', '3A', NULL, 'Poznan', '48589871549');
INSERT INTO Punkt_Szczepien VALUES (2, 'Czechoslowacka', '5B', NULL, 'Poznan', '48129876543');
INSERT INTO Punkt_Szczepien VALUES (3, 'Polna', '2C', NULL, 'Gdansk', '48384676521');
INSERT INTO Punkt_Szczepien VALUES (4, 'Dziewicza', '15B', NULL, 'Rzeszow', '48429876321');
INSERT INTO Punkt_Szczepien VALUES (5, 'Nizinna', '1A', NULL, 'Miedzyzdroje', '48989876326');
INSERT INTO Punkt_Szczepien VALUES (6, 'Mloda', '6B', NULL, 'Sandomierz', '48584474321');

INSERT INTO Osoba VALUES('80103012341', 'Jerzy', 'Tyszer', 'Chabrowa', '15A', 3, 'Poznan', '48123459789', 'jerzy@tyszer.com');
INSERT INTO Osoba VALUES('86124610592', 'Paweł', 'Kryszkiewicz', 'Radiowa', '98B', 3, 'Sandomierz', '48485638924', 'pawel.kryszkiewicz@gmail.com');
INSERT INTO Osoba VALUES('00220610191', 'Adam', 'Rektor', 'Agrestowa', '78A', 2, 'Rzeszow', '48494650234', 'adam.rektor@gmail.com');
INSERT INTO Osoba VALUES('75020610191', 'Grzegorz', 'Jaskula', 'Mleczna', '6B', 1, 'Rzeszow', '48494650234', 'Grzegorz.jaskul@gmail.com');
INSERT INTO Osoba VALUES('00221254321', 'Wercia', 'Szab', 'Babicka', '23C', 8, 'Poznan', '48947654321', 'Wercia.szab@o2.com');
INSERT INTO Osoba VALUES('66041234361', 'Lukasz', 'Niedzwiedz', 'Barana', '33C', 11, 'Miedzyzdroje', '48123456789', 'lukasz.niedzwiedz@gmail.com');
INSERT INTO Osoba VALUES('00221254721', 'Masko', 'Gruby', 'Drwali', '121A', 6, 'Rzeszow', '48457692137', 'Masko.Gruby@gmail.com');
INSERT INTO Osoba VALUES('00221654382', 'Dziubas', 'Tilt', 'Dolina', '4B', 6, 'Gdansk', '48698890396', 'Dziubas.Tilt@gmail.com');
INSERT INTO Osoba VALUES('00046335343', 'Jakub', 'Plucinski', 'Bialobrzeska', '44C', 4, 'Gdansk', '48694356969', 'Jakub.Plucinski@gmail.com');
INSERT INTO Osoba VALUES('95032455673', 'Grzegorz', 'Wardega', 'Darzynska', '72A', 3, 'Gdansk', '48467839696', 'Grzegorz.Wardega@gmail.com');
INSERT INTO Osoba VALUES('88101543382', 'Eska', 'Piec', 'KubusiaPuchatka', '67B', 1, 'Gdansk', '48675679696', 'Eska.Piec@gmail.com');
INSERT INTO Osoba VALUES('72123045178', 'Aisaka', 'Ajaja', 'Valorant', '69A', 7, 'Wadowice', '48997998999', 'Aisaka.Ajaja@gmail.com');
INSERT INTO Osoba VALUES('00320610164', 'Piotr', 'Tomczak', 'Sredniowieczna', '65A', 2, 'Poznan', '48678302946', 'Piotr.Tomczak@gmail.com');
INSERT INTO Osoba VALUES('00320610196', 'Maksymilian', 'Guntarek', 'Gnieznienska', '12', 3, 'Szczecin', '48789424142', 'Maksymilian.Guntarek@gmail.com');
INSERT INTO Osoba VALUES('00330610292', 'Bartek', 'Kaluzny', 'Powstancow Wielkopolskich', '6', 7, 'Szczecin', '48374902148', 'bartosz.kaluzny@gmail.com');
INSERT INTO Osoba VALUES('00330610293', 'Olga', 'Scheffs', 'Jagiellonsa', '6B', 6, 'Miedzyzdroje', '48720903927', 'Olga.Scheffs@gmail.com');
INSERT INTO Osoba VALUES('00330610294', 'Hubert', 'Nowakowski', 'Wielka', '6B', 7, 'Wadowice', '48759325235', 'jakub.sechejko@gmail.com');

INSERT INTO Lekarz VALUES(1, 'Jan', 'Kowalski', 1);
INSERT INTO Lekarz VALUES(2, 'Mateusz', 'Matuszewski', 2);
INSERT INTO Lekarz VALUES(3, 'Wojtek', 'Ziemniak', 4);
INSERT INTO Lekarz VALUES(4, 'Piotr', 'Zielenski', 6);
INSERT INTO Lekarz VALUES(5, 'Maciej', 'Miodek', 1);
INSERT INTO Lekarz VALUES(6, 'Michal', 'Slodziak', 3);
INSERT INTO Lekarz VALUES(7, 'Adam', 'Malysz', 2);
INSERT INTO Lekarz VALUES(8, 'Lukasz', 'Kowalski', 2);

INSERT INTO Dostawa VALUES(1, 1, 3, 456);
INSERT INTO Dostawa VALUES(2, 1, 2, 2132);
INSERT INTO Dostawa VALUES(3, 2, 1, 4526);
INSERT INTO Dostawa VALUES(4, 2, 1, 224);
INSERT INTO Dostawa VALUES(5, 2, 2, 345);
INSERT INTO Dostawa VALUES(6, 3, 4, 3243);
INSERT INTO Dostawa VALUES(7, 3, 4, 3356);
INSERT INTO Dostawa VALUES(8, 6, 2, 2167);
INSERT INTO Dostawa VALUES(9, 2, 2, 1000);
INSERT INTO Dostawa VALUES(10, 5, 5, 992);
INSERT INTO Dostawa VALUES(11, 3, 2, 132);
INSERT INTO Dostawa VALUES(12, 6, 5, 453);

INSERT INTO Ozdrowieniec VALUES(1, '00220610191','2021-05-02 08:11:13', '2021-05-20 17:25:30');
INSERT INTO Ozdrowieniec VALUES(2, '75020610191','2021-06-14 19:20:57', '2021-06-30 07:47:01');
INSERT INTO Ozdrowieniec VALUES(3, '00221254721','2021-10-30 21:31:40', '2021-11-07 12:00:54');
INSERT INTO Ozdrowieniec VALUES(4, '00221254721','2021-09-015 8:10:02', '2021-05-20 17:25:30');
INSERT INTO Ozdrowieniec VALUES(6, '00330610294',CURDATE(), NULL);
INSERT INTO Ozdrowieniec VALUES(7, '00330610293',CURDATE(), NULL);
INSERT INTO Ozdrowieniec VALUES(8, '00320610196',CURDATE(), NULL);

INSERT INTO Szczepienie VALUES(1, '00220610191', 1, 1, 1, '2021-09-08 08:11:13', 2, 1);
INSERT INTO Szczepienie VALUES(2, '75020610191', 2, 2, 2, '2021-11-07 21:16:13', 2, 0);
INSERT INTO Szczepienie VALUES(3, '66041234361', 3, 2, 3, '2021-06-03 18:11:15', 3, 1);
INSERT INTO Szczepienie VALUES(4, '88101543382', 2, 5, 2, '2021-12-07 16:12:14', 2, 1);
INSERT INTO Szczepienie VALUES(5, '00221254321', 4, 6, 5, '2021-10-06 12:15:11', 1, 0);
INSERT INTO Szczepienie VALUES(6, '86124610592', 5, 3, 3, '2021-11-06 11:13:08', 2, 1);
INSERT INTO Szczepienie VALUES(7, '00046335343', 5, 3, 1, '2021-12-07 14:16:11', 2, 1);
INSERT INTO Szczepienie VALUES(8, '00320610196', 1, 2, 3, '2021-12-08 17:18:15', 2, 1);

INSERT INTO Certyfikat VALUES(1, '00220610191', 1, '2020-09-08 08:11:13' + INTERVAL 270 DAY);
INSERT INTO Certyfikat VALUES(2, '75020610191', 1, '2020-11-07 21:16:13' + INTERVAL 270 DAY);
INSERT INTO Certyfikat VALUES(3, '66041234361', 1, '2020-06-03 18:11:15' + INTERVAL 270 DAY);
INSERT INTO Certyfikat VALUES(4, '88101543382', 1, '2021-12-07 16:12:14' + INTERVAL 270 DAY);
INSERT INTO Certyfikat VALUES(5, '00221254321', 0, '2021-10-06 12:15:13' + INTERVAL 270 DAY);
INSERT INTO Certyfikat VALUES(6, '86124610592', 1, '2021-02-07 12:16:56' + INTERVAL 270 DAY);
INSERT INTO Certyfikat VALUES(7, '00320610196', 1, '2021-01-06 11:12:50' + INTERVAL 270 DAY);
INSERT INTO Certyfikat VALUES(8, '00046335343', 1, '2021-12-06 11:11:12' + INTERVAL 270 DAY);

INSERT INTO NOP VALUES(1, 1, '2020-09-08 08:11:13' + INTERVAL 1 DAY, 'Wymioty');
INSERT INTO NOP VALUES(2, 2, '2020-11-07 21:16:13' + INTERVAL 1 DAY, 'Ból w miejscu ukłucia');
INSERT INTO NOP VALUES(3, 3, '2020-06-03 18:11:15' + INTERVAL 1 DAY, 'Ból miesni');
INSERT INTO NOP VALUES(4, 4, '2020-10-06 12:15:13' + INTERVAL 1 DAY, 'Drgawki');

SELECT * FROM Zaszczepieni;
SELECT * FROM Ozdrowiency;
SELECT * FROM Osoba;
CALL oblicz_wyszczepienie(); #dla braku wyzwalaczy
SELECT * FROM Wyszczepienie;