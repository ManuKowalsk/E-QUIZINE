<!-- ======= Hero Section ======= -->
<section id="hero" class="hero d-flex align-items-center">
  <div class="container">
    <div class="row gy-4 d-flex justify-content-between">
      <div class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center">
        <h2 data-aos="fade-up">Quiz N°
          <?php
          if ($match != NULL) {
            foreach ($match as $m) {
              // Affichage d’une ligne de tableau pour un pseudo non encore traité
              if (!isset($traite[$m["qui_id"]])) {
                echo $m["qui_id"];
              }
              $traite[$m["qui_id"]] = 1;
            }
          }
          ?>
        </h2>
        <p data-aos="fade-up" data-aos-delay="100">
          <?php
          if ($match != NULL) {
            foreach ($match as $m) {
              // Affichage d’une ligne de tableau pour un pseudo non encore traité
              if (!isset($traite[$m["qui_intitule"]])) {
                echo $m["qui_intitule"];
              }
              $traite[$m["qui_intitule"]] = 1;
            }


          }
          ?>
        </p>
        <div class="row gy-4" data-aos="fade-up" data-aos-delay="400">
        </div>
      </div>
      <div class="col-lg-5 order-1 order-lg-2 hero-img" data-aos="zoom-out">
        <img src="assets/img/hero-img.svg" class="img-fluid mb-3 mb-lg-0" alt="">
      </div>
    </div>
  </div>
</section><!-- End Hero Section -->

<main id="main">

  <section id="service" class="services pt-0">
    <div class="container" data-aos="fade-up">
      <div class="section-header">

        <span>Match n°:</span>
        <h2>Match n°:
          <?php
          if ($match != NULL) {
            foreach ($match as $m) {
              // Affichage d’une ligne de tableau pour un pseudo non encore traité
              if (!isset($traite[$m["mtc_codematch"]])) {
                echo $m["mtc_codematch"];
              }
              $traite[$m["mtc_codematch"]] = 1;
            }
          } else {
            echo "numéro de match incorrect";
          }
          echo "<br>";
          if ($match != NULL) {
            foreach ($match as $m) {
              // Affichage d’une ligne de tableau pour un pseudo non encore traité
              if (!isset($traite[$m["mtc_int"]])) {
                echo $m["mtc_int"];
              }
              $traite[$m["mtc_int"]] = 1;
            }
          }
          ?>
        </h2>
        <table class="table table-bordered">
          <thead>
            <tr>
              <th>Question</th>
              <th>Réponse</th>
            </tr>
          </thead>
          <tbody>
            <?php
            if ($match != NULL) {
            ?>
            <?php
              echo validation_errors();
              echo form_open('match/valider');
              // Boucle de parcours de toutes les lignes du résultat obtenu
              foreach ($match as $a) {
                // Affichage d’une ligne de tableau pour un pseudo non encore traité
                if (!isset($traite[$a["qst_texte"]])) {
                  $mtc_id = $a["qst_texte"];
                  echo "<tr>";
                  echo "<td>";
                  echo $a["qst_texte"];
                  echo "</td>";
                  echo "<td>";
                  // Boucle d’affichage des actualités liées au pseudo
                  foreach ($match as $mtc) {
                    echo "<ul>";
                    if (strcmp($mtc_id, $mtc["qst_texte"]) == 0) {
                      echo form_radio($a["qst_id"], $mtc["rep_correct"], FALSE);
                      echo "<li>";
                      echo $mtc["rep_libelle"];
                      echo "</li>";
                      //$checked = (isset($_POST[$mtc["rep_id"]])) ? true : false;
                      //if ($checked == true) {
                      //  echo ("correct");
                      //}
                    }
                    echo "</ul>";
                  }
                  echo "</td>";
                  // Conservation du traitement du pseudo
                  // (dans un tableau associatif dans cet exemple !)
                  $traite[$a["qst_texte"]] = 1;
                  echo "</tr>";
                }
              }

            } else {
              echo "<br />";
              echo "Aucun résultat !";
            }



            ?>
          </tbody>
        </table>

        <?php
        // echo validation_errors();
        //echo form_open('match/valider');
        if ($match != NULL) {
          echo form_hidden('code', $match[0]["mtc_codematch"]);
          echo form_hidden('pseudo', $pseudo);
          echo "<button type=\"submit\"  name=\"button\"> Valider</button>";
          echo "</form>";
        }
        ?>



      </div>
  </section><!-- End Featured Services Section -->