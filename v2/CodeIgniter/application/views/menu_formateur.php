<?php
 if (!isset($_SESSION['username']) || ($_SESSION['role']) != 'F') { // verification si la session est active et si la personne connecté est formateur sinon renvoie à la page d'accueil
   redirect(base_url());
 }
 ?>
<!-- ======= Header ======= -->
<header id="header" class="header d-flex align-items-center fixed-top">
  <div class="container-fluid container-xl d-flex align-items-center justify-content-between">

    <a href="<?php echo base_url(); ?>style/index.html" class="logo d-flex align-items-center">
      <!-- Uncomment the line below if you also wish to use an image logo -->
      <!-- <img src="assets/img/logo.png" alt=""> -->
      <h1>E-Quizine</h1>
    </a>

    <i class="mobile-nav-toggle mobile-nav-show bi bi-list"></i>
    <i class="mobile-nav-toggle mobile-nav-hide d-none bi bi-x"></i>
    <nav id="navbar" class="navbar">
      <ul>
        <li><a href="<?php echo base_url(); ?>index.php/compte/accueil_forma" class="active">Accueil</a></li>
        <li><a href="<?php echo base_url(); ?>index.php/compte/profil">Profil</a></li>
        <li><a href="<?php echo base_url(); ?>index.php/compte/quiz_match">Matchs</a></li>
        <li><a class="get-a-quote" href="<?php echo base_url(); ?>index.php/compte/deconnexion">Déconnexion</a></li>
      </ul>
    </nav><!-- .navbar -->

  </div>
</header><!-- End Header -->
<!-- End Header -->