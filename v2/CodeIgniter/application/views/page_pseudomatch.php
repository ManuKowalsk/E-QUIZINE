<!-- ======= Hero Section ======= -->
<section id="hero" class="hero d-flex align-items-center">
  <div class="container">
    <div class="row gy-4 d-flex justify-content-between">
      <div class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center">
        <h2 data-aos="fade-up">
          <h2 data-aos="fade-up">
            <?php if ($message_erreur != NULL) {
                  echo $message_erreur;
                } else {
                  echo "Veuillez saisir un pseudo";
                }
                ?>
          </h2>
          <p data-aos="fade-up" data-aos-delay="100">Veuillez saisir un pseudo si dessous puis cliquer sur rejoindre</p>


          <?php echo validation_errors(); ?>
          <!-- 
<?php //echo form_open('match/rejoindre'); ?>
<label for="pseudo">Pseudo</label>
 <input type="input" name="pseudo" /><br />
 <?php //echo form_hidden('codematch',$matchcode); ?>
 <br />
 <input type="submit" name="submit" value="Rejoindre" />
</form> -->

<?php echo form_open(
  'match/rejoindre',
  'class="form-search d-flex align-items-stretch mb-3"',
  'data-aos="fade-up"',
  'data-aos-delay="200"'
); ?>
            <input type="input" class="form-control" name="pseudo" maxlength="20"  placeholder="Votre pseudo">
             <?php echo form_hidden('codematch', $matchcode); ?>
            <button type="submit" class="btn btn-primary">Rejoindre</button>
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