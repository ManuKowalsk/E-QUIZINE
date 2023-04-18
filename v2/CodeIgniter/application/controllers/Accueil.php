
<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Accueil extends CI_Controller {
 public function __construct()
 {
 parent::__construct();
 $this->load->model('db_model');
 $this->load->helper('url');
 }
 public function afficher() // fonction pour afficher les actualités, des compteurs ainsi que le formulaire pour le code du match
 {
     $data['actu'] = $this->db_model->get_all_actu();
     $data['player'] = $this->db_model->count_player();
     $data['quiz'] = $this->db_model->count_quiz();
     $data['match'] = $this->db_model->count_match(); 
     $data['forma'] = $this->db_model->count_forma(); 

     $this->load->helper('form');
     $this->load->library('form_validation');
     $this->form_validation->set_rules('codematch', 'codematch', 'required',array('required'=>
                                        'Veuillez saisir le code du match !'));
     if ($this->form_validation->run() == FALSE)
     {
         $this->load->view('templates/haut');
         $this->load->view('menu_visiteur');
         $this->load->view('page_accueil',$data);
         $this->load->view('templates/bas');
     }
     else
     {  
         $data['message_erreur']=NULL;
         $data['matchcode']=$this->input->post('codematch');
         $codedumatch=$this->input->post('codematch');
         $testcode= $this->db_model->check_match($codedumatch);
         if($testcode== NULL){
            $data['message'] = "Code de match inexistant, veuillez réessayez ... ";
            $this->load->view('templates/haut');
            $this->load->view('menu_visiteur');
            $this->load->view('page_erreur',$data);
            $this->load->view('templates/bas');
            $url=base_url();
           header('refresh:3;'.$url.'index.php/accueil/afficher');
         }
         else{
            $this->load->view('templates/haut');
            $this->load->view('menu_visiteur');
            $this->load->view('page_pseudomatch',$data);  
            $this->load->view('templates/bas');
         }
         //$url=base_url(); 
         //header("Location:https://obiwan.univ-brest.fr/difal3/zkowalsem/dev/CodeIgniter/index.php/match_rejoindre/$info");  A TRANSFERER SUR LE PONT
         //header("Location:../../index.php/match/afficher/$info");
         //$this->load->view('templates/haut');
         //$this->load->view('menu_visiteur');
         //$this->load->view('page_match',$data);
         //$this->load->view('templates/bas');
     }

     // Chargement des 3 vues pour créer la page Web d’accueil
 }



}
?>
