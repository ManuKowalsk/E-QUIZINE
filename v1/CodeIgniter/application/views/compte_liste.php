<section id="hero" class="hero d-flex align-items-center">
    <div class="container">
      <div class="row gy-4 d-flex justify-content-between">
        <div class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center">

<h1><?php echo $titre;?></h1>
<br />
<?php
if($pseudos != NULL) {
if(isset($player)) {
               echo "Nombre total de comptes: ";
               echo$player->nb;
                }
echo("<br>");
foreach($pseudos as $login){
 echo "<br />";
 echo " -- ";
echo $login["cpt_pseudo"];
echo " -- ";
echo "<br />";

}
}

else {echo "<br />";
echo "Aucun compte !";
}
?>
</div>
</div>
</div>
</section>