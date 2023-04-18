DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` FUNCTION `liste_joueur`(match_id CHAR(8)) RETURNS text CHARSET utf8mb4
BEGIN
 SET @liste := (SELECT GROUP_CONCAT(jou_pseudojoueur) FROM t_joueur_jou
 join t_match_mtc using(mtc_id)
 where mtc_codematch=match_id);
 RETURN @liste;
END$$
DELIMITER ;



DELIMITER //
CREATE FUNCTION id_en_pseudo(ID CHAR(8)) RETURNS INT
BEGIN
 set @pseudo=(select cpt_pseudo from t_compte_cpt where cpt_id=ID);
 RETURN @pseudo;
END;
//
DELIMITER ;


DELIMITER //
CREATE FUNCTION codematch_en_id(mtc INT) RETURNS TEXT
BEGIN
 set @id=(select mtc_id from t_match_mtc where mtc_codematch=mtc);
 RETURN @id;
END;
//
DELIMITER ;

select codematch_en_id('1263afad');








DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` FUNCTION `codematch_en_id`(`mtc` VARCHAR(8)) RETURNS int(11)
BEGIN
 set @id=(select mtc_id from t_match_mtc where mtc_codematch=mtc);
 RETURN @id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` FUNCTION `id_en_pseudo`(ID INT) RETURNS text CHARSET utf8mb4
BEGIN
 set @pseudo=(select cpt_pseudo from t_compte_cpt where cpt_id=ID);
 RETURN @pseudo;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` FUNCTION `liste_joueur`(`match_id` CHAR(8)) RETURNS text CHARSET utf8mb4
BEGIN
 SET @liste := (SELECT GROUP_CONCAT(jou_pseudo) FROM t_joueur_jou
 join t_match_mtc using(mtc_id)
 where mtc_codematch=match_id);
 RETURN @liste;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` FUNCTION `liste_match_1_year_old`() RETURNS text CHARSET utf8mb4
BEGIN
 SET @liste := (SELECT GROUP_CONCAT(mtc_id) FROM t_match_mtc
 WHERE NOW() - INTERVAL 1 YEAR > mtc_date_fin);
 RETURN @liste;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`zkowalsem`@`%` FUNCTION `liste_match_1_year_old_specific_id`(ID INT) RETURNS text CHARSET utf8mb4
BEGIN
 SET @liste := (SELECT GROUP_CONCAT(mtc_id) FROM t_match_mtc
 WHERE NOW() - INTERVAL 1 YEAR > mtc_date_fin AND cpt_id=ID);
 RETURN @liste;
END$$
DELIMITER ;
