Activite 2:


1.• Ecrire une fonction qui retourne la liste de tous les joueurs ayant participé à un
match particulier dont on connaît l’identifiant.

SELECT GROUP_CONCAT(jou_pseudojoueur) FROM t_joueur_jou
join t_match_mtc using(mtc_id)
where mtc_codematch="AER82987";

DELIMITER //
CREATE FUNCTION liste_joueur(match_id CHAR(8)) RETURNS TEXT
BEGIN
 SET @liste := (SELECT GROUP_CONCAT(jou_pseudojoueur) FROM t_joueur_jou
 join t_match_mtc using(mtc_id)
 where mtc_codematch=match_id);
 RETURN @liste;
END;
//
DELIMITER ;

2.• Testez cette fonction

select liste_joueur("AER82987");



3.Ecrire alors une procédure qui insère une actualité à la date d’aujourd’hui
connaissant l’identifiant d’un match et en précisant l’intitulé du match, sa date de
début et de fin et bien sûr la liste des joueurs ayant participé. Une actualité dont
l’auteur de l’actualité sera l’administrateur principal (« responsable ») sera ajoutée
si le match choisi est fini.


DELIMITER //
CREATE PROCEDURE insere_actu(IN ID_MATCH INT)
BEGIN
 SET @intitule := (SELECT mtc_int FROM t_match_mtc
                  where mtc_id=ID_MATCH);
 SET @datedebut := (SELECT mtc_date_debut FROM t_match_mtc
                  where mtc_id=ID_MATCH);
 SET @datefin := (SELECT mtc_date_fin FROM t_match_mtc
                  where mtc_id=ID_MATCH);
 SET @liste := (SELECT GROUP_CONCAT(jou_pseudojoueur) FROM t_joueur_jou
 join t_match_mtc using(mtc_id)
 where mtc_id=ID_MATCH);
  IF @datefin < CURRENT_DATE THEN
 SET @auteur := 1;
 ELSE 
 SET @auteur := 2;
 
 END IF;
 
  insert into t_actu_act(act_int,act_date,act_txt,cpt_id)
VALUES('test',CURRENT_DATE,CONCAT(@intitule,' a ouvert le ', @datedebut,' et a fermé le ',@datefin,' Les joueurs qui ont participé sont: ',@liste),@auteur);

END;
//
DELIMITER ;

4.• Testez cette procédure.


call insere_actu(1);


5.Puis, en réutilisant ce qui a été fait précédemment, créez un déclencheur (trigger)
ajoutant une actualité dès la fin d’un match.

DELIMITER //
CREATE TRIGGER date_passe BEFORE INSERT ON t_actu_act
FOR EACH ROW 
BEGIN 
	set @datefin := (select mtc_date_fin from t_match_mtc);
    IF @datefin >= curdate() Then 
    INSERT INTO t_actu_act 
    VALUES(NULL,"FERMETURE D'U QUIZ",CURRENT_DATE,"Fermeture du quiz",3);
    end if;

END//
DELIMITER ;


Activite 3:

1.• Ecrivez une procédure qui renvoie en sortie le nombre de matchs déjà finis / en
cours / à venir.

DELIMITER //
CREATE PROCEDURE renvoie_nombre(OUT NB_MATCH_FINI INT, NB_MATCH_COURS INT,NB_MATCH_VENIR INT)
BEGIN
 SET NB_MATCH_FINI := (SELECT count(mtc_id) from t_match_mtc 
where mtc_date_fin<CURRENT_DATE);
 SET NB_MATCH_COURS :=(SELECT count(mtc_id) from t_match_mtc 
where mtc_date_debut>CURRENT_DATE);
 SET NB_MATCH_VENIR :=(SELECT count(mtc_id) from t_match_mtc 
where mtc_date_debut<CURRENT_DATE AND mtc_date_fin>CURRENT_DATE);
END;
//
DELIMITER ;


2.• Testez cette procédure.

CALL `renvoie_nombre`(@p0, @p1, @p2); SELECT @p0 AS `NB_MATCH_FINI`, @p1 AS `NB_MATCH_COURS`, @p2 AS `NB_MATCH_VENIR`;

