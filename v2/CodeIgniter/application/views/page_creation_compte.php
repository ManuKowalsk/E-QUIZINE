<h1> Remplissez tout les champs pour creer un match </h1>
<?php
echo validation_errors();
echo form_open('compte/formulaire_match');
echo form_hidden('code', $code); ?>
 <p>Intitule du match : <input type="text" name="int" /></p>
 <p>Date de début du match : <input type="datetime-local" name="datedebut" /></p>
 <p> Etat du match : <select name="etat" class="form-control"></p>
 <option> Ouvert </option>
 <option> Fermé </option>
</select>
 <p> Etat de la correction : <select name="etat2" class="form-control"></p>
 <option> Ouverte </option>
 <option> Fermée </option>
 </select>
 <p><input type="submit" value="Creer le match"></p>
</form>