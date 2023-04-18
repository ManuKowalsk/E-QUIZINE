
<table class="table table-hover">
  <?php 
  if($listem != NULL) {

    echo("<thead>
      <tr>
        <th>ID</th>
        <th>Intitule</th>
        <th>Code du match</th>
        <th>Score</th>
        <th>Date de debut</th>
        <th>Date de fin</th>
        <th>Etat du corrige</th>
      </tr>
    </thead>
    <tbody>");
    $url=base_url();
    foreach($listem as $m){
      echo("<tr>");
        echo("<td>".$m['mtc_id'] . "</td>");
        echo("<td>".$m['mtc_int'] . "</td>");
        echo("<td>");
        echo("<a href='".$url."index.php/compte/afficher_match/".$m["mtc_codematch"]."'>".$m['mtc_codematch']."</a>");
        echo "</td>";
        echo("<td>".$m['mtc_scoreactif'] . "</td>");
        echo("<td>".$m['mtc_date_debut'] . "</td>");
        echo("<td>".$m['mtc_date_fin'] . "</td>");
        echo("<td>".$m['mtc_etat_corrige'] . "</td>");
      }
    echo("</tbody>");
  echo("</table>");
  }
  else{
  echo("<br>");
  echo("<p>Aucun Match ...</p>");
  echo("<br>");
  echo("<br>");

  }
?>