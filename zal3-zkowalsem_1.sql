-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Czas generowania: 08 Lis 2022, 17:58
-- Wersja serwera: 10.5.12-MariaDB-0+deb11u1
-- Wersja PHP: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `zal3-zkowalsem_1`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`zkowalsem`@`%` PROCEDURE `insere_actu` (IN `ID_MATCH` INT)   BEGIN
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
     insert into t_actu_act(act_int,act_date,act_txt,cpt_id)
     VALUES(CONCAT('Le quiz d\'id : ',@id),CURRENT_DATE,CONCAT(@intitule,' a ouvert le ', @datedebut,' et a fermé le ',@datefin,' Les joueurs qui ont participé sont: ',@liste),@auteur);
 ELSE 
    SET @auteur := 2;
    insert into t_actu_act(act_int,act_date,act_txt,cpt_id)
    VALUES(CONCAT('Le quiz d\'id : ',@id),CURRENT_DATE,CONCAT(@intitule,' a ouvert le ', @datedebut,' et n a pas encore fermé'),@auteur);
 END IF;
 

END$$

CREATE DEFINER=`zkowalsem`@`%` PROCEDURE `modif_etat_question` (IN `ID_QST` INT)   BEGIN
 set @etat :=(SELECT qst_etat from t_question_qst where qst_id=ID_QST);
 IF(@etat='A') THEN 
 UPDATE t_question_qst set qst_etat='D' where qst_id=ID_QST;
 ELSE
 UPDATE t_question_qst set qst_etat='A' where qst_id=ID_QST;
 END IF;
END$$

CREATE DEFINER=`zkowalsem`@`%` PROCEDURE `modif_etat_quiz` (IN `ID_QUI` INT)   BEGIN
 set @etat :=(SELECT qui_etat from t_quiz_qui where qui_id=ID_QUI);
 IF(@etat='O') THEN 
 UPDATE t_quiz_qui set qui_etat='F' where qui_id=ID_QUI;
 ELSE
 UPDATE t_quiz_qui set qui_etat='O' where qui_id=ID_QUI;
 END IF;
END$$

CREATE DEFINER=`zkowalsem`@`%` PROCEDURE `moy_fin_match` (IN `ID_MTC` INT)   BEGIN
    update t_match_mtc set mtc_scoreactif=(select avg(jou_score) from t_joueur_jou where mtc_id=ID_MTC) where mtc_id=ID_MTC;

END$$

CREATE DEFINER=`zkowalsem`@`%` PROCEDURE `renvoie_nombre` (OUT `NB_MATCH_FINI` INT, OUT `NB_MATCH_COURS` INT, OUT `NB_MATCH_VENIR` INT)   BEGIN
 SET NB_MATCH_FINI := (SELECT count(mtc_id) from t_match_mtc 
where mtc_date_fin IS NOT NULL);
 SET NB_MATCH_VENIR :=(SELECT count(mtc_id) from t_match_mtc 
where mtc_date_debut>CURRENT_TIMESTAMP AND mtc_date_fin IS NULL);
 SET NB_MATCH_COURS :=(SELECT count(mtc_id) from t_match_mtc 
where mtc_date_debut<CURRENT_TIMESTAMP AND mtc_date_fin IS NULL);
END$$

--
-- Funkcje
--
CREATE DEFINER=`zkowalsem`@`%` FUNCTION `liste_joueur` (`match_id` CHAR(8)) RETURNS TEXT CHARSET utf8mb4  BEGIN
 SET @liste := (SELECT GROUP_CONCAT(jou_pseudo) FROM t_joueur_jou
 join t_match_mtc using(mtc_id)
 where mtc_codematch=match_id);
 RETURN @liste;
END$$

CREATE DEFINER=`zkowalsem`@`%` FUNCTION `liste_match_1_year_old` () RETURNS TEXT CHARSET utf8mb4  BEGIN
 SET @liste := (SELECT GROUP_CONCAT(mtc_id) FROM t_match_mtc
 WHERE NOW() - INTERVAL 1 YEAR > mtc_date_fin);
 RETURN @liste;
END$$

CREATE DEFINER=`zkowalsem`@`%` FUNCTION `liste_match_1_year_old_specific_id` (`ID` INT) RETURNS TEXT CHARSET utf8mb4  BEGIN
 SET @liste := (SELECT GROUP_CONCAT(mtc_id) FROM t_match_mtc
 WHERE NOW() - INTERVAL 1 YEAR > mtc_date_fin AND cpt_id=ID);
 RETURN @liste;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `LISTE_JOUEUR`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `LISTE_JOUEUR` (
`jou_id` int(11)
,`jou_pseudo` varchar(20)
,`jou_score` double
,`jou_heurevalidation` datetime
,`mtc_id` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `LISTE_JOUEUR_SCORE_INF_50`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `LISTE_JOUEUR_SCORE_INF_50` (
`jou_id` int(11)
,`jou_pseudo` varchar(20)
,`jou_score` double
,`jou_heurevalidation` datetime
,`mtc_id` int(11)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `t_actu_act`
--

CREATE TABLE `t_actu_act` (
  `act_id` int(11) NOT NULL,
  `act_int` varchar(100) NOT NULL,
  `act_date` date NOT NULL,
  `act_txt` varchar(500) NOT NULL,
  `act_etat` char(1) NOT NULL,
  `cpt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `t_actu_act`
--

INSERT INTO `t_actu_act` (`act_id`, `act_int`, `act_date`, `act_txt`, `act_etat`, `cpt_id`) VALUES
(1, 'Entrainement pour futur test', '2022-11-08', 'Un entrainement sur les moteurs 2 temps de chez ktm aura lieu le 20.11.2022', 'O', 3),
(2, 'Test le 20.11.2022', '2022-11-08', 'Un test sur les moteurs 2 temps de chez ktm aura lieu le 20.11.2022', 'O', 3),
(3, 'Le quiz d\'id : 1', '2022-11-07', 'Entrainement 2 temps a ouvert le 2022-10-25 12:10:00 et n a pas encore fermé', 'O', 2),
(4, 'Le quiz d\'id : 2', '2022-11-08', 'Entrainement 4 temps a ouvert le 2022-10-23 17:40:00 et a fermé le 2022-11-08 08:08:19 Les joueurs qui ont participé sont: Marianne,Léo,Gabriel,Alice', 'O', 1),
(5, 'Modification du quiz 2', '2022-11-07', ' QUIZ VIDE ! Liste des matchs concernées: 8edc2dd9,0af0391f,e4fc6e4e, Liste des formateurs concernées: patocka', 'O', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `t_compte_cpt`
--

CREATE TABLE `t_compte_cpt` (
  `cpt_id` int(11) NOT NULL,
  `cpt_pseudo` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `cpt_mdp` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `t_compte_cpt`
--

INSERT INTO `t_compte_cpt` (`cpt_id`, `cpt_pseudo`, `cpt_mdp`) VALUES
(1, 'responsable', 'resp22_ZUIQ'),
(2, 'aniol', 'admin22!__opxe'),
(3, 'kocik', 'Siema38$jazem'),
(4, 'patocka', '17081998amgprep'),
(5, 'jpierre', '15081997alpinaprep'),
(6, 'ekowalsk', 'siemamordeczkicotam18902');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `t_joueur_jou`
--

CREATE TABLE `t_joueur_jou` (
  `jou_id` int(11) NOT NULL,
  `jou_pseudo` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `jou_score` double NOT NULL,
  `jou_heurevalidation` datetime DEFAULT NULL,
  `mtc_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `t_joueur_jou`
--

INSERT INTO `t_joueur_jou` (`jou_id`, `jou_pseudo`, `jou_score`, `jou_heurevalidation`, `mtc_id`) VALUES
(1, 'Corentin', 64, '2022-11-08 08:08:19', 1),
(2, 'Jonathan', 43, '2022-11-08 08:08:19', 1),
(3, 'Vincent', 77, '2022-11-08 08:08:19', 1),
(4, 'Lucie', 37, '2022-11-08 08:08:19', 1),
(5, 'Chloé', 60, '2022-11-08 08:08:19', 1),
(6, 'Marianne', 0, NULL, 2),
(7, 'Léo', 0, NULL, 2),
(8, 'Gabriel', 0, NULL, 2),
(9, 'Alice', 0, NULL, 2),
(10, 'Rosa', 0, NULL, 3),
(11, 'Francesca', 0, NULL, 3),
(12, 'Mauro', 0, NULL, 3),
(13, 'Benny', 0, NULL, 3),
(14, 'Simon', 0, NULL, 3),
(15, 'Mateo', 0, NULL, 4),
(16, 'Virgile', 0, NULL, 4),
(17, 'Leticia', 0, NULL, 4),
(18, 'Pierre', 0, NULL, 4),
(19, 'Louisette', 0, NULL, 4),
(20, 'Angel', 0, NULL, 5),
(21, 'Ronny', 0, NULL, 5),
(22, 'Markus', 0, NULL, 5),
(23, 'Katarina', 0, NULL, 5),
(24, 'Matti', 0, NULL, 5),
(25, 'Emilien', 0, NULL, 6),
(26, 'Aaron', 0, NULL, 6),
(27, 'Javier', 0, NULL, 6),
(28, 'Gweltaz', 0, NULL, 6),
(29, 'Lorna', 0, NULL, 6);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `t_match_mtc`
--

CREATE TABLE `t_match_mtc` (
  `mtc_id` int(11) NOT NULL,
  `mtc_int` varchar(100) NOT NULL,
  `mtc_scoreactif` double NOT NULL,
  `mtc_date_debut` datetime NOT NULL,
  `mtc_date_fin` datetime DEFAULT NULL,
  `mtc_etat_match` char(1) NOT NULL,
  `mtc_etat_corrige` char(1) NOT NULL,
  `mtc_codematch` char(8) NOT NULL,
  `qui_id` int(11) NOT NULL,
  `cpt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `t_match_mtc`
--

INSERT INTO `t_match_mtc` (`mtc_id`, `mtc_int`, `mtc_scoreactif`, `mtc_date_debut`, `mtc_date_fin`, `mtc_etat_match`, `mtc_etat_corrige`, `mtc_codematch`, `qui_id`, `cpt_id`) VALUES
(1, 'Entrainement 2 temps', 56.2, '2022-10-23 12:10:00', '2022-11-08 08:08:19', 'O', 'O', 'a62e18dd', 1, 3),
(2, 'Entrainement 4 temps', 0, '2022-10-23 17:40:00', NULL, 'O', 'O', '66f46308', 2, 4),
(3, 'Entrainement 2 temps', 0, '2022-10-23 19:30:17', NULL, 'O', 'O', '85463fb5', 1, 3),
(4, 'Entrainement 4 temps', 0, '2022-10-24 16:10:00', NULL, 'O', 'O', '4899dbc2', 2, 4),
(5, 'Entrainement 2 temps', 0, '2022-10-27 17:15:00', NULL, 'O', 'O', '8ed8591a', 1, 3),
(6, 'Entrainement 4 temps', 0, '2022-11-08 00:00:00', NULL, 'O', 'O', '132d6d4d', 2, 4);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `t_profil_pfl`
--

CREATE TABLE `t_profil_pfl` (
  `cpt_id` int(11) NOT NULL,
  `pfl_role` char(1) NOT NULL,
  `pfl_nom` varchar(60) NOT NULL,
  `pfl_prenom` varchar(60) NOT NULL,
  `pfl_mail` varchar(100) NOT NULL,
  `pfl_actif` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `t_profil_pfl`
--

INSERT INTO `t_profil_pfl` (`cpt_id`, `pfl_role`, `pfl_nom`, `pfl_prenom`, `pfl_mail`, `pfl_actif`) VALUES
(1, 'A', 'Kacper', 'LaValle', 'kacper.lavalle@gmail.com', 'A'),
(2, 'A', 'Leszcz', 'Aniol', 'leszczu.aniol@gmail.com', 'A'),
(3, 'F', 'Kocik', 'Tadek', 'tadekkocik@gmail.com', 'A'),
(4, 'F', 'Patocka', 'Wiktoria', 'wiktoriapato@gmail.com', 'A'),
(5, 'F', 'Jean', 'Pierre', 'jeanpierre@gmail.com', 'A'),
(6, 'A', 'Kowalski', 'Emanuel', 'kowalski.emanuel@gmail.com', 'A');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `t_question_qst`
--

CREATE TABLE `t_question_qst` (
  `qst_id` int(11) NOT NULL,
  `qst_etat` char(1) NOT NULL,
  `qst_ordre` int(11) NOT NULL,
  `qst_texte` varchar(500) NOT NULL,
  `qui_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `t_question_qst`
--

INSERT INTO `t_question_qst` (`qst_id`, `qst_etat`, `qst_ordre`, `qst_texte`, `qui_id`) VALUES
(1, 'A', 1, 'Quelles est le cycle de fonctionnement d\'un moteur 2 temps', 1),
(2, 'A', 2, 'Quelles sont les pièces principales d\'un moteur 2 temps', 1),
(3, 'A', 3, 'Que ce situe à la sortie d\'échappement sur les moteurs 2 temps plus avancés', 1),
(4, 'A', 4, 'Combien de tour de vilebrequin faut il pour accomplir un cycle complet sur les moteurs 2 temps', 1),
(5, 'A', 1, 'Quelles est le cycle de fonctionnement d\'un moteur 4 temps', 2),
(6, 'A', 2, 'Quelles sont les pièces principales d\'un moteur 4 temps', 2),
(7, 'A', 3, 'Que ce situe à la sortie d\'échappement sur les moteurs 4 temps plus avancés', 2),
(8, 'A', 4, 'Combien de tour de vilebrequin faut il pour accomplir un cycle complet sur les moteurs 4 temps', 2),
(9, 'A', 1, 'Quelles est la deuxieme appellation du moteur rotatif ?', 3),
(10, 'A', 2, 'Quels est le nom du piston dans un moteur rotatif ?', 3),
(11, 'A', 3, 'Combien y\'a t-il de chambre dans le cylindre d\'un moteur rotatif ?', 3),
(12, 'A', 4, 'Quels est le plus gros problème du moteur rotatif ?', 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `t_quiz_qui`
--

CREATE TABLE `t_quiz_qui` (
  `qui_id` int(11) NOT NULL,
  `qui_intitule` varchar(100) NOT NULL,
  `qui_image` varchar(200) NOT NULL,
  `qui_etat` char(1) NOT NULL,
  `cpt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `t_quiz_qui`
--

INSERT INTO `t_quiz_qui` (`qui_id`, `qui_intitule`, `qui_image`, `qui_etat`, `cpt_id`) VALUES
(1, 'Les moteurs 2 temps', '2stroke.png', 'O', 3),
(2, 'Les moteurs 4 temps', '4stroke.png', 'O', 4),
(3, 'Les moteurs rotatifs', 'rotat.png', 'O', 6);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `t_reponse_rep`
--

CREATE TABLE `t_reponse_rep` (
  `rep_id` int(11) NOT NULL,
  `rep_libelle` varchar(500) NOT NULL,
  `rep_ordre` int(11) NOT NULL,
  `rep_correct` char(1) NOT NULL,
  `qst_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `t_reponse_rep`
--

INSERT INTO `t_reponse_rep` (`rep_id`, `rep_libelle`, `rep_ordre`, `rep_correct`, `qst_id`) VALUES
(1, 'Admission et échappement puis compression puis detente', 1, '1', 1),
(2, 'Compression puis admission et échappement puis detente', 2, '0', 1),
(3, 'Compression puis detente puis admission et échappement ', 3, '0', 1),
(4, 'Detente puis compression puis admission et échappement ', 4, '0', 1),
(5, 'Bougie, cylindre,piston,soupape d\'échappements et vilebrequin', 1, '0', 2),
(6, 'Bougie, cylindre,piston,valve à clapets et vilebrequin', 2, '1', 2),
(7, 'Bougie, cylindre,piston,arbre à cames et vilebrequin', 3, '0', 2),
(8, 'Les valves', 1, '1', 3),
(9, 'Les soupapes', 2, '0', 3),
(10, 'La boite à clapets', 3, '0', 3),
(11, '1', 1, '1', 4),
(12, '2', 2, '0', 4),
(13, '3', 3, '0', 4),
(14, 'Wankil', 1, '0', 9),
(15, 'Wankel', 2, '1', 9),
(16, 'Wankeli ', 3, '0', 9),
(17, 'Pistor', 1, '0', 10),
(18, 'Stator', 2, '0', 10),
(19, 'Rotor', 3, '1', 10),
(20, '1', 1, '0', 11),
(21, '2', 2, '0', 11),
(22, '3', 3, '1', 11),
(23, 'Le cout de production', 1, '0', 12),
(24, 'La fiabilité et la consommation', 2, '1', 12),
(25, 'Le bruit très désagréable', 3, '0', 12);

-- --------------------------------------------------------

--
-- Struktura widoku `LISTE_JOUEUR`
--
DROP TABLE IF EXISTS `LISTE_JOUEUR`;

CREATE ALGORITHM=UNDEFINED DEFINER=`zkowalsem`@`%` SQL SECURITY DEFINER VIEW `LISTE_JOUEUR`  AS SELECT `t_joueur_jou`.`jou_id` AS `jou_id`, `t_joueur_jou`.`jou_pseudo` AS `jou_pseudo`, `t_joueur_jou`.`jou_score` AS `jou_score`, `t_joueur_jou`.`jou_heurevalidation` AS `jou_heurevalidation`, `t_joueur_jou`.`mtc_id` AS `mtc_id` FROM `t_joueur_jou``t_joueur_jou`  ;

-- --------------------------------------------------------

--
-- Struktura widoku `LISTE_JOUEUR_SCORE_INF_50`
--
DROP TABLE IF EXISTS `LISTE_JOUEUR_SCORE_INF_50`;

CREATE ALGORITHM=UNDEFINED DEFINER=`zkowalsem`@`%` SQL SECURITY DEFINER VIEW `LISTE_JOUEUR_SCORE_INF_50`  AS SELECT `t_joueur_jou`.`jou_id` AS `jou_id`, `t_joueur_jou`.`jou_pseudo` AS `jou_pseudo`, `t_joueur_jou`.`jou_score` AS `jou_score`, `t_joueur_jou`.`jou_heurevalidation` AS `jou_heurevalidation`, `t_joueur_jou`.`mtc_id` AS `mtc_id` FROM `t_joueur_jou` WHERE `t_joueur_jou`.`jou_score` < 50 AND `t_joueur_jou`.`jou_heurevalidation` is not nullnot null  ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `t_actu_act`
--
ALTER TABLE `t_actu_act`
  ADD PRIMARY KEY (`act_id`),
  ADD KEY `fk_act_actu_cpt_compte1_idx` (`cpt_id`);

--
-- Indeksy dla tabeli `t_compte_cpt`
--
ALTER TABLE `t_compte_cpt`
  ADD PRIMARY KEY (`cpt_id`);

--
-- Indeksy dla tabeli `t_joueur_jou`
--
ALTER TABLE `t_joueur_jou`
  ADD PRIMARY KEY (`jou_id`),
  ADD KEY `fk_t_joueur_jou_t_match_mtc1_idx` (`mtc_id`);

--
-- Indeksy dla tabeli `t_match_mtc`
--
ALTER TABLE `t_match_mtc`
  ADD PRIMARY KEY (`mtc_id`),
  ADD UNIQUE KEY `mtc_codematch_UNIQUE` (`mtc_codematch`),
  ADD KEY `fk_t_match_mtc_t_quiz_qui1_idx` (`qui_id`),
  ADD KEY `fk_t_match_mtc_t_compte_cpt1_idx` (`cpt_id`);

--
-- Indeksy dla tabeli `t_profil_pfl`
--
ALTER TABLE `t_profil_pfl`
  ADD PRIMARY KEY (`cpt_id`);

--
-- Indeksy dla tabeli `t_question_qst`
--
ALTER TABLE `t_question_qst`
  ADD PRIMARY KEY (`qst_id`),
  ADD KEY `fk_qst_question_qui_quiz1_idx` (`qui_id`);

--
-- Indeksy dla tabeli `t_quiz_qui`
--
ALTER TABLE `t_quiz_qui`
  ADD PRIMARY KEY (`qui_id`),
  ADD KEY `fk_t_quiz_qui_t_compte_cpt1_idx` (`cpt_id`);

--
-- Indeksy dla tabeli `t_reponse_rep`
--
ALTER TABLE `t_reponse_rep`
  ADD PRIMARY KEY (`rep_id`),
  ADD KEY `fk_rep_reponse_qst_question1_idx` (`qst_id`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `t_actu_act`
--
ALTER TABLE `t_actu_act`
  MODIFY `act_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `t_compte_cpt`
--
ALTER TABLE `t_compte_cpt`
  MODIFY `cpt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `t_joueur_jou`
--
ALTER TABLE `t_joueur_jou`
  MODIFY `jou_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT dla tabeli `t_match_mtc`
--
ALTER TABLE `t_match_mtc`
  MODIFY `mtc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `t_profil_pfl`
--
ALTER TABLE `t_profil_pfl`
  MODIFY `cpt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `t_question_qst`
--
ALTER TABLE `t_question_qst`
  MODIFY `qst_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT dla tabeli `t_quiz_qui`
--
ALTER TABLE `t_quiz_qui`
  MODIFY `qui_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `t_reponse_rep`
--
ALTER TABLE `t_reponse_rep`
  MODIFY `rep_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `t_actu_act`
--
ALTER TABLE `t_actu_act`
  ADD CONSTRAINT `fk_act_actu_cpt_compte1` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `t_joueur_jou`
--
ALTER TABLE `t_joueur_jou`
  ADD CONSTRAINT `fk_t_joueur_jou_t_match_mtc1` FOREIGN KEY (`mtc_id`) REFERENCES `t_match_mtc` (`mtc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `t_match_mtc`
--
ALTER TABLE `t_match_mtc`
  ADD CONSTRAINT `fk_t_match_mtc_t_compte_cpt1` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_match_mtc_t_quiz_qui1` FOREIGN KEY (`qui_id`) REFERENCES `t_quiz_qui` (`qui_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `t_profil_pfl`
--
ALTER TABLE `t_profil_pfl`
  ADD CONSTRAINT `fk_t_profil_pfl_t_compte_cpt1` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `t_question_qst`
--
ALTER TABLE `t_question_qst`
  ADD CONSTRAINT `fk_qst_question_qui_quiz1` FOREIGN KEY (`qui_id`) REFERENCES `t_quiz_qui` (`qui_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `t_quiz_qui`
--
ALTER TABLE `t_quiz_qui`
  ADD CONSTRAINT `fk_t_quiz_qui_t_compte_cpt1` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `t_reponse_rep`
--
ALTER TABLE `t_reponse_rep`
  ADD CONSTRAINT `fk_rep_reponse_qst_question1` FOREIGN KEY (`qst_id`) REFERENCES `t_question_qst` (`qst_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
