<?php
class Db_model extends CI_Model {
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
                $id=$this->input->post('id');
                $mdp=$this->input->post('mdp');
                $req="INSERT INTO t_compte_cpt VALUES ('','".$id."','".$mdp."');";
                $query = $this->db->query($req);
                return ($query);
        }

        public function get_info_compte($id) //
        {
                $query = $this->db->query("SELECT * FROM t_compte_cpt join t_profil_pfl using(cpt_id) where cpt_pseudo='".$id."';");
                return $query->row();
        }

        public function modif_mdp($id,$password1)
        {
                $salt = "OnRajouteDuSelPourAllongerleMDP123!!45678__Test";
                $password = hash('sha256', $salt.$password1);
                $req="UPDATE t_compte_cpt set cpt_mdp='".$password."' where cpt_pseudo='".$id."';";
                $query = $this->db->query($req);
                return ($query);
        }

        public function get_info_all_compte()
        {
                $query = $this->db->query("SELECT * FROM t_compte_cpt join t_profil_pfl using(cpt_id);");
                return $query->result_array();
        }


        //Fonctions sur les actualités
         /*------------------------------------------------------------------------------------------*/


        public function get_actualite($numero) // fonction qui recupere l'id et l'intitule d'une actualité avec l'id passé en paramètre
        {
                $query = $this->db->query("SELECT act_id,act_int FROM t_actu_act WHERE
                        act_id=".$numero.";");
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
                $query = $this->db->query("SELECT * from t_match_mtc join t_question_qst using(qui_id) join t_reponse_rep using(qst_id) join t_quiz_qui using(qui_id) where mtc_codematch='".$matchid."';");
                return $query->result_array();
        }



        

        //Fonctions JOUEUR
         /*------------------------------------------------------------------------------------------*/
        
        public function set_player() // fonction qui rajoute un nouveau joueuer connaissant le pseudo et le code du match.
        {
                $this->load->helper('url');
                $matchid=$this->input->post('codematch');
                $pseudo=$this->input->post('pseudo');
                $req="INSERT INTO t_joueur_jou (jou_id,jou_pseudo,jou_score,jou_heurevalidation,mtc_id)
                      SELECT NULL,'".$pseudo."',0,NULL,codematch_en_id('".$matchid."');";
                $query = $this->db->query($req);
                return ($query);
        }

        public function check_player($playername,$codematch){ // fonction qui verifie si un match existe dans la base de donnée 
                $query = $this->db->query("SELECT jou_pseudo as pseudo from t_joueur_jou where jou_pseudo='".$playername."' AND mtc_id=codematch_en_id('".$codematch."');");
                return $query->row();
        }

        //Fonctions MATCH
         /*------------------------------------------------------------------------------------------*/

        public function check_match($matchid){ // fonction qui verifie si un match existe dans la base de donnée 
                $query = $this->db->query("SELECT mtc_codematch as mtc from t_match_mtc where mtc_codematch='".$matchid."';");
                return $query->row();
        }

        public function quiz_and_match_from_session(){
                $pseudo=$_SESSION['username'];
                $query = $this->db->query("call renvoie_match_pseudo('".$pseudo."')");
                return $query->result_array();
        }

        //Fonctions CONNEXION
         /*------------------------------------------------------------------------------------------*/

        public function connect_compte($username, $password)//fonction qui verifie si le pseudo et le mdp corresponde dans la bdd
         {
         $query =$this->db->query("SELECT cpt_pseudo,cpt_mdp
                        FROM t_compte_cpt
                        WHERE cpt_pseudo='".$username."'
                        AND cpt_mdp='".$password."';");
                 if($query->num_rows() > 0)
                 {
                        return true;
                 }
                 else
                 {
                        return false;
                 }
        }              

        public function profil_actif($username)//
         {
         $query =$this->db->query("SELECT cpt_pseudo
                        FROM t_compte_cpt
                        join t_profil_pfl using(cpt_id)
                        WHERE cpt_pseudo='".$username."' AND pfl_actif='A'
                        ;");
                 if($query->num_rows() > 0)
                 {
                        return true;
                 }
                 else
                 {
                        return false;
                 }
        }

        public function profil_admin($username)//
         {
         $query =$this->db->query("SELECT cpt_pseudo
                        FROM t_compte_cpt
                        join t_profil_pfl using(cpt_id)
                        WHERE cpt_pseudo='".$username."' AND pfl_role='A'
                        ;");
                 if($query->num_rows() > 0)
                 {
                        return true;
                 }
                 else
                 {
                        return false;
                 }
        }

         public function profil_role($username)//fonction qui verifie si le pseudo et le mdp corresponde dans la bdd
         {
         $query =$this->db->query("SELECT pfl_role
                        FROM t_compte_cpt
                        join t_profil_pfl using(cpt_id)
                        WHERE cpt_pseudo='".$username."';");
                 return $query->row();
        }

}
