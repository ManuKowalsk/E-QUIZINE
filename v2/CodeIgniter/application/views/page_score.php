<section id="hero" class="hero d-flex align-items-center">
    <div class="container">
        <div class="row gy-4 d-flex justify-content-between">
            <div class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center">
                <main id="main">
                    <?php
                    if ($score > 50) {
                        echo ("<h1>");
                        echo ("Bravo " . "$pseudo" . " votre score est de : ");
                    } else {
                        echo ("<h1>");
                        echo (" " . "$pseudo" . " votre score est de : ");
                    }
                    echo $score;
                    echo (" % ");
                    echo ("</h1>");
                    echo ("<br>");
                    if ($correction == 1) {
                        echo ("La correction est disponible : ");
                        echo validation_errors();
                        echo form_open('match/correction');
                        echo form_hidden('code', $code);
                        echo "<button type=\"submit\"  name=\"button\"> Voir les bonnes réponses </button>";
                        echo "</form>";
                    } else {
                        echo ("La correction n'est pas disponible ");
                    }
                    ?>

            </div>
        </div>
    </div>
</section>