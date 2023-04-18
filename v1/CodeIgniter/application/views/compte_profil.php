<?php 
if(!isset($_SESSION['username'])){ 
  redirect(base_url()) ; 
}
?>

   <section id="service" class="services pt-0">
      <div class="container" data-aos="fade-up">
  <div class="section-header">
          <span>Vos Informations</span>
          <h2>Vos Informations</h2>
        </div> 

          <?php
          if(($info->pfl_role)=='A'){
            $role="Administrateur";
          }
          else{
            $role="Formateur";
          }


          if(isset($info))
          {
          echo ("<table class='table table-hover'>");
          echo ("<thead>
              <tr>
              <th>Pseudo </th>
              <th>Nom </th>
              <th>Prenom</th>
              <th>Mail</th>
              <th>Role du profil</th>
              </tr>
              </thead>
              <tbody>");
                
        
                echo ("<tr>"); 
                echo ("<td>".$info->cpt_pseudo . "</td>" ."<td>". $info->pfl_nom. "</td>"); 
                echo ("<td>".$info->pfl_prenom. "</td>" ."<td>". $info->pfl_mail. "</td>");
                echo ("<td>".$role. "</td>");
                echo ("</tr>");
                echo ("</tbody></table>");
          }
          ?>
          <br>
          <h3> Formulaire pour modifier votre mot de passe :</h3>
          <br>
          <?php echo validation_errors(); ?>

          <?php echo form_open('compte/profil'); ?>

<h5>Nouveau mot de passe</h5>
<input type="text" name="mdp1"  />

<h5>Confirmation du nouveau mot de passe</h5>
<input type="text" name="mdp2"  />


<div><input type="submit" value="Modifier le mot de passe" /></div>

</form>
          


        </div>
       </div>
    </div>
</section>