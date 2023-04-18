<section id="hero" class="hero d-flex align-items-center">
    <div class="container">
      <div class="row gy-4 d-flex justify-content-between">
        <div class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center">
		<?php
if(isset($actu)) {
echo $actu->act_id;
echo(" -- ");
echo $actu->act_int;
}
else {echo "<br />";
echo "pas d’actualité !";
}
?>
	</div>
		</div>
	</div>
</section>
