DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` PROCEDURE `insere_actu`(IN `ID_MATCH` INT)
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
 SET @id :=(SELECT qui_idquiz FROM t_match_mtc
                  where mtc_id=ID_MATCH);
  IF @datefin < CURRENT_DATE AND @datefin !='0000-00-00 00:00:00' THEN
 SET @auteur := 1;
 ELSE 
 SET @auteur := 2;
 
 END IF;
 
  insert into t_actu_act(act_int,act_date,act_txt,cpt_id)
VALUES(CONCAT('Le quiz d\'id : ',@id),CURRENT_DATE,CONCAT(@intitule,' a ouvert le ', @datedebut,' et a fermé le ',@datefin,' Les joueurs qui ont participé sont: ',@liste),@auteur);

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` PROCEDURE `renvoie_nombre`(OUT `NB_MATCH_FINI` INT, OUT `NB_MATCH_COURS` INT, OUT `NB_MATCH_VENIR` INT)
BEGIN
 SET NB_MATCH_FINI := (SELECT count(mtc_id) from t_match_mtc 
where mtc_date_fin<CURRENT_DATE);
 SET NB_MATCH_VENIR :=(SELECT count(mtc_id) from t_match_mtc 
where mtc_date_debut>CURRENT_DATE);
 SET NB_MATCH_COURS :=(SELECT count(mtc_id) from t_match_mtc 
where mtc_date_debut<CURRENT_DATE AND mtc_date_fin>CURRENT_DATE);
END$$
DELIMITER ;



///


DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` PROCEDURE `insere_actu`(IN `ID_MATCH` INT)
BEGIN
 SET @intitule := (SELECT mtc_int FROM t_match_mtc
                  where mtc_id=ID_MATCH);
 SET @datedebut := (SELECT mtc_date_debut FROM t_match_mtc
                  where mtc_id=ID_MATCH);
 SET @datefin := (SELECT mtc_date_fin FROM t_match_mtc
                  where mtc_id=ID_MATCH);
 SET @liste := (SELECT GROUP_CONCAT(jou_pseudo) FROM t_joueur_jou
 join t_match_mtc using(mtc_id)
 where mtc_id=ID_MATCH);
 SET @id :=(SELECT qui_id FROM t_match_mtc
                  where mtc_id=ID_MATCH);
  IF @datefin IS NOT NULL THEN
     SET @auteur := 1;
     insert into t_actu_act(act_int,act_date,act_txt,act_etat,cpt_id)
     VALUES(CONCAT('Le quiz d\'id : ',@id),CURRENT_DATE,CONCAT(@intitule,' a ouvert le ', @datedebut,' et a fermé le ',@datefin,' Les joueurs qui ont participé sont: ',@liste),'O',@auteur);
 ELSE 
    SET @auteur := 2;
    insert into t_actu_act(act_int,act_date,act_txt,act_etat,cpt_id)
    VALUES(CONCAT('Le quiz d\'id : ',@id),CURRENT_DATE,CONCAT(@intitule,' a ouvert le ', @datedebut,' et n a pas encore fermé'),'O',@auteur);
 END IF;
 

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` PROCEDURE `modif_etat_question`(IN ID_QST INT)
BEGIN
 set @etat :=(SELECT qst_etat from t_question_qst where qst_id=ID_QST);
 IF(@etat='A') THEN 
 UPDATE t_question_qst set qst_etat='D' where qst_id=ID_QST;
 ELSE
 UPDATE t_question_qst set qst_etat='A' where qst_id=ID_QST;
 END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` PROCEDURE `modif_etat_quiz`(IN ID_QUI INT)
BEGIN
 set @etat :=(SELECT qui_etat from t_quiz_qui where qui_id=ID_QUI);
 IF(@etat='O') THEN 
 UPDATE t_quiz_qui set qui_etat='F' where qui_id=ID_QUI;
 ELSE
 UPDATE t_quiz_qui set qui_etat='O' where qui_id=ID_QUI;
 END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` PROCEDURE `moy_fin_match`(IN ID_MTC INT)
BEGIN
    update t_match_mtc set mtc_scoreactif=(select avg(jou_score) from t_joueur_jou where mtc_id=ID_MTC) where mtc_id=ID_MTC;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` PROCEDURE `renvoie_nombre`(OUT NB_MATCH_FINI INT,OUT NB_MATCH_COURS INT,OUT NB_MATCH_VENIR INT)
BEGIN
 SET NB_MATCH_FINI := (SELECT count(mtc_id) from t_match_mtc 
where mtc_date_fin IS NOT NULL);
 SET NB_MATCH_VENIR :=(SELECT count(mtc_id) from t_match_mtc 
where mtc_date_debut>CURRENT_TIMESTAMP AND mtc_date_fin IS NULL);
 SET NB_MATCH_COURS :=(SELECT count(mtc_id) from t_match_mtc 
where mtc_date_debut<CURRENT_TIMESTAMP AND mtc_date_fin IS NULL);
END$$
DELIMITER ;
