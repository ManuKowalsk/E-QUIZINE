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
 $this->load->view('page_match',$data); 
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


 }


?>