<section id="hero" class="hero d-flex align-items-center">
  <div class="container">
    <div class="row gy-4 d-flex justify-content-between">
      <div class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center">
        <h2 data-aos="fade-up">Rejoindre un match</h2>
        <p data-aos="fade-up" data-aos-delay="100">Veuillez saisir le code du match si dessous puis cliquer sur
          rejoindre</p>




        <!-- <?php echo validation_errors(); ?>
            <?php //echo form_open('accueil/afficher'); ?>
             <label for="matchid">Code du match</label>
             <input type="input" name="matchid" /><br />
             <label for="pseudo">Pseudo</label>
             <input type="input" name="pseudo" /><br />
             <input type="submit" name="submit" value="Rejoindre" />
            </form> -->
            <?php echo form_open(
              'page_accueil',
              'class="form-search d-flex align-items-stretch mb-3"',
              'data-aos="fade-up"',
              'data-aos-delay="200"'
            ); ?>
            <input type="input" class="form-control" name="codematch" maxlength="8" minlength="8" placeholder="Code du match">
            <button type="submit" class="btn btn-primary">Rejoindre</button>
          </form>

          <div class="row gy-4" data-aos="fade-up" data-aos-delay="400">

            <div class="col-lg-3 col-6">
              <div class="stats-item text-center w-100 h-100">
                <span data-purecounter-start="0" 
                <?php
                if (isset($quiz)) {
                  echo ("data-purecounter-end='$quiz->nb'");
                }
                ?>
                   data-purecounter-duration="1" class="purecounter"></span>
                <p>Quiz</p>
              </div>
            </div><!-- End Stats Item -->

        <div class="col-lg-3 col-6">
          <div class="stats-item text-center w-100 h-100">
            <span data-purecounter-start="0" <?php if (isset($match)) {   echo ("data-purecounter-end='$match->nb'"); } ?>
              data-purecounter-duration="1" class="purecounter"></span>
            <p>Matchs</p>
          </div>
        </div><!-- End Stats Item -->

        <div class="col-lg-3 col-6">
          <div class="stats-item text-center w-100 h-100">
            <span data-purecounter-start="0" <?php if (isset($player)) {      echo ("data-purecounter-end='$player->nb'"); } ?>
              data-purecounter-duration="1" class="purecounter"></span>
            <p>Joueurs</p>
          </div>
        </div><!-- End Stats Item -->

        <div class="col-lg-3 col-6">
          <div class="stats-item text-center w-100 h-100">
            <span data-purecounter-start="0" <?php if (isset($forma)) {   echo ("data-purecounter-end='$forma->nb'"); } ?>
              data-purecounter-duration="1" class="purecounter"></span>
            <p>Formateurs</p>
          </div>
        </div><!-- End Stats Item -->

      </div>
    </div>

    <div class="col-lg-5 order-1 order-lg-2 hero-img" data-aos="zoom-out">
      <img src="<?php echo base_url(); ?>style/assets/img/hero-img.svg" class="img-fluid mb-3 mb-lg-0" alt="">
    </div>

  </div>
  </div>
</section><!-- End Hero Section -->

<main id="main">

  <section id="service" class="services pt-0">
    <div class="container" data-aos="fade-up">
      <div class="section-header">
        <span>Actualités</span>
        <h2>Actualités</h2>
      </div>


      <table class="table table-hover">
        <?php
  if ($actu != NULL) {

    echo ("<thead>
      <tr>
        <th>Titre</th>
        <th>Description</th>
        <th>Date</th>
        <th>Auteur</th>
      </tr>
    </thead>
    <tbody>");
    foreach ($actu as $actu) {
      echo ("<tr>");
      echo ("<td>" . $actu['act_int'] . "</td>");
      echo ("<td>" . $actu['act_txt'] . "</td>");
      echo ("<td>" . $actu['act_date'] . "</td>");
      echo ("<td>" . $actu['nopre'] . "</td>");
    }
    echo ("</tbody>");
    echo ("</table>");
  } else {
    echo ("<br>");
    echo ("<p>Aucune actualité pour le moment ...</p>");
    echo ("<br>");
    echo ("<br>");

  }
  ?>
    </div>
    </div>
  </section>
</main>