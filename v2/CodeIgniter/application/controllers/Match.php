<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Match extends CI_Controller {

 public function __construct()
 {
 parent::__construct();
 $this->load->model('db_model');
 $this->load->helper('url');
 }
 public function afficher($matchid =FALSE)
 {  
 if ($matchid==FALSE)
 { $url=base_url(); header("Location:$url");}
 else{
 $data['match'] = $this->db_model->get_quiz_from_match($matchid);


 // Chargement des 3 vues pour créer la page Web d’accueil
 $this->load->view('templates/haut');
 $this->load->view('menu_visiteur');
 $this->load->view('page_match2',$data); 
 $this->load->view('templates/bas');
    }   
 }

 public function rejoindre()
 {
  
           $this->load->helper('form');
           $this->load->library('form_validation');
           //$this->form_validation->set_data($data);
           $this->form_validation->set_rules('pseudo', 'pseudo', 'required');
           $this->form_validation->set_rules('codematch', 'codematch', 'required',array('required'=>
                                        'Veuillez saisir le code du match !'));
           if ($this->form_validation->run() == FALSE)
           {
            $data['message_erreur']="Veuillez saisir un pseudo ...";
            $data['matchcode']=$this->input->post('codematch');
            $this->load->view('templates/haut');
            $this->load->view('menu_visiteur');
            $this->load->view('page_pseudomatch',$data);  
            $this->load->view('templates/bas');
           }
           else
           {
           $data['matchcode']=$this->input->post('codematch');
           $info=$this->input->post('codematch');
           $pseudo=$this->input->post('pseudo');
           $testpseudo= $this->db_model->check_player($pseudo,$info);
           if($testpseudo == NULL){
            $this->db_model->set_player();
           
             $data['pseudo']=$pseudo;
             $data['match'] = $this->db_model->get_quiz_from_match($info);
              $this->load->view('templates/haut');
              $this->load->view('menu_visiteur');
              $this->load->view('page_match',$data); 
              $this->load->view('templates/bas');
           //header("Location:https://obiwan.univ-brest.fr/difal3/zkowalsem/dev/CodeIgniter/index.php/match/afficher/$info");
           }
           else{
            $data['message_erreur']="Pseudo déjà prit veuillez en sélectionner un autre ...";
            $this->load->view('templates/haut');
            $this->load->view('menu_visiteur');
            $this->load->view('page_pseudomatch',$data);  
            $this->load->view('templates/bas');
           }
           //header("Location:https://obiwan.univ-brest.fr/difal3/zkowalsem/dev/CodeIgniter/index.php/match/afficher/$info");
           }
          }

      public function valider(){
         $this->load->helper('form');
         $this->load->library('form_validation');
         $cpt=0;
         $score=0;
         $value=$this->input->post('1');
         $this->form_validation->set_rules('code', 'code', 'required');
         $this->form_validation->set_rules('pseudo', 'pseudo', 'required');
         $code=$this->input->post('code');
         $pseudo=$this->input->post('pseudo');
         $reponse=$this->db_model->get_reponse($code);
         $premiere=$reponse[0]["qst_id"];
         foreach($reponse as $rp){
            $value=$this->input->post($premiere);
            $this->form_validation->set_rules($premiere, $premiere, 'required');
            if($value==1){
               $score++;
            }
            $cpt++;
            $premiere++;
         }
         $resultat=($score/$cpt)*100;
         if($this->db_model->match_correction($code)){
            $correction=1;
         }
         else{
            $correction=0;
         }

         if ($this->form_validation->run() == FALSE)
           {
            $this->db_model->set_player_score($resultat,$pseudo);
            $data['pseudo']=$pseudo;
            $data['score']=$resultat;
            $data['code']=$code;
            $data['correction']=$correction;
            $this->load->view('templates/haut');
            $this->load->view('menu_visiteur');
            $this->load->view('page_score',$data);
            $this->load->view('templates/bas');
           }
         else{
            $this->db_model->set_player_score($resultat,$pseudo);
            $data['pseudo']=$pseudo;
            $data['score']=$resultat;
            $data['code']=$code;
            $data['correction']=$correction;
            $this->load->view('templates/haut');
            $this->load->view('menu_visiteur');
            $this->load->view('page_score',$data);
            $this->load->view('templates/bas');
         }
      }

      public function correction()
      {  
      $this->load->helper('form');
      $this->load->library('form_validation');
      $this->form_validation->set_rules('code', 'code', 'required');
      $code=$this->input->post('code');
      if ($this->form_validation->run() == FALSE)
      {
         $data['match'] = $this->db_model->get_reponse($code);
         $this->load->view('templates/haut');
         $this->load->view('menu_visiteur');
         $this->load->view('page_correction',$data);
         $this->load->view('templates/bas');
      }
      else{
         $data['match'] = $this->db_model->get_reponse($code);
         $this->load->view('templates/haut');
         $this->load->view('menu_visiteur');
         $this->load->view('page_correction',$data);
         $this->load->view('templates/bas');
      }

          
      }
 }


?>