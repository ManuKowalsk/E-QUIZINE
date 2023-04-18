<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Compte extends CI_Controller {


     public function __construct()
     {
     parent::__construct();
     $this->load->model('db_model');
     $this->load->helper('url_helper');

     }

     public function lister()
     {
     $data['titre'] = 'Liste des pseudos :';
     $data['pseudos'] = $this->db_model->get_all_compte();
     $data['player'] = $this->db_model->count_player();

     $this->load->view('templates/haut');
      $this->load->view('menu_visiteur');
     $this->load->view('compte_liste',$data);
     $this->load->view('templates/bas');
     }
     public function creer()
     {
     $this->load->helper('form');
     $this->load->library('form_validation');
     $this->form_validation->set_rules('id', 'id', 'required');
     $this->form_validation->set_rules('mdp', 'mdp', 'required');
     if ($this->form_validation->run() == FALSE)
     {
     //$this->load->view('templates/haut');
     //$this->load->view('menu_visiteur');
     $this->load->view('compte_creer');
     //$this->load->view('templates/bas');
     }
     else
     {
     $this->db_model->set_compte();
     //$this->load->view('templates/haut');
     //$this->load->view('menu_visiteur');
     $this->load->view('compte_succes');
     //$this->load->view('templates/bas');
     }
    }

    public function liste_profil(){
        $data['listep']=$this->db_model->get_info_all_compte();
        $this->load->view('templates/haut');
        $this->load->view('menu_administrateur');
        $this->load->view('espace_haut');
        $this->load->view('compte_liste_profil',$data);
        $this->load->view('templates/bas');                               
    }

    public function profil()
    {
                 $this->load->helper('form');
                 $this->load->library('form_validation');
                 $this->form_validation->set_rules('mdp1', 'mdp1', 'required');
                 $this->form_validation->set_rules('mdp2', 'mdp2', 'required');
                  if ($this->form_validation->run() == FALSE)
                {
                 $password1 = $this->input->post('mdp1');
                 $password2 = $this->input->post('mdp2');
                 $data['info'] = $this->db_model->get_info_compte($_SESSION['username']);
                 $this->load->view('templates/haut');
                 if(($_SESSION['role']) == 'A'){
                    $this->load->view('menu_administrateur');
                 }
                 else{
                    $this->load->view('menu_formateur');
                 }
                 $this->load->view('espace_haut');
                 $this->load->view('compte_profil',$data);
                 $this->load->view('templates/bas');
                }
                else
                {
                 $password1 = $this->input->post('mdp1');
                 $password2 = $this->input->post('mdp2');
                 if($password1==$password2){
                 $data['info'] = $this->db_model->profil_role($_SESSION['username']);
                 $data['message_redirect']="Mot de passe modifier avec succès.";
                 $this->db_model->modif_mdp($_SESSION['username'],$password1);
                 $this->load->view('templates/haut');
                 if(($_SESSION['role']) == 'A'){
                 $this->load->view('menu_administrateur');
                 }
                 else{
                    $this->load->view('menu_formateur');
                 }
                 $this->load->view('message_redirect',$data);
                 $this->load->view('templates/bas');
                 }
                 else{
                    $data['message_redirect']="Mot de passe non similaire";
                    $this->load->view('templates/haut');
                    if(($_SESSION['role']) == 'A'){
                     $this->load->view('menu_administrateur');
                     }
                     else{
                        $this->load->view('menu_formateur');
                     }
                    $this->load->view('message_redirect',$data);
                    $this->load->view('templates/bas');
                 }
                }
                 
    }
    public function accueil_admin(){
                $this->load->view('templates/haut');
                $this->load->view('menu_administrateur');
                $this->load->view('compte_menu');
                $this->load->view('templates/bas');
    }

    public function accueil_forma(){
                $this->load->view('templates/haut');
                 $this->load->view('menu_formateur');
                 $this->load->view('compte_menu');
                 $this->load->view('templates/bas');
    }
    public function connecter()
    {
        $this->load->helper('form');
        $this->load->library('form_validation');
        $this->form_validation->set_rules('pseudo', 'pseudo', 'required');
        $this->form_validation->set_rules('mdp', 'mdp', 'required');
        
        

        
        if ($this->form_validation->run() == FALSE)
         {
         $this->load->view('templates/haut');
         $this->load->view('menu_visiteur');
         $this->load->view('compte_connecter');
         $this->load->view('templates/bas');
         }
         else
         {
         $username = $this->input->post('pseudo');
         $password = $this->input->post('mdp');

         $salt = "OnRajouteDuSelPourAllongerleMDP123!!45678__Test"; 
         $hashpassword = hash('sha256', $salt.$password);


            if($this->db_model->connect_compte($username,$hashpassword))
            {
             $role = $this->db_model->profil_role($username);
             
             if($this->db_model->profil_actif($username) && $role->pfl_role=='A'){
                $session_data = array('username' => $username,'role' => $role->pfl_role);
                $this->session->set_userdata($session_data);
                redirect(base_url()."index.php/compte/accueil_admin");
                
             }   
             elseif($this->db_model->profil_actif($username)==false && $role->pfl_role=='A') {
                 $data['message']="Votre compte n'as toujours pas été activé";
                 $this->message_erreur($data);
             }
             
            
             
            elseif($this->db_model->profil_actif($username) && $role->pfl_role=='F'){
                $session_data = array('username' => $username,'role' => $role->pfl_role);
                $this->session->set_userdata($session_data);
                redirect(base_url()."index.php/compte/accueil_forma");
             } 
             elseif($this->db_model->profil_actif($username)==false && $role->pfl_role=='F') {
                 $data['message']="Votre compte n'as toujours pas été activé";
                 $this->message_erreur($data);
             } 
          }
          else
             {
             $data['message']="Echec mot de passe ou identifiant incorrect";   
             $this->message_erreur($data);
             }
         }

    }

    public function match(){
        $data['listem']=$this->db_model->quiz_and_match_from_session(); // a modifier 
        $this->load->view('templates/haut');
        $this->load->view('menu_formateur');
        $this->load->view('espace_haut');
        $this->load->view('compte_match',$data);
        $this->load->view('templates/bas');  
    }


    public function quiz_match(){
        $data['listem']=$this->db_model->quiz_and_match_from_session(); // a modifier 
        $this->load->view('templates/haut');
        $this->load->view('menu_formateur');
        $this->load->view('espace_haut');
        $this->load->view('compte_quiz_match',$data);
        $this->load->view('templates/bas');

    }
     public function afficher_match($matchid =FALSE)
     {  
     if ($matchid==FALSE)
     { $url=base_url(); header("Location:$url");}
     else{
     $data['match'] = $this->db_model->get_quiz_from_match($matchid);


     // Chargement des 3 vues pour créer la page Web d’accueil
     $this->load->view('templates/haut');
        $this->load->view('menu_formateur');
     $this->load->view('page_match',$data); 
     $this->load->view('templates/bas');
        }   
     }



    public function message_erreur($data){
                 $this->load->view('templates/haut');
                 $this->load->view('menu_visiteur');
                 $this->load->view('page_erreur',$data);
                 $this->load->view('compte_connecter');
                 $this->load->view('templates/bas');
    }

    public function deconnexion(){
        $this->session->sess_destroy();
        redirect(base_url());
    }
}