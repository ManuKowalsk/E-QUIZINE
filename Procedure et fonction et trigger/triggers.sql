DELIMITER $$
CREATE TRIGGER `delete_joueur` BEFORE DELETE ON `t_match_mtc` FOR EACH ROW delete t_joueur_jou from t_joueur_jou join t_match_mtc using(mtc_id) where mtc_id=old.mtc_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_joueur_after_raz` AFTER UPDATE ON `t_match_mtc` FOR EACH ROW IF(new.mtc_date_fin IS NULL AND new.mtc_scoreactif=0 AND new.mtc_date_debut!=old.mtc_date_debut)
THEN 
DELETE FROM t_joueur_jou where mtc_id=new.mtc_id;
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `score_fin_match` BEFORE UPDATE ON `t_match_mtc` FOR EACH ROW BEGIN 
    IF new.mtc_date_fin IS NOT NULL AND old.mtc_date_fin IS NULL THEN
    set new.mtc_scoreactif=(select avg(jou_score) from t_joueur_jou where mtc_id=new.mtc_id);
    end if;
END
$$
DELIMITER ;