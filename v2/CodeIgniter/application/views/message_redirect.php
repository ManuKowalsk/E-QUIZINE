<section id="hero" class="hero d-flex align-items-center">
  <div class="container">
    <div class="row gy-4 d-flex justify-content-between">
      <div class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center">
        <main id="main">
          <?php
      if ($message_redirect != NULL) {
        echo $message_redirect;
      }
      header("Refresh: 3;");
      ?>



      </div>
    </div>
  </div>
</section>