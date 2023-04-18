<?php
/*
Nom du fichier : Db_model.php
Auteur: Kowalski Emanuel
Date de création: 27.11.2022
++++++++++++++++++++++++++++
Projet E-QUIZINE
+++++++++++++++++++++++++++++
Version V2
+++++++++++++++++++++++++++++
Le projet E-QUIZINE avait pour but de créer un site web de quiz, qui permet de répondre à des quiz
de toutes sortes, créer par des formateurs inscrits sur le site. Il y a aussi une partie dédié au
formateurs permettant de gérer leurs quiz et matchs, ainsi qu’une partie dédié au administrateur
permettant de gérer les comptes inscrits.
+++++++++++++++++++++++++++++
*/


class Db_model extends CI_Model
{
        public function __construct()
        {
                $this->load->database();
        }


        //Fonctions sur les comptes 
        /*------------------------------------------------------------------------------------------*/

        public function get_all_compte() // fonction qui recupere tout les pseudos de la table compte.

        {
                $query = $this->db->query("SELECT cpt_pseudo FROM t_compte_cpt;");
                return $query->result_array();
        }



        public function set_compte() // fonction qui recupere les infos passés en paramètres et les insères dans la table compte.

        {
                $this->load->helper('url');
                $id = $this->input->post('id');
                $mdp = $this->input->post('mdp');
                $req = "INSERT INTO t_compte_cpt VALUES ('','" . $id . "','" . $mdp . "');";
                $query = $this->db->query($req);
                return ($query);
        }

        public function get_info_compte($id) // fonction qui recupere toutes les infos du compte passé en parmaètre avec son id

        {
                $query = $this->db->query("SELECT * FROM t_compte_cpt join t_profil_pfl using(cpt_id) where cpt_pseudo='" . $id . "';");
                return $query->row();
        }

        public function modif_mdp($id, $password1) // fonction qui ajoute du sel au mot de passe pour le chiffre puis le modifie dans la bdd 

        {
                $salt = "OnRajouteDuSelPourAllongerleMDP123!!45678__Test";
                $password = hash('sha256', $salt . $password1);
                $req = "UPDATE t_compte_cpt set cpt_mdp='" . $password . "' where cpt_pseudo='" . $id . "';";
                $query = $this->db->query($req);
                return ($query);
        }

        public function get_info_all_compte() // fonction qui recupere toutes les infos de tout les comptes

        {
                $query = $this->db->query("SELECT * FROM t_compte_cpt join t_profil_pfl using(cpt_id);");
                return $query->result_array();
        }


        //Fonctions sur les actualités
        /*------------------------------------------------------------------------------------------*/


        public function get_actualite($numero) // fonction qui recupere l'id et l'intitule d'une actualité avec l'id passé en paramètre

        {
                $query = $this->db->query("SELECT act_id,act_int FROM t_actu_act WHERE
                        act_id=" . $numero . ";");
                return $query->row();
        }

        public function get_all_actu() // fonction qui recupere les 5 dernières actualités actualités publiés 

        {
                $query = $this->db->query("SELECT act_id,act_int,act_date,act_txt,CONCAT(pfl_nom , ' ', pfl_prenom) as nopre FROM t_actu_act join t_profil_pfl using(cpt_id)where act_etat='O' order by act_date DESC LIMIT 5;");
                return $query->result_array();
        }



        //Fonctions count
        /*------------------------------------------------------------------------------------------*/

        public function count_player() //fonction qui compte tout les joueurs

        {
                $query = $this->db->query("SELECT count(jou_id) as nb FROM t_joueur_jou;");
                return $query->row();
        }

        public function count_quiz() // fonction qui compte tout les quiz

        {
                $query = $this->db->query("SELECT count(qui_id) as nb FROM t_quiz_qui;");
                return $query->row();
        }

        public function count_match() // fonction qui compte tout les matchs

        {
                $query = $this->db->query("SELECT count(mtc_id) as nb FROM t_match_mtc;");
                return $query->row();
        }

        public function count_forma() // fonction qui compte tout les formateurs

        {
                $query = $this->db->query("SELECT count(cpt_id) as nb FROM t_profil_pfl where pfl_role='F';");
                return $query->row();
        }

        public function count_compte()
        {
                $query = $this->db->query("SELECT count(cpt_id) as nb FROM t_profil_pfl;");
                return $query->row();
        }

        //Fonctions QUIZ
        /*------------------------------------------------------------------------------------------*/


        public function get_quiz_from_match($matchid) // fonction qui recupere le quiz et les questions réponses associés a partir de l'id d'un match

        {
                $query = $this->db->query("SELECT * from t_match_mtc join t_question_qst using(qui_id) join t_reponse_rep using(qst_id) join t_quiz_qui using(qui_id) where mtc_codematch='" . $matchid . "';");
                return $query->result_array();
        }

        public function get_reponse($matchid) // fonction qui recupere le quiz et les questions réponses associés a partir de l'id d'un match

        {
                $query = $this->db->query("SELECT * from t_match_mtc join t_question_qst using(qui_id) join t_reponse_rep using(qst_id) join t_quiz_qui using(qui_id) where mtc_codematch='" . $matchid . "' AND rep_correct=1;");
                return $query->result_array();
        }


        public function quiz_incomplet($id) //fonction qui verifie si un quiz est complet

        {
                $query = $this->db->query("select qst_id from t_question_qst where qui_id='" . $id . "';");
                if ($query->num_rows() > 0) {
                        return true;
                } else {
                        return false;
                }
        }


        //Fonctions JOUEUR
        /*------------------------------------------------------------------------------------------*/

        public function set_player() // fonction qui rajoute un nouveau joueuer connaissant le pseudo et le code du match.

        {
                $this->load->helper('url');
                $matchid = $this->input->post('codematch');
                $pseudo = $this->input->post('pseudo');
                $req = "INSERT INTO t_joueur_jou (jou_id,jou_pseudo,jou_score,jou_heurevalidation,mtc_id)
                      SELECT NULL,'" . $pseudo . "',0,NULL,codematch_en_id('" . $matchid . "');";
                $query = $this->db->query($req);
                return ($query);
        }

        public function check_player($playername, $codematch)
        { // fonction qui verifie si un joueur associé a son codematch existe dans la base de donnée 
                $query = $this->db->query("SELECT jou_pseudo as pseudo from t_joueur_jou where jou_pseudo='" . $playername . "' AND mtc_id=codematch_en_id('" . $codematch . "');");
                return $query->row();
        }

        public function set_player_score($resultat, $pseudo) // fonction qui rajoute un nouveau joueuer connaissant le pseudo et le code du match.

        {
                $req = "UPDATE t_joueur_jou
                        SET jou_score='" . $resultat . "',jou_heurevalidation=NOW() 
                        WHERE jou_pseudo='" . $pseudo . "';";
                $query = $this->db->query($req);
                return ($query);
        }

        //Fonctions MATCH
        /*------------------------------------------------------------------------------------------*/

        public function check_match($matchid)
        { // fonction qui verifie si un match existe dans la base de donnée 
                $query = $this->db->query("SELECT mtc_codematch as mtc from t_match_mtc where mtc_codematch='" . $matchid . "';");
                return $query->row();
        }

        public function quiz_and_match_from_session()
        { // fonction qui recupere les infos d'un match depuis le pseudo de la session
                $pseudo = $_SESSION['username'];
                $query = $this->db->query("call renvoie_match_pseudo('" . $pseudo . "')");
                return $query->result_array();
        }

        public function quiz_and_match()
        { // fonction qui recupere tout les quiz et tout les matchs avec leur auteurs associés.
                $query = $this->db->query("SELECT t_quiz_qui.qui_id as qui_id,qui_intitule,cpt_pseudo as auteur_quiz,mtc_codematch,mtc_id,mtc_date_debut,mtc_scoreactif,mtc_date_fin,mtc_etat_match,mtc_etat_corrige,mtc_int,id_en_pseudo(t_match_mtc.cpt_id) as auteur_match from t_quiz_qui 
                        left join t_compte_cpt on t_quiz_qui.cpt_id=t_compte_cpt.cpt_id
                        left join t_match_mtc on t_quiz_qui.qui_id=t_match_mtc.qui_id ORDER BY qui_id;");
                return $query->result_array();
        }

        public function raz_match($codematch) // fonction qui remet à zéro un match passé en paramètre.

        {
                $query = $this->db->query("UPDATE t_match_mtc
                                           SET mtc_scoreactif=0,mtc_date_debut=NOW() + INTERVAL 1 DAY,mtc_date_fin=NULL
                                           where mtc_codematch='" . $codematch . "';");
                return $query;
        }

        public function delete_match($codematch) // fonction qui efface un match passé en paramètre

        {
                $query = $this->db->query("DELETE FROM t_match_mtc
                                           where mtc_codematch='" . $codematch . "';");
                return $query;
        }

        public function modif_etat($codematch) // fonction qui modifie l'état d'un match passé en paramètre

        {
                $query = $this->db->query("call modif_etat_match('" . $codematch . "');");
                return $query;
        }

        public function create_match() // fonction qui creer un match depuis un formulaire

        {
                $this->load->helper('url');
                $code = $this->input->post('code');
                $int = $this->input->post('int');
                $datedebut = $this->input->post('datedebut');
                $etat = $this->input->post('etat');
                $etat2 = $this->input->post('etat2');
                if ($etat == "Ouvert") {
                        $etat = 'O';
                } else {
                        $etat = 'F';
                }
                if ($etat2 == "Ouverte") {
                        $etat2 = 'O';
                } else {
                        $etat2 = 'F';
                }
                $pseudo = $_SESSION['username'];
                $req = "INSERT INTO t_match_mtc VALUES ('','" . $int . "',0,'" . $datedebut . "',NULL,'" . $etat . "','" . $etat2 . "',SUBSTRING(MD5(RAND()) FROM 1+rand()*4 FOR 8),'" . $code . "',pseudo_en_id('" . $pseudo . "'));";
                $query = $this->db->query($req);
                return ($query);
        }

        public function match_correction($code) // fonction qui verifie si la correction du match est ouvert

        {
                $query = $this->db->query("SELECT mtc_etat_match
                        FROM t_match_mtc
                        WHERE mtc_codematch='" . $code . "' AND mtc_etat_corrige='O'
                        ;");
                if ($query->num_rows() > 0) {
                        return true;
                } else {
                        return false;
                }
        }

        public function terminer_match($code) // fonction qui terminer un match en placant une date de fin.

        {
                $query = $this->db->query("UPDATE t_match_mtc
                        SET mtc_date_fin=NOW()
                        WHERE mtc_codematch='" . $code . "'
                        ;");
                return ($query);
        }

        //Fonctions CONNEXION
        /*------------------------------------------------------------------------------------------*/

        public function connect_compte($username, $password) //fonction qui verifie si le pseudo et le mdp corresponde dans la bdd

        {
                $query = $this->db->query("SELECT cpt_pseudo,cpt_mdp
                        FROM t_compte_cpt
                        WHERE cpt_pseudo='" . $username . "'
                        AND cpt_mdp='" . $password . "';");
                if ($query->num_rows() > 0) {
                        return true;
                } else {
                        return false;
                }
        }

        public function profil_actif($username) // fonction qui verifie si un profil est actif dans la bdd

        {
                $query = $this->db->query("SELECT cpt_pseudo
                        FROM t_compte_cpt
                        join t_profil_pfl using(cpt_id)
                        WHERE cpt_pseudo='" . $username . "' AND pfl_actif='A'
                        ;");
                if ($query->num_rows() > 0) {
                        return true;
                } else {
                        return false;
                }
        }

        public function profil_admin($username) // fonction qui verifie si le role du profil passé en paramètre est un admin

        {
                $query = $this->db->query("SELECT cpt_pseudo
                        FROM t_compte_cpt
                        join t_profil_pfl using(cpt_id)
                        WHERE cpt_pseudo='" . $username . "' AND pfl_role='A'
                        ;");
                if ($query->num_rows() > 0) {
                        return true;
                } else {
                        return false;
                }
        }

        public function profil_role($username) //fonction qui selectionne le role du profil passée en paramètre

        {
                $query = $this->db->query("SELECT pfl_role
                        FROM t_compte_cpt
                        join t_profil_pfl using(cpt_id)
                        WHERE cpt_pseudo='" . $username . "';");
                return $query->row();
        }



}