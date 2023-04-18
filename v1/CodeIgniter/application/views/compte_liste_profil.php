
<table class="table table-hover">
  <?php 
  if($listep != NULL) {

    echo("<thead>
      <tr>
        <th>ID</th>
        <th>Pseudo</th>
        <th>Nom</th>
        <th>Prenom</th>
        <th>Mail</th>
        <th>Role</th>
        <th>Actif</th>
      </tr>
    </thead>
    <tbody>");
    foreach($listep as $p){
      echo("<tr>");
        echo("<td>".$p['cpt_id'] . "</td>");
        echo("<td>".$p['cpt_pseudo'] . "</td>");
        echo("<td>".$p['pfl_nom'] . "</td>");
        echo("<td>".$p['pfl_prenom'] . "</td>");
        echo("<td>".$p['pfl_mail'] . "</td>");
        echo("<td>".$p['pfl_role'] . "</td>");
        echo("<td>".$p['pfl_actif'] . "</td>");
      }
    echo("</tbody>");
  echo("</table>");
  }
  else{
  echo("<br>");
  echo("<p>Aucun Profil pour le moment ...</p>");
  echo("<br>");
  echo("<br>");

  }
?>