<!-- ======= Hero Section ======= -->
<section id="hero" class="hero d-flex align-items-center">
  <div class="container">
    <div class="row gy-4 d-flex justify-content-between">
      <div class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center">
        <h2 data-aos="fade-up">
          <h2 data-aos="fade-up">
            <?php echo validation_errors(); ?>
            <?php echo form_open('compte_connect', 'class="form-search d-flex align-items-stretch mb-3"', 'data-aos="fade-up"', 'data-aos-delay="200"'); ?>
            <input type="input" class="form-control" name="pseudo" maxlength="20" placeholder="Pseudo">
            <input type="password" class="form-control" name="mdp" maxlength="20" placeholder="Mot de Passe">
            <button type="submit" class="btn btn-primary">Connexion</button>
            </form>

            <div class="row gy-4" data-aos="fade-up" data-aos-delay="400">
            </div>
      </div>
      <div class="col-lg-5 order-1 order-lg-2 hero-img" data-aos="zoom-out">
        <img src="assets/img/hero-img.svg" class="img-fluid mb-3 mb-lg-0" alt="">
      </div>
    </div>
  </div>
</section><!-- End Hero Section -->