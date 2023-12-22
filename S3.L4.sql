
/*-- Create a table*/

CREATE TABLE Dipartimento (
    id_dipartimento INT PRIMARY KEY,
    nome_dip VARCHAR(255),
    id_manager INT,
    id_location INT
);

/*-- insert some values*/
INSERT INTO Dipartimento (id_dipartimento, nome_dip, id_manager, id_location)
VALUES
 (1, 'Dipartimento1', 1, 1),
    (2, 'Dipartimento2', 2, 2),
    (3, 'Dipartimento3', 3, 3),
    (4, 'Amministrazione', 1, 2),
    (5, 'Dipartimento5', 2, 3),
    (6, 'Dipartimento6', 3, 1),
    (7, 'Dipartimento7', 1, 3),
    (8, 'Dipartimento8', 2, 1),
    (9, 'Dipartimento9', 3, 2),
    (10, 'Dipartimento10', 1, 1);

/* Fetch some values

SELECT * FROM Dipartimento;
*/

/*insert some values*/

CREATE TABLE Dipendente (
    id INT PRIMARY KEY,
    nome VARCHAR(255),
    cognome VARCHAR(255),
    email VARCHAR(255),
    numerotelefono VARCHAR(20),
    data_assunzione DATE,
    id_lavoro INT,
    salario DECIMAL(10, 2),
    id_manager INT,
    id_dipartimento INT,
    FOREIGN KEY (id_dipartimento) REFERENCES Dipartimento(id_dipartimento)
);

/*insert some values*/

INSERT INTO Dipendente (id, nome, cognome, email, numerotelefono, data_assunzione, id_lavoro, salario, id_manager, id_dipartimento)
VALUES
    (1, 'Mario', 'Rossi', 'mario.rossi@email.com', '123-456-7890', '2023-01-01', 1, 50000.00, 1, 1),
    (2, 'Laura', 'Bianchi', 'laura.bianchi@email.com', '987-654-3210', '2015-02-01', 2, 60000.00, 8, 2),
    (3, 'Luca', 'Verdi', 'luca.verdi@email.com', '111-222-3333', '2023-03-01', 3, 75000.00, NULL, 1),
    (4, 'Giulia', 'Neri', 'giulia.neri@email.com', '444-555-6666', '2023-04-01', 1, 55000.00, 3, 4),
    (5, 'Giovanni', 'Gialli', 'giovanni.gialli@email.com', '777-888-9999', '2023-05-01', 2, 70000.00, 3, 3),
    (6, 'Elena', 'Rosa', 'elena.rosa@email.com', '123-987-6543', '2023-06-01', 3, 80000.00, NULL, 1),
    (7, 'Marco', 'Azzurri', 'marco.azzurri@email.com', '111-333-5555', '2014-07-01', 1, 60000.00, 7, 4),
    (8, 'Francesca', 'Arancioni', 'francesca.arancioni@email.com', '999-888-7777', '2023-08-01', 2, 72000.00, 2, 3),
    (9, 'Antonio', 'Celesti', 'antonio.celesti@email.com', '555-444-3333', '2013-09-01', 3, 78000.00, NULL, 4),
    (10, 'Alessia', 'Marroni', 'alessia.marroni@email.com', '333-222-1111', '2000-10-01', 1, 58000.00, 10, 2);


/* Fetch some values

SELECT * FROM Dipendente;
*/

#selezionare formato data
/*
SELECT DATE_FORMAT('2020-03-15 07:10:56.123', '%D/%M/%y');
*/


/* 1) Visualizzare la data di assunzione dei manager e i loro id appartenenti al 
    dipartimento ’Amministrazione’ nel formato Nome mese, giorno, anno:*/


SELECT 
    d.id_manager,
    CONCAT(MONTHNAME(d.data_assunzione), ' ', DAY(d.data_assunzione), ', ', YEAR(d.data_assunzione)) AS DataAssunzioneManager
FROM 
    Dipendente d
JOIN 
    Dipartimento dep ON d.id_dipartimento = dep.id_dipartimento
WHERE 
    dep.nome_dip = 'Amministrazione' AND d.id_manager IS NOT NULL;


/* 2) Visualizzare il nome e il cognome dei dipendenti assunti nel mese di Giugno:*/

SELECT nome, cognome FROM Dipendente WHERE MONTH(data_assunzione) = 6;

 /* 3) Visualizzare gli anni in cui più di 3 dipendenti sono stati assunti:*/

SELECT
    YEAR(data_assunzione) AS AnnoAssunzione,
    COUNT(*) AS NumeroDipendentiAssunti
FROM
    Dipendente
GROUP BY
    AnnoAssunzione
HAVING
    NumeroDipendentiAssunti > 3;

/* 4) Visualizzare il nome del dipartimento, il nome del manager,
    il salario del manager di tutti i manager la cui esperienza è maggiore di 5 anni*/

SELECT
    dep.nome_dip AS NomeDipartimento,
    m.nome AS NomeManager,
    m.cognome AS CognomeManager,
    m.salario AS SalarioManager
FROM
    Dipendente d
JOIN
    Dipendente m ON d.id_manager = m.id
JOIN
    Dipartimento dep ON d.id_dipartimento = dep.id_dipartimento
WHERE
    DATEDIFF(NOW(), m.data_assunzione) > 5 * 365;

