 ____________
 Actualités :
 ____________



1. Requête listant toutes les actualités de la table des actualités et leur auteur
(login)

select act_int,act_date,act_txt,cpt_pseudo from t_actu_act join t_compte_cpt using(cpt_id);

2. Requête donnant les données d une actualité dont on connaît l identifiant (n°)

select act_id,act_int,act_date,act_txt from t_actu_act where cpt_id=3;

3. Requête listant les 5 dernières actualités dans lordre décroissant

select * from t_actu_act order by act_date DESC LIMIT 5;


4. Requête recherchant et donnant la (ou les) actualité(s) contenant un mot
particulier

select * from t_actu_act where act_txt LIKE '%moteurs%' OR act_int LIKE '%moteurs%';



5. Requête listant toutes les actualités postées à une date particulière + le login
de l’auteur


select act_int,act_date,act_txt,cpt_pseudo from t_actu_act join t_compte_cpt using(cpt_id) where act_date='2022-10-17';




_________
 Matchs :
_________




1. Requête vérifiant l’existence (ou non) du code d’un match

select * from t_match_mtc where mtc_codematch='02a769e4';


2. Requête d’ajout du pseudo d’un joueur pour un match particulier dont l’ID est
connu

INSERT INTO t_joueur_jou
		VALUES(NULL,"pseudo_joueur",0,NULL,1);

3. Requête vérifiant l’existence (ou non) d’un pseudo pour un match particulier

select mtc_id,jou_pseudo from t_match_mtc join t_joueur_jou using(mtc_id) where mtc_id=1 AND jou_pseudo='Corentin';

4. Requête(s) d’affichage de toutes les questions (+ réponses) associées à un
match

select qst_texte,rep_libelle from t_match_mtc join t_question_qst using(qui_id) join t_reponse_rep using(qst_id) where mtc_id=1;




_____________
 Actualités :
_____________




1. Requête listant toutes les actualités postées par un auteur particulier
(connaissant le login du formateur connecté)


select act_int,act_date,act_txt,cpt_pseudo from t_actu_act join t_compte_cpt using(cpt_id) where cpt_pseudo='kocik';





_________________________________________
 Profils (formateurs / administrateurs) :
_________________________________________





1. Requête listant toutes les données de tous les profils

select * from t_profil_pfl;

OU POUR AVOIR AUSSI LE PSEUDO:

select cpt_id,cpt_pseudo,pfl_role,pfl_nom,pfl_prenom,pfl_mail,pfl_actif from t_profil_pfl join t_compte_cpt using(cpt_id);

2. Requête listant les données des profils des formateurs (/des administrateurs)

Des formateur:

select * from t_profil_pfl where pfl_role='F';

Des administrateurs:

select * from t_profil_pfl where pfl_role='A';

OU POUR AVOIR AUSSI LE PSEUDO:

select cpt_id,cpt_pseudo,pfl_role,pfl_nom,pfl_prenom,pfl_mail,pfl_actif from t_profil_pfl join t_compte_cpt using(cpt_id) where pfl_role='F';



3. Requête de vérification des données de connexion (login et mot de passe)

select cpt_pseudo,cpt_mdp from t_compte_cpt where cpt_pseudo='responsable' AND cpt_mdp='resp22_ZUIQ';


4. Requête récupérant les données d un profil particulier (utilisateur connecté)

select cpt_id,cpt_pseudo,pfl_role,pfl_nom,pfl_prenom,pfl_mail,pfl_actif from t_profil_pfl join t_compte_cpt using(cpt_id) where cpt_pseudo='responsable' ;

5. Requête récupérant tous les logins des profils et l état du profil (activé /
désactivé)

select cpt_pseudo,pfl_actif from t_compte_cpt join t_profil_pfl using(cpt_id);




_______
 Quiz :
_______




1. Requête(s) permettant de récupérer toutes les données (questions, choix
possibles) d’un quiz en particulier

select qst_texte,rep_libelle from t_question_qst join t_reponse_rep using(qst_id) where qui_id=1;

2. Requête qui compte les questions d’un quiz dont on connaît l’ID

select count(qst_id) as nb_de_questions from t_question_qst where qui_id=2;





_________
 Matchs :
_________


1. Requête permettant de récupérer toutes les données (questions, choix
possibles) d’un questionnaire associé à un match dont on connaît le code

select qst_texte,rep_libelle from t_match_mtc join t_question_qst using(qui_id) join t_reponse_rep using(qst_id) where mtc_id=1; 

2. Requête donnant le nombre de joueurs d’un match particulier

select count(jou_id) from t_joueur_jou where mtc_id=1;

3. Requête permettant de donner le score final d’un match particulier

update t_match_mtc set mtc_scoreactif=(select avg(jou_score) from t_joueur_jou where mtc_id=1) where mtc_id=1;

select mtc_scoreactif from t_match_mtc where mtc_id=1;

4. Requête listant les scores finaux et les pseudos des joueurs d’un match
particulier

select jou_pseudo,jou_score from t_joueur_jou where mtc_id=1;

5. Requête listant tous les matchs d’un formateur en particulier (formateur
connecté)

SELECT mtc_id,mtc_int,mtc_codematch from t_match_mtc join t_compte_cpt using(cpt_id) where cpt_pseudo='kocik';

6. Requête qui récupère tous les matchs associés à un quiz particulier
(connaissant son ID)

SELECT * from t_match_mtc where qui_id=1;
                         




