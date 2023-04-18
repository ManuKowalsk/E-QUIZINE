<?php echo validation_errors(); ?>
<?php echo form_open('match_rejoindre'); ?>
 <label for="id">Pseudo</label>
 <input type="input" name="pseudo" /><br />
 <input type="hidden" name="matchid" /><br />
 <input type="submit" name="submit" value="Rejoindre" />
</form>