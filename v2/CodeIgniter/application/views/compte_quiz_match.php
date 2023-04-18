<main id="main">

  <section id="service" class="services pt-0">
    <div class="container" data-aos="fade-up">
      <div class="section-header">

        <span>Les Differents quiz et matchs</span>
        <h2>Les Differents quiz et matchs</h2>
        <table class="table table-bordered">
          <thead>
            <tr>
              <th>Quiz</th>
              <th>Matchs</th>
            </tr>
          </thead>
          <tbody>
            <?php
            if ($quiz != NULL) {
            ?>
            <?php
              // Boucle de parcours de toutes les lignes du resultat obtenu
              foreach ($quiz as $q) {
                // Affichage d'une ligne de tableau pour un id non encore traite
                if (!isset($traite[$q["qui_id"]])) {
                  $qui_id = $q["qui_id"];
                  echo "<tr>";
                  echo "<td>";
                  echo "ID du quiz : " . $q["qui_id"];
                  echo "<br>";
                  echo $q["qui_intitule"];
                  echo "<br>";
                  echo "Auteur du quiz : " . $q["auteur_quiz"];
                  echo "<br>";
                  $quizcplt = $q["qui_id"];
                  if (!($this->db_model->quiz_incomplet($quizcplt))) {
                    echo "Quiz incomplet !";
                  }
                  if ($this->db_model->quiz_incomplet($quizcplt)) {
                    echo validation_errors();
                    echo form_open('compte/formulaire_match');
                    echo form_hidden('code', $q["qui_id"]);
                    echo "<button type=\"submit\"  name=\"button\"> Créer un nouveau match pour ce quiz</button>";
                    echo "</form>";
                  }
                  echo "</td>";
                  echo "<td>";
                  // Boucle d affichage des actualites liees au pseudo
                  foreach ($quiz as $boucle) {
                    echo "<ul>";
                    if (strcmp($qui_id, $boucle["qui_id"]) == 0) {
                      if (($this->session->userdata('username')) == ($boucle["auteur_match"])) {

                        $url = base_url();
                        echo "<li>";
                        echo "Accèdez au match : ";
                        echo ("<a href='" . $url . "index.php/compte/afficher_match/" . $boucle["mtc_codematch"] . "'>" . $boucle['mtc_codematch'] . "</a>");
                        echo "</li>";
                        echo "<li>";
                        echo "Id du match : " . $boucle["mtc_id"];
                        echo "</li>";
                        echo "<li>";
                        echo " Intitule du match : ";
                        echo $boucle["mtc_int"];
                        echo "</li>";
                        if ($boucle["mtc_date_debut"] == NULL) {
                          echo "Pas de date de debut de match";
                        } else {
                          echo "Date de debut du match : " . $q["mtc_date_debut"];
                        }
                        echo "<li>";
                        if ($boucle["mtc_date_fin"] == NULL) {
                          echo "Pas de date de fin de match";
                        } else {
                          echo "Date de fin du match : " . $boucle["mtc_date_fin"];
                        }
                        echo "</li>";
                        echo "<li>";
                        echo "Score du match : " . $boucle["mtc_scoreactif"];
                        echo "</li>";
                        echo "<li>";
                        if ($boucle["mtc_etat_match"] == 'O') {
                          echo "Match Ouvert";
                        } else {
                          echo "Match fermé ";
                        }
                        echo "</li>";
                        echo "<li>";
                        if ($boucle["mtc_etat_corrige"] == 'O') {
                          echo "Corrige Ouvert";
                        } else {
                          echo "Corrige fermé ";
                        }
                        echo "</li>";
                        echo "<li>";
                        echo "Auteur du match : " . $boucle["auteur_match"];
                        echo "</li>";
                        echo "</a>";
                      } else {
                        if (($boucle["mtc_codematch"]) != NULL) {
                          echo "<li>";
                          echo "Code du match : " . $boucle["mtc_codematch"];
                          echo "</li>";
                          echo "<li>";
                          echo "Id du match : " . $boucle["mtc_id"];
                          echo "</li>";
                          echo "<li>";
                          echo " Intitule du match : ";
                          echo $boucle["mtc_int"];
                          echo "</li>";
                          if ($boucle["mtc_date_debut"] == NULL) {
                            echo "Pas de date de debut de match";
                          } else {
                            echo "Date de debut du match : " . $boucle["mtc_date_debut"];
                          }
                          echo "<li>";
                          if ($boucle["mtc_date_fin"] == NULL) {
                            echo "Pas de date de fin de match";
                          } else {
                            echo "Date de fin du match : " . $boucle["mtc_date_fin"];
                          }
                          echo "</li>";
                          echo "<li>";
                          echo "Score du match : " . $boucle["mtc_scoreactif"];
                          echo "</li>";
                          echo "<li>";
                          if ($boucle["mtc_etat_match"] == 'O') {
                            echo "Match Ouvert";
                          } else {
                            echo "Match fermé ";
                          }
                          echo "</li>";
                          echo "<li>";
                          if ($boucle["mtc_etat_corrige"] == 'O') {
                            echo "Corrige Ouvert";
                          } else {
                            echo "Corrige fermé ";
                          }
                          echo "</li>";
                          echo "<li>";
                          echo "Auteur du match : " . $boucle["auteur_match"];
                          echo "</li>";
                          echo "<br>";
                        }
                      }
                      echo "</ul>";
                      if (($this->session->userdata('username')) == ($boucle["auteur_match"])) {
                        echo validation_errors();
                        echo form_open('compte/raz_match');
                        echo form_hidden('code', $boucle["mtc_codematch"]);
                        echo "<button type=\"submit\"  name=\"button\"> Remettre à zéro le Match</button>";
                        echo "</form>";
                        echo validation_errors();
                        echo form_open('compte/delete_match');
                        echo form_hidden('code', $boucle["mtc_codematch"]);
                        echo "<button type=\"submit\"  name=\"button\"> Supprimer le Match</button>";
                        echo "</form>";
                        echo validation_errors();
                        echo form_open('compte/modif_etat');
                        echo form_hidden('code', $boucle["mtc_codematch"]);
                        echo "<button type=\"submit\"  name=\"button\"> Activer/Désactiver le Match</button>";
                        echo "</form>";
                        echo "<br>";
                      }
                    }

                  }
                  echo "</td>";
                  // Conservation du traitement du pseudo
                  // (dans un tableau associatif dans cet exemple !)
                  $traite[$q["qui_id"]] = 1;
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
      </div>
  </section><!-- End Featured Services Section -->