<section id="hero" class="hero d-flex align-items-center">
  <div class="container">
    <div class="row gy-4 d-flex justify-content-between">
      <div class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center">

        <h2>Espace d'administration</h2>
        <br />
        <h2>Session ouverte ! Bienvenue
          <?php
          echo $this->session->userdata('username');
          ?> !
        </h2>

      </div>
    </div>
  </div>
</section>