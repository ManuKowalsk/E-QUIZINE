_________
 Matchs :
_________


5. Requête(s) d’affichage, si autorisé, de toutes les questions d’un match et leur
bonne réponse

select  qst_texte,rep_libelle from t_match_mtc join t_question_qst USING(qui_id) join t_reponse_rep using(qst_id) where mtc_id=1 AND mtc_etat_corrige='O' AND rep_correct=1;

6. Requête de vérification d’une réponse donnée par un joueur (bonne ou
mauvaise ?)

select IF(rep_id=rep_correct,"Bonne réponse","Mauvaise réponse") as VerifQuestion
FROM t_reponse_rep
where rep_id=2;


OU 

select  rep_correct
FROM t_reponse_rep
where rep_id=1;


7. Requête de mise à jour du score d’un joueur particulier (pseudo connu)

update t_joueur_jou set jou_score=50 where jou_pseudo='Corentin';

8. Requête de récupération du score d’un joueur particulier (pseudo connu)

select jou_score from t_joueur_jou where jou_pseudo='Corentin';






_______
 Quiz :
_______


3. Requête listant tous les quiz

select * from t_quiz_qui;

4. Requête listant tous les quiz (intitulé et auteur) et les matchs associés (intitulé
et auteur)

DELIMITER //
CREATE FUNCTION id_en_pseudo(ID INT) RETURNS TEXT
BEGIN
 set @pseudo=(select cpt_pseudo from t_compte_cpt where cpt_id=ID);
 RETURN @pseudo;
END;
//
DELIMITER ;


select qui_intitule,cpt_pseudo as auteur_quiz,mtc_int,id_en_pseudo(t_match_mtc.cpt_id) as auteur_match from t_quiz_qui 
left join t_match_mtc on t_quiz_qui.qui_id=t_match_mtc.qui_id
left join t_compte_cpt on t_quiz_qui.cpt_id=t_compte_cpt.cpt_id;

5. Requête listant tous les quiz d’un formateur en particulier (dont on connaî’ID)

select * from t_quiz_qui where cpt_id=3;

6. Requête donnant tous les quiz qui ne sont plus associés à un formateur

select * from t_quiz_qui where cpt_id is null;

7. Requête listant, pour un formateur dont on connaît le login, tous les quiz et
leurs matchs, s’il y en a

select cpt_pseudo,t_quiz_qui.qui_id,GROUP_CONCAT(mtc_codematch) as match_associes
from t_compte_cpt
left join t_quiz_qui using(cpt_id)
left join t_match_mtc using(cpt_id,qui_id)
where cpt_pseudo='kocik'
group by t_quiz_qui.qui_id;

OU 

select cpt_pseudo,t_quiz_qui.qui_id,mtc_codematch from t_compte_cpt
left join t_quiz_qui using(cpt_id) 
left join t_match_mtc using(cpt_id,qui_id) 
where cpt_pseudo='kocik' 
group by mtc_codematch,t_quiz_qui.qui_id;

_________
 Matchs :
_________


7. Requête d’ajout d’un match pour un quiz particulier (connaissant son ID)

INSERT INTO t_match_mtc
        VALUES(NULL,"Test sur le quiz 2",0,CURRENT_DATE,NULL,'O','O',SUBSTRING(MD5(RAND()) FROM 1+rand()*4 FOR 8),2,1);


8. Requête de modification d’un match

    update t_match_mtc set mtc_int='Nouveau int',mtc_scoreactif=0 where mtc_id=2;

9. Requête de suppression d’un match dont on connaît l’ID (/le code)

delete from t_match_mtc where mtc_id=2;


delete from t_match_mtc where mtc_codematch='85463fb5';

10. Requête d’activation (/désactivation) d’un match

UPDATE t_match_mtc
SET mtc_etat_match=IF(mtc_etat_match='O','F','O')
where mtc_id=4;

11. Requête(s) de « remise à zéro » (RAZ) d’un match

UPDATE t_match_mtc
SET mtc_scoreactif=0,mtc_date_debut=NOW(),mtc_date_fin=NULL
where mtc_id=4;








