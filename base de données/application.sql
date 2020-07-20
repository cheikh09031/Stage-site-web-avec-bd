drop table Congé;
drop table De_type;
drop table Facture;
drop table Agent_Commande;
drop table planning;
drop table Tour_Garde;
drop table Commandes;
drop table Clients;
drop table Employe;
drop table TypeE;
---------************************************************************************----------------
---creation de tables 
---------************************************************************************----------------

------------------------------------------------------------------------------------------------
--TABLE Employe
------------------------------------------------------------------------------------------------
create table Employe(
NumAgent NUMBER constraint pk_Employe PRIMARY KEY,
Nom VARCHAR(40),
Prenom VARCHAR(40),
Civilite VARCHAR(4)constraint CK_Civilite Check (Civilite in ('M', 'Mme','Mlle')),
Adresse VARCHAR(100),
DateNaissance date,
Sexe VARCHAR(1) constraint CK_Sexe Check (Sexe in ('M', 'F')),
Mobile Number,
Email VARCHAR(30),
NumSecuSociale number(13), 
NumPieceIdentité VARCHAR(20), 
DateExperePD date,
DateEntré date, 
Coefficient number(3), 
TypeContrat VARCHAR(3)constraint CK_Type_Contrat Check (TypeContrat in ('CDI', 'CDD')), 
ConditionTravail VARCHAR(13) constraint CK_ConditionT Check (ConditionTravail in ('Temps partiel', 'Temps complet')),
DateSorte date, 
MotifSortie VARCHAR(12)constraint CK_MotifSortie Check (MotifSortie in ('Licenciement' , 'démission')), 
DateFinContrat date, 
NumCartePro VARCHAR(30), 
DateExpireCPro date,
numbreHeurContrat number,
Photo VARCHAR(100)
);
------------------------------------------------------------------------------------------------
--TABLE Congé
------------------------------------------------------------------------------------------------
create table Congé(
NumConge NUMBER constraint Key_Congé PRIMARY KEY,  
DateDebut date,
DateFin date,
Statut VARCHAR(11)constraint CK_Statut Check (Statut in ('Favorable' , 'défavorable')),
NumAgent NUMBER
);


------------------------------------------------------------------------------------------------
--TABLE TypeE
------------------------------------------------------------------------------------------------

create table TypeE (
NomType VARCHAR(20) constraint Key_TypeE PRIMARY KEY,
PrixHeur number
);
------------------------------------------------------------------------------------------------
--TABLE De_type
------------------------------------------------------------------------------------------------

create table De_type(
NomType VARCHAR(20),
NumAgent NUMBER,
constraint Key_De_type PRIMARY KEY (NomType,NumAgent),
constraint fk_nomT foreign key (NomType) references TypeE (NomType),
constraint fk_numAg foreign key (NumAgent) references Employe (NumAgent)
);

------------------------------------------------------------------------------------------------
--TABLE Clients
------------------------------------------------------------------------------------------------

create table Clients(
Numclient NUMBER constraint pk_Clients PRIMARY KEY, 
NomCl VARCHAR(20),
Tel number,
EmailC VARCHAR(40)
);

------------------------------------------------------------------------------------------------
--TABLE Commandes
------------------------------------------------------------------------------------------------

create table Commandes( 
NumCommande number constraint pk_Commandes PRIMARY KEY, 
DateCommandeDebut date,
DateCommandefin date,
AdresseC VARCHAR(100),
NumClient NUMBER,
constraint fk_CnumClient foreign key (NumClient) references Clients (NumClient)
);
------------------------------------------------------------------------------------------------
--TABLE Agent_Commande
------------------------------------------------------------------------------------------------
create table Agent_Commande( 
NumCommande number,
NomType VARCHAR(20),
numbreAgent number, 
nombreHeur number,
constraint pk_Agent_Commande PRIMARY Key (NumCommande,NomType),
constraint fk_ACnumcom foreign key (NumCommande) references Commandes (NumCommande),
constraint fk_nomType foreign key (NomType) references TypeE (NomType)
);
------------------------------------------------------------------------------------------------
--TABLE Tour_Garde
------------------------------------------------------------------------------------------------

create table Tour_Garde(
Id_TG number constraint pk_Tour_Garde PRIMARY KEY,
AdresseT varchar(100),
DateTG date,  
HeurDebut number,
HeurFin number,
NumCommande number,
constraint fk_TGnumcom foreign key (NumCommande) references Commandes (NumCommande)
);

------------------------------------------------------------------------------------------------
--TABLE planning
------------------------------------------------------------------------------------------------

create table planning( 
Id_TG number, 
NumAgent number,
constraint pk_planning PRIMARY KEY (Id_TG,NumAgent),
constraint fk_TG foreign key (Id_TG) references Tour_Garde (Id_TG),
constraint fk_Emp foreign key (NumAgent) references Employe (NumAgent)
);

------------------------------------------------------------------------------------------------
--TABLE Facture
------------------------------------------------------------------------------------------------
create table Facture( 
Numfacture number constraint pk_Facture PRIMARY KEY, 
AdresseFacture VARCHAR(100),
DateFacturation date,
EtatPaiement VARCHAR(20)constraint CK_EtatPaiement Check (EtatPaiement in ('Réglée' , 'Non Réglée')),
NumCommande number,
constraint fk_Facnumcom foreign key (NumCommande) references Commandes (NumCommande)
);


create table connexion(
identifiant varchar(30)constraint pk_connexion PRIMARY KEY,
motdepasse  varchar(30)
);

Insert into connexion values('aaaaaaaa','aaaaaaaa');

commit;



---------------------------------------------------------------------
-- Insertion  dans la table Clients
---------------------------------------------------------------------
Insert into Clients values(1,'Mcdo',0756142547,'mcdoFranse@entreprise.fr' );
Insert into Clients values(2,'poste',0756142547,'posteFranse@entreprise.fr' );
Insert into Clients values(3,'airbus',0756142547,'airbusFranse@entreprise.fr' );
Insert into Clients values(4,'marche',0756142547,'marcheFranse@entreprise.fr');
---------------------------------------------------------------------
-- Insertion  dans la table Employe
---------------------------------------------------------------------
Insert into Employe values(1, 'Sofiane','Benh','M', 'La vache Toulouse 31200', '01/02/1997', 'M', 0750607080, 'sofiane.benh@gmail.com', 1234567899781,'123456789785415ertre', '01/01/2024', '01/05/2016', 130, 'CDI','Temps partiel', '01/07/2020', 'démission','01/07/2020','abc-111-1234-12-11-21456328797','01/06/2023',150,'Null');
Insert into Employe values(2, 'Safi','Saar','M', 'Compans Toulouse 31200', '01/08/1987', 'M', 0750607080, 'safi.saar@gmail.fr', 1234999899781,'123456789789987tyytu', '01/01/2025', '01/05/2008', 140, 'CDI','Temps complet', null, null,'01/07/2020','abc-111-1234-12-11-21456855214','01/04/2025',80,'Null');
Insert into Employe values(3, 'zizou','Samy','M', 'Compans Toulouse 31200', '01/08/2000', 'M', 0705899580, 'zizou.Samy@hotmail.fr', 1234998784581,'123450125874987poijk', '01/01/2025', '01/05/2008', 140, 'CDD','Temps complet', null, null,'01/07/2020','art-111-9934-12-11-21456855214','01/04/2022',30,'Null');
Insert into Employe values(4, 'Sonia','mone','Mme', 'Carme Toulouse 31000', '01/03/1999', 'F', 0740105632, 'Sonia.mone@gmail.com', 1230100001235,'001239949756332trffg', '01/09/2020', '01/04/2019', 120, 'CDI','Temps complet','05/04/2020', 'démission',null,'trf-111-1745-11-01-78541589998','01/02/2021',150,'Null');
Insert into Employe values(5, 'Léna','sacre','Mlle', 'jean d''arc Toulouse 31200', '01/03/1989', 'F', 0736699658, 'Léna.sacre@gmail.com', 1230100058109,'001239949785415bcfde', '01/01/2024', '01/05/2016', 130, 'CDI','Temps complet','05/04/2020', 'Licenciement','01/06/2020','trf-111-1745-12-11-21447589997','01/06/2023',150,'Null');

---------------------------------------------------------------------
-- Insertion  dans la table Commandes
---------------------------------------------------------------------
Insert into Commandes values(1,'02/08/2020','02/08/2020','compans Toulouse', 1);
Insert into Commandes values(2,'09/08/2020','02/09/2020','compans Toulouse', 1);
Insert into Commandes values(3,'22/08/2020','02/09/2020','Carme Toulouse', 2);
Insert into Commandes values(4,'02/06/2020','02/08/2020','Colomier Toulouse', 3);
Insert into Commandes values(5,'02/04/2020','05/04/2020','Palais de Justice Toulouse', 4);
---------------------------------------------------------------------
-- Insertion  dans la table Congé
---------------------------------------------------------------------
Insert into Congé values(1, '01/05/2020', '30/05/2020', 'Favorable', 1);
Insert into Congé values(2, '01/05/2020', '30/05/2020', 'défavorable', 2);
Insert into Congé values(3, '01/05/2019', '30/05/2019', 'défavorable', 3);
Insert into Congé values(4, '01/08/2020', '01/09/2020', 'Favorable', 5);

---------------------------------------------------------------------
-- Insertion  dans la table Tour_Garde
---------------------------------------------------------------------
Insert into Tour_Garde values(1,'compans Toulouse', '02/08/2020', 12.30, 18.30, 1);
Insert into Tour_Garde values(2,'compans Toulouse', '02/08/2020', 18, 01, 1);
Insert into Tour_Garde values(3,'Carme Toulouse', '22/08/2020', 18, 01, 3);
Insert into Tour_Garde values(4,'Carme Toulouse', '25/08/2020', 12, 00, 3);
Insert into Tour_Garde values(5,'Carme Toulouse', '02/09/2020', 18, 19, 3);
Insert into Tour_Garde values(6,'Palais de Justice Toulouse', '02/04/2020', 18, 19, 4);
Insert into Tour_Garde values(7,'Palais de Justice Toulouse', '12/09/2020', 18, 02, 4);
---------------------------------------------------------------------
-- Insertion  dans la table planning
---------------------------------------------------------------------

Insert into Tour_Garde values(22,'Palais de Justice Toulouse', '22/08/2020', 19, 3, 4);
Insert into planning values(1, 1);

Insert into planning values(1, 1);
Insert into planning values(2, 1);
Insert into planning values(3, 3);
Insert into planning values(4, 3);
Insert into planning values(5, 3);
Insert into planning values(6, 4);
Insert into planning values(7, 4);
/*update employe
set DATEEXPIRECPRO='01/01/2024'
where numagent=2

Insert into Tour_Garde values(11,'Palais de Justice Toulouse', '12/09/2024', 18, 02, 4);
Insert into planning values(11, 2);*/
---------------------------------------------------------------------
-- Insertion  dans la table Facture
---------------------------------------------------------------------
Insert into Facture values(1, 'Toulouse', '05/10/2020', 'Non Réglée',1);
Insert into Facture values(2,  'Toulouse', '26/08/2020', 'Réglée',2);
Insert into Facture values(3,'sud Franse', '01/09/2020',  'Non Réglée', 3 );
Insert into Facture values(4, 'Toulouse', '03/08/2020','Réglée', 4);
Insert into Facture values(5, 'centre ville Toulouse', '05/12/2020', 'Non Réglée', 5);
---------------------------------------------------------------------
-- Insertion  dans la table TypeE
---------------------------------------------------------------------
Insert into TypeE values('ADS', 10);
Insert into TypeE values('SIAP1', 11);
Insert into TypeE values('SIAP2', 12);
Insert into TypeE values('Maitre Chien', 12);
---------------------------------------------------------------------
-- Insertion  dans la table Agent_Commande
---------------------------------------------------------------------
Insert into Agent_Commande values(1, 'ADS', 2, 20);
Insert into Agent_Commande values(2, 'SIAP1', 2, 25);
Insert into Agent_Commande values(3, 'SIAP2', 1, 18);
Insert into Agent_Commande values(4, 'ADS', 5, 30);
Insert into Agent_Commande values(5, 'Maitre Chien', 1, 10);
---------------------------------------------------------------------
commit;
---------------------------------------------------------------------

---------************************************************************************----------------
--Creation de Triggers
---------************************************************************************----------------

------------------------------------------------------------------------------------------------
--date début congé inferieur à la date fin congé 
------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER t_b_i_DateConge
BEFORE
INSERT ON Congé
FOR EACH ROW
BEGIN
IF (:NEW.DateDebut >  :NEW.DateFin) THEN
    raise_application_error(-20000,'Date début supérieur à date fin congé');
    
END IF;
END;
/ 
------------------------------------------------------------------------------------------------
--ne pas planifier un agent s’il a un CDD avec une date tour de garde supérieur date fin contrat. 
------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER t_b_i_valabilité_Contrat
BEFORE INSERT ON planning
FOR EACH ROW

DECLARE
vdate DATE;
vdateFinCartePro DATE;
vdateFinId DATE;
vDateFinContrat Employe.DateFinContrat%type;

BEGIN
select datetg into vdate 
from tour_garde 
where id_tg=:new.id_tg;

SELECT DateFinContrat INTO vDateFinContrat
FROM Employe 
WHERE numagent=:new.numagent;

SELECT DATEEXPEREPD INTO vdateFinId
FROM Employe 
WHERE numagent=:new.numagent;

SELECT DATEEXPIRECPRO INTO vdateFinCartePro
FROM Employe 
WHERE numagent=:new.numagent;

IF (vDateFinContrat <  vdate) THEN
    raise_application_error(-20001,'Date expiration contrat dépassée');
END IF;
IF (vdateFinId <  vdate) THEN
    raise_application_error(-20002,'Date expiration piece d-identité dépassée');
END IF;
IF (vdateFinCartePro <  vdate) THEN
    raise_application_error(-20003,'Date expiration carte pro dépassée'); 
END IF;
END;
/
------------------------------------------------------------------------------------------------
--date/heure début tour de garde inferieur ou égale à la date/heure fin tour de garde.-- plus tard 
------------------------------------------------------------------------------------------------
/*CREATE OR REPLACE TRIGGER t_b_i_Datetour_garde
BEFORE
INSERT ON tour_garde
FOR EACH ROW

DECLARE
vDateDebutG tour_garde.DateDebutG%type;
vDateFinG tour_garde.DateFinG%type;
vHeurDebut tour_garde.HeurDebut%type;
vHeurFin tour_garde.HeurFin%type;

BEGIN
SELECT DateDebutG,DateFinG,HeurDebut,HeurFin
INTO vDateDebutG,vDateFinG,vHeurDebut,vHeurFin
FROM tour_garde
WHERE  vDateDebutG=:new.DateDebutG and vDateFinG=:new.DateFinG and vHeurDebut=:new.HeurDebut and vHeurFin=:new.HeurFin;

IF (:NEW.DateDebutG > :NEW.DateFinG) THEN
    raise_application_error(-20003,'Date tour_garde erronée');
elsif (:new.HeurDebut > :new.HeurFin and :NEW.DateDebutG =  :NEW.DateFinG)THEN
    raise_application_error(-20004,'heure tour_garde erronée');
END IF;
END;
*/
------------------------------------------------------------------------------------------------
--au moins un jour de repos dans la semaine pour chaque agent.
------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER t_b_i_jour_repos
BEFORE INSERT ON Tour_Garde
FOR EACH ROW

DECLARE
nbJoutTravaille number;
DateTG
Id_TG


BEGIN

select * --into nbJoutTravaille
from Tour_Garde
where DateTG = DATE_ADD(DateTG, INTERVAL 7 DAY);

UPDATE Tour_Garde SET DateTG = DATE_ADD(DateTG, INTERVAL 7 DAY);

------------------------------------------------------------------------------------------------
--un agent ne peut pas être planifier plusieurs fois en même temps en meme date. 
------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER t_b_i_valabilité_Contrat
BEFORE INSERT ON planning
FOR EACH ROW

DECLARE
Hdeb number;
hfin number;
vdatetg date;
VraiHfinAgent number;

BEGIN
select heurdebut, HEURFIn, datetg into hdeb, hfin,vdatetg
from tour_garde 
where id_tg=:new.id_tg;

if (heurdebut> HEURFIn) then
heurfin:=24+HEURFIn; --Si par ex 20h-01h heure  fin sera à 25h pour ne pas avoir d'erreur dans le between
end if;

FOR c IN 
(select t.heurdebut, t.HEURFIn
from tour_garde t, planning p
where p.id_tg=t.id_tg and p.numagent=:new.numagent and t.datetg=vdatetg) 
LOOP 
    if (c.heurdebut > c.heurfin) then --ex 23h-01h
        VraiHfinAgent:=24+c.heurfin;---hfin=25h
    else VraiHfinAgent:=c.heurfin;
    end if;
    
    IF (hdeb between c.heurdebut and VraiHfinAgent) THEN
        raise_application_error(-20004,'Agent occupé à l-heure de début de la tour de garde');
    END IF;
    IF (hfin between c.heurdebut and VraiHfinAgent) THEN
        raise_application_error(-20005,'Agent occupé à l-heure de fin de la tour de garde');
    END IF;  
end loop; 
END;


------------------------------------------------------------------------------------------------
--un agent ne se planifier pas durant son congé.
------------------------------------------------------------------------------------------------

---------************************************************************************----------------
--les views
---------************************************************************************----------------
-- vue pour les informations des l'employes

CREATE  OR REPLACE VIEW info_agent AS 
 SELECT Nom, Prenom,NumAgent, Adresse, Mobile, Email
 FROM employe;
---------------------
CREATE  OR REPLACE VIEW info_agent_sup AS 
 SELECT Nom, Prenom,NumAgent, Adresse, Mobile, Email,DateEntré,TypeContrat,NumCartePro,Photo
 FROM employe;
 
 -----------------------

  -- Vue les informations des clients
CREATE  OR REPLACE VIEW info_Client AS 
select NomCl,Numclient,Tel,EmailC  
from Clients;

 
 -- Vue emploi du temps agents
 CREATE  OR REPLACE VIEW emploi_temps_agents AS
 select p.NumAgent,t.DateTG,t.HeurDebut,t.HeurFin,t.AdresseT,e.Nom, e.Prenom,l.NomCl
 from Tour_Garde t,employe e, planning p,Commandes c, Clients l
 where t.Id_TG=p.Id_TG and e.NumAgent=p.NumAgent and c.Numclient=l.Numclient and c.NumCommande=t.NumCommande;

 --Vue Commandes clients
 
 CREATE  OR REPLACE VIEW Commandes_passees AS
 select l.NomCl,c.NumCommande,c.DateCommandeDebut,c.DateCommandefin,c.AdresseC
 from Commandes c,Clients l
 where c.NumClient=l.NumClient and c.DateCommandefin < sysdate ;
 
 CREATE  OR REPLACE VIEW Commandes_Actuelles AS
 select l.NomCl,c.NumCommande,c.DateCommandeDebut,c.DateCommandefin,c.AdresseC
 from Commandes c,Clients l
 where c.NumClient=l.NumClient and c.DateCommandefin >= sysdate;
 
 commit;
 
 -------------------------------------
 CREATE  OR REPLACE VIEW Commandes_sup AS
 select l.NomCl,l.NumClient,l.Tel,l.EmailC,c.NumCommande,c.DateCommandeDebut,c.DateCommandefin,c.AdresseC
 from Commandes c,Clients l
 where c.NumClient=l.NumClient;

 
 

 --Faire une vue pour les factures Réglée
  CREATE  OR REPLACE VIEW  factures_Reglee AS
 select f.Numfacture,f.NumCommande,l.NomCl,f.AdresseFacture,f.DateFacturation,f.EtatPaiement
 from Facture f,Commandes c,Clients l
 where c.NumClient=l.NumClient and f.NumCommande=c.NumCommande and f.EtatPaiement='Réglée' ;
  
   --Faire une vue pour les factures Non Réglée
    CREATE  OR REPLACE VIEW  factures_Non_Reglee AS
 select f.Numfacture,f.NumCommande,l.NomCl,f.AdresseFacture,f.DateFacturation,f.EtatPaiement
 from Facture f,Commandes c,Clients l
 where c.NumClient=l.NumClient and f.NumCommande=c.NumCommande and f.EtatPaiement='Non Réglée' ;
 
 --vue pour les factures Réglée
 --vue pour les factures Non Réglée
 --vue pour les evenments des agents
--vue pour les Historique des agents
--Faire une vue pour les congés_Favorable
--Faire une vue pour les congés_deFavorable


 --Faire une vue pour les evenments des agents
CREATE  OR REPLACE VIEW  evenments_agents AS
select Nom, Prenom,DateNaissance,DateExperePD,DateFinContrat,DateExpireCPro
from employe;

 --Faire une vue pour les Historique des agents
CREATE  OR REPLACE VIEW  Historique_agents AS
select NumAgent,Nom,Prenom,DateEntré,DateSorte,MotifSortie
from employe;

--Faire une vue pour les congés_Favorable

CREATE  OR REPLACE VIEW  conges_favorable AS
select g.NumConge,g.NumAgent,e.Nom,e.Prenom,g.DateDebut,g.DateFin,g.Statut
from congé g,employe e
where g.NumAgent=e.NumAgent and g.Statut= 'Favorable';

--Faire une vue pour les congés_deFavorable
CREATE  OR REPLACE VIEW  conges_deFavorable AS
select g.NumConge,g.NumAgent,e.Nom,e.Prenom,g.DateDebut,g.DateFin,g.Statut
from congé g,employe e
where g.NumAgent=e.NumAgent and g.Statut= 'défavorable';

commit;
-----------------------------------
--procedure affiche les agents libres dans une date et heure précise et qui ne sont pas en congé

ACCEPT pDateTG PROMPT 'Entrer la Date Debut de Tour de garde: '; 

DECLARE 
vNumAgent employe.NumAgent%Type; 
vNom employe.Nom%Type; 
vPrenom employe.Prenom%Type; 
 BEGIN 
 select e.NumAgent,e.Nom,e.Prenom 
 into vNumAgent,vNom,vPrenom
 from employe e,Tour_Garde t,planning p
 where t.Id_TG=p.Id_TG and e.NumAgent=p.NumAgent and t.DateTG != '&pDateDebutG' ;
 dbms_output.put_line( 'Numero_Agent' || vNumAgent || 'Nom'|| vNom || 'Prenom'|| vPrenom);
END;
/ 
------------------------------------------------
ACCEPT pDateTG PROMPT 'Entrer la Date de Tour de garde: '; 
ACCEPT HeurDebut PROMPT 'Entrer l heure Debut de Tour de garde: '; 
ACCEPT HeurFin PROMPT 'Entrer l heure fin de Tour de garde: '; 

Declare
vNumAgent employe.NumAgent%Type; 
vNom employe.Nom%Type; 
vPrenom employe.Prenom%Type;

cursor c is
EXCEPTION
    when NO_DATA_FOUND then 
    DBMS_OUTPUT.PUT_LINE('Matière inconnue');
    when OTHERS
    then DBMS_OUTPUT.PUT_LINE('Erreur');
END;
/
 
 Insert into Tour_Garde values(1,'compans Toulouse', '02/08/2020', 12.30, 18.30, 1);
Insert into Tour_Garde values(2,'compans Toulouse', '02/08/2020', 18, 01, 1);
Insert into Tour_Garde values(3,'Carme Toulouse', '22/08/2020', 18, 01, 3);
Insert into Tour_Garde values(4,'Carme Toulouse', '25/08/2020', 12, 00, 3);
Insert into Tour_Garde values(5,'Carme Toulouse', '02/09/2020', 18, 19, 3);
Insert into Tour_Garde values(6,'Palais de Justice Toulouse', '02/04/2020', 18, 19, 4);
Insert into Tour_Garde values(7,'Palais de Justice Toulouse', '12/09/2020', 18, 02, 4);
------------------
Insert into Congé values(1, '01/05/2020', '30/05/2020', 'Favorable', 1);
Insert into Congé values(2, '01/05/2020', '30/05/2020', 'défavorable', 2);
Insert into Congé values(3, '01/05/2019', '30/05/2019', 'défavorable', 3);
Insert into Congé values(4, '01/08/2020', '01/09/2020', 'Favorable', 5);
--procedure affiche les agents libres dans une date et heure précise et qui ne sont pas en congé

select distinct e.NumAgent, e.Nom, e.Prenom --into NumAgent,vNom,vPrenom
from Employe e,Tour_Garde t,planning p,Congé c
where p.NumAgent=e.NumAgent and p.Id_TG=t.Id_TG and c.NumAgent=e.NumAgent and t.DateTG not between c.DateDebut and  c.DateFin --and  c.Statut='Favorable' and t.DateTG='02/08/2020' and t.HeurDebut !='6' and HeurFin != '11';
Minus
select distinct e.NumAgent, e.Nom, e.Prenom
from Employe e,Tour_Garde t,planning p,Congé c
where p.NumAgent=e.NumAgent and p.Id_TG=t.Id_TG and c.NumAgent=e.NumAgent and  c.Statut='Favorable' and t.DateTG ='02/08/2020' and t.HeurDebut !='6' and HeurFin != '11' and t.DateTG not between c.DateDebut and  c.DateFin ;

