___________
ACTIVITE 4:
___________



_________
Les Vues:
_________



1.Vue de la liste de tous les joueurs.

CREATE VIEW LISTE_JOUEUR
 AS SELECT *
 FROM t_joueur_jou;

select * from LISTE_JOUEUR;


2. Vue de la liste des joueurs ayant terminé un match avec un score inférieur aà 50%


CREATE VIEW LISTE_JOUEUR_SCORE_INF_50
 AS SELECT *
 FROM t_joueur_jou
 where jou_score<50 AND jou_heurevalidation IS NOT NULL;


select * from LISTE_JOUEUR_SCORE_INF_50;


______________
Les Fonctions:
______________


1.Fonction selectionnant les ids des matchs qui se sont terminés il y a plus d un an.

DELIMITER //
CREATE FUNCTION liste_match_1_year_old() RETURNS TEXT
BEGIN
 SET @liste := (SELECT GROUP_CONCAT(mtc_id) FROM t_match_mtc
 WHERE NOW() - INTERVAL 1 YEAR > mtc_date_fin);
 RETURN @liste;
END;
//
DELIMITER ;



select liste_match_1_year_old();

2.Fonction selectionnant les ids des matchs qui se sont terminés il y a plus d un an d un id spécifique.

DELIMITER //
CREATE FUNCTION liste_match_1_year_old_specific_id(ID INT) RETURNS TEXT
BEGIN
 SET @liste := (SELECT GROUP_CONCAT(mtc_id) FROM t_match_mtc
 WHERE NOW() - INTERVAL 1 YEAR > mtc_date_fin AND cpt_id=ID);
 RETURN @liste;
END;
//
DELIMITER ;

select liste_match_1_year_old_specific_id(3);



_______________
Les procédures:
_______________



1.Procédure qui modifie l etat d une question d id specifique.

DELIMITER //
CREATE PROCEDURE modif_etat_question(IN ID_QST INT)
BEGIN
 set @etat :=(SELECT qst_etat from t_question_qst where qst_id=ID_QST);
 IF(@etat='A') THEN 
 UPDATE t_question_qst set qst_etat='D' where qst_id=ID_QST;
 ELSE
 UPDATE t_question_qst set qst_etat='A' where qst_id=ID_QST;
 END IF;
END;
//
DELIMITER ;

call modif_etat_question(5);


2.Procédure qui modifie l etat d un quiz d id specifique.

DELIMITER //
CREATE PROCEDURE modif_etat_quiz(IN ID_QUI INT)
BEGIN
 set @etat :=(SELECT qui_etat from t_quiz_qui where qui_id=ID_QUI);
 IF(@etat='O') THEN 
 UPDATE t_quiz_qui set qui_etat='F' where qui_id=ID_QUI;
 ELSE
 UPDATE t_quiz_qui set qui_etat='O' where qui_id=ID_QUI;
 END IF;
END;
//
DELIMITER ;



call modif_etat_quiz(1);



3.Procédure qui effectue la moyenne des scores d un match et update la colonne correspondante

DELIMITER //
CREATE PROCEDURE moy_fin_match(IN ID_MTC INT)
BEGIN
    update t_match_mtc set mtc_scoreactif=(select avg(jou_score) from t_joueur_jou where mtc_id=ID_MTC) where mtc_id=ID_MTC;

END;
//
DELIMITER ;


call moy_fin_match(1);


_____________
Les triggers:
_____________


1.Trigger qui quand un match est fini fait la moyenne des joueurs et la place dans la colonne mtc_scoreactif 

DELIMITER //
CREATE TRIGGER score_fin_match 
BEFORE UPDATE ON t_match_mtc
FOR EACH ROW 
BEGIN 
    IF new.mtc_date_fin IS NOT NULL AND old.mtc_date_fin IS NULL THEN
    set new.mtc_scoreactif=(select avg(jou_score) from t_joueur_jou where mtc_id=new.mtc_id);
    end if;
END;
//
DELIMITER ;


2.Trigger qui lorsqu un match se termine alors rempli heure de validation des joueurs.



DELIMITER //
CREATE TRIGGER fin_match_jou
AFTER UPDATE ON t_match_mtc
FOR EACH ROW 
BEGIN 
    IF new.mtc_date_fin IS NOT NULL AND old.mtc_date_fin IS NULL THEN
    update  t_joueur_jou set jou_heurevalidation=new.mtc_date_fin where mtc_id=new.mtc_id;
    END IF;
END;
//
DELIMITER ;







_______________
ACTIVITE 5:
_______________


________________
TRIGGER 1:
________________



DELIMITER //
CREATE TRIGGER supp_quiz
AFTER DELETE ON t_question_qst
FOR EACH ROW 
BEGIN 
    DELETE FROM t_actu_act WHERE act_int LIKE concat('%',"Le quiz d'id : ",old.qui_id,'%');
    set @cpt :=(select count(qui_id) from t_question_qst where qui_id=old.qui_id);
    IF @cpt >= 2 THEN
    set @txt :=(CONCAT(" Suppression d’une question ",@cpt," questions restantes, "));
    ELSEIF @cpt = 1 THEN
    set @txt :=(" ATTENTION, plus qu\'une question ! ");
    ELSE
    set @txt :=(" QUIZ VIDE ! ");
    END IF;
    set @listecode :=(select GROUP_CONCAT(mtc_codematch) from t_match_mtc where qui_id=old.qui_id);
    set @listeformateur :=(select GROUP_CONCAT(DISTINCT cpt_pseudo) from t_compte_cpt join t_match_mtc using(cpt_id) where qui_id=old.qui_id);
    IF @listecode IS NULL THEN
    insert into t_actu_act(act_int,act_date,act_txt,cpt_id)
    VALUES(CONCAT('Modification du quiz ',old.qui_id),CURRENT_DATE,CONCAT(@txt,'Aucun match associé à ce quiz pour l’instant ! '),1);
    ELSE
    insert into t_actu_act(act_int,act_date,act_txt,cpt_id)
    VALUES(CONCAT('Modification du quiz ',old.qui_id),CURRENT_DATE,CONCAT(@txt,' Liste des matchs concernées: ', @listecode,', Liste des formateurs concernées: ',@listeformateur),1);
    END IF;


END
//
DELIMITER ;



____________
TRIGGER 2:
____________


//MODIFICATION A FAIRE EN UN SEUL COUP.


DELIMITER //
CREATE TRIGGER modif_date_match
AFTER UPDATE ON t_match_mtc
FOR EACH ROW 
BEGIN 


IF old.mtc_date_debut <> new.mtc_date_debut AND new.mtc_date_fin IS NULL THEN
    DELETE FROM t_joueur_jou WHERE mtc_id=old.mtc_id;
END IF;

END
//
DELIMITER ;


