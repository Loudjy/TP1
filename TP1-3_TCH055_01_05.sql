DROP TABLE acteur CASCADE CONSTRAINTS;
CREATE TABLE acteur (
  idActeur     number(10) , 
  nomActeur    varchar2(255) NOT NULL, 
  prenomActeur varchar2(255) NOT NULL, 
  PRIMARY KEY (idActeur));
  
DROP TABLE caution CASCADE CONSTRAINTS;
CREATE TABLE caution (
  montantCaution    number(10) NOT NULL, 
  nombreEmpruntsMax number(10)  , 
  PRIMARY KEY (nombreEmpruntsMax),
  CONSTRAINT nombreEmpruntsMax CHECK (nombreEmpruntsMax <= 8),
  CONSTRAINT montantCaution CHECK (montantCaution >=2 AND montantCaution <= 16)
  );
   

DROP TABLE historiqueClient CASCADE CONSTRAINTS;
CREATE TABLE historiqueClient (
  idhistoriqueClient number(10)  , 
  statutClient       varchar2(255) NOT NULL,
  ancienClient       varchar2(255) NOT NULL,
  PRIMARY KEY (idhistoriqueClient)
  );
  
DROP TABLE genre CASCADE CONSTRAINTS;
CREATE TABLE genre (
  idgenre       number(10)  , 
  typeAudience varchar2(255) NOT NULL, 
  typeGenre    varchar2(255) NOT NULL, 
  PRIMARY KEY (idgenre)
  );

DROP TABLE realisateur CASCADE CONSTRAINTS;
CREATE TABLE realisateur (
  idrealisateur     number(10)  , 
  nomRealisateur    varchar2(255) NOT NULL, 
  prenomRealisateur varchar2(255) NOT NULL, 
  PRIMARY KEY (idrealisateur)
  );
  
DROP TABLE client CASCADE CONSTRAINTS;
CREATE TABLE client (
  idclient                            number(10)  , 
  nomClient                           varchar2(255) NOT NULL, 
  prenomClient                        varchar2(255) NOT NULL,  
  telephoneclient                     varchar2(255) NOT NULL, 
  historique_clientidhistoriqueClient number(10) NOT NULL, 
  cautionnombreEmpruntsMax            number(10) NOT NULL, 
  PRIMARY KEY (idclient),
  CONSTRAINT FK1client FOREIGN KEY (cautionnombreEmpruntsMax) REFERENCES caution (nombreEmpruntsMax),
  CONSTRAINT FK2client FOREIGN KEY (historique_clientidhistoriqueClient) REFERENCES historique_client (idhistoriqueClient)
  );
  
DROP TABLE adresse CASCADE CONSTRAINTS;
CREATE TABLE adresse (
  idadresse                         number(10)  , 
  numeroCivique                     number(10) NOT NULL, 
  rue                               varchar2(255) NOT NULL, 
  ville                             varchar2(255) NOT NULL, 
  codePostal                        varchar2(6) NOT NULL, 
  clientidclient                    number(10) NOT NULL,
  PRIMARY KEY (idadresse),
  FOREIGN KEY (clientidclient) REFERENCES client (idclient)
);
  
DROP TABLE film CASCADE CONSTRAINTS;
CREATE TABLE film (
  idfilm                   number(10)  , 
  titre                    varchar2(255) NOT NULL, 
  duree                    number(10) NOT NULL, 
  realisateuridrealisateur number(10) NOT NULL, 
  genreidgenre             number(10) NOT NULL, 
  PRIMARY KEY (idfilm),
  CONSTRAINT FKfilm1 FOREIGN KEY (genreidgenre) REFERENCES genre (idgenre),
  CONSTRAINT FKfilm2 FOREIGN KEY (realisateuridrealisateur) REFERENCES realisateur (idrealisateur)
  );
  
DROP TABLE dvd CASCADE CONSTRAINTS;
CREATE TABLE dvd (
  iddvd              number(10)  , 
  dateMiseService    date NOT NULL,
  nbCopiesDisponible number(10) NOT NULL, 
  noteMoyenne        number(10), 
  filmidfilm         number(10) NOT NULL, 
  PRIMARY KEY (iddvd),
  CONSTRAINT FKdvd FOREIGN KEY (filmidfilm) REFERENCES film (idfilm),
  CONSTRAINT nbCopiesDisponible CHECK (nbCopiesDisponible>0)
  );
  
DROP TABLE dvd_client CASCADE CONSTRAINTS;
CREATE TABLE dvd_client (
  dvdiddvd          number(10) NOT NULL, 
  clientidclient    number(10) NOT NULL,
  dateEmprunt       date NOT NULL, 
  dateRetour        date NOT NULL, 
  note              number(3),
  PRIMARY KEY (dvdiddvd, clientidclient),
  CONSTRAINT FKdvd_client1 FOREIGN KEY (dvdiddvd) REFERENCES dvd (iddvd),
  CONSTRAINT FKdvd_client2 FOREIGN KEY (clientidclient) REFERENCES client (idclient),
  CONSTRAINT dateRetour CHECK (dateRetour-dateEmprunt <= 7),
  CONSTRAINT note CHECK (note<=100 AND note>=0)
  );

DROP TABLE facture CASCADE CONSTRAINTS;
CREATE TABLE facture (
  idfacture      number(10)  , 
  dateEmission   date NOT NULL, 
  clientidclient number(10) NOT NULL, 
  PRIMARY KEY (idfacture),
  CONSTRAINT FKfacture FOREIGN KEY (clientidclient) REFERENCES client (idclient)
  );

DROP TABLE magasin CASCADE CONSTRAINTS;
CREATE TABLE magasin (
  idmagasin      number(10)  , 
  adressemagasin varchar2(255) NOT NULL, 
  telephoneclub  varchar2(255), 
  dvdiddvd       number(10) NOT NULL, 
  PRIMARY KEY (idmagasin),
  CONSTRAINT FK_magasin FOREIGN KEY (dvdiddvd) REFERENCES dvd (iddvd)
  );
  
DROP TABLE filmActeur CASCADE CONSTRAINTS;
CREATE TABLE filmActeur (
  filmidfilm     number(10) NOT NULL, 
  acteuridActeur number(10) NOT NULL, 
  PRIMARY KEY (filmidfilm, 
  acteuridActeur),
  CONSTRAINT FKfilm_acteur1 FOREIGN KEY (acteuridActeur) REFERENCES acteur (idActeur),
  CONSTRAINT FKfilm_acteur2 FOREIGN KEY (filmidfilm) REFERENCES film (idfilm)
  );

INSERT INTO ACTEUR (IDACTEUR, NOMACTEUR, PRENOMACTEUR)
VALUES(1, 'ROBBIE', 'MARGOT');

INSERT INTO ADRESSE (IDADRESSE, NUMEROCIVIQUE, RUE, VILLE, CODEPOSTAL, CLIENTIDCLIENT)
VALUES(1, 2899, 'DU VALAIS', 'LAVAL', 'H7K 3N4', 1);

INSERT INTO CAUTION (NOMBREEMPRUNTSMAX, MONTANTCAUTION)
VALUES(6, 12); 
VALUES(9, 16); 

INSERT INTO client(idclient, nomclient, prenomclient, telephoneclient, historique_clientidhistoriqueclient, 
cautionnombreempruntmax)
VALUES(1, 'ROULAMELLAH', 'YOUSSEF', '514-808-7846', 1, 6);

INSERT INTO DVD(IDDVD, DATEMISESERVICE, NBCOPIESDISPONIBLE, NOTEMOYENNE, FILMIDFILM)
VALUES(1, '19-12-18', 5, 98, 1);

INSERT INTO DVD_CLIENT(DVDIDDVD, CLIENTIDCLIENT, DATEEMPRUNT, DATERETOUR, NOTE)
VALUES(1, 1, '20-01-20', '20-01-26', 98);
VALUES(2, 2, '20-01-20', '20-01-29', 98);

INSERT INTO FACTURE(IDFACTURE, DATEEMISSION, CLIENTIDCLIENT)
VALUES(1, '20-01-20', 1);

INSERT INTO FILM(IDFILM, TITRE, DUREE, REALISATEURIDREALISATEUR, GENREIDGENRE)
VALUES(1, 'JOKER', 218, 1, 1);

INSERT INTO FILMACTEUR(FILMIDFILM, ACTEURIDACTEUR)
VALUES(1, 1);

INSERT INTO GENRE(IDGENRE, TYPEAUDIENCE, TYPEGENRE)
VALUES(1, 'ADULTES', 'DRAME');

INSERT INTO HISTORIQUECLIENT(IDHISTORIQUECLIENT, STATUTCLIENT, ANCIENCLIENT)
VALUES(1, 'ABONNÉ', 'DRAME');

INSERT INTO MAGASIN(IDMAGASIN, ADRESSEMAGASIN, TELEPHONECLUB, DVDIDVD)
VALUES(1, '2877 DES LAURENTIDES', '450-555-555', 1);

INSERT INTO REALISATEUR(IDREALISATEUR, NOMREALISATEUR, PRENOMREALISATEUR)
VALUES(1, 'TARANTINO', 'QUANTIN');


  
