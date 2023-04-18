INSERT INTO t_compte_cpt
	   VALUES (NULL,'responsable','f3b3fa2069f724136e1126745f3e66160928f1cc02981e51d7ae8de34abaef11'); 

INSERT INTO t_compte_cpt
	   VALUES (NULL,'aniol','d45ae270ee93a46ea19b11e485af7180298b36ea1797bbe3ed5e9a7f4a55b027'); 

INSERT INTO t_compte_cpt
	   VALUES (NULL,'kocik','f16883961a9647063c8707c328d5f84674d42181dd33b528a8847fa5965ebb19'); 

INSERT INTO t_compte_cpt
	   VALUES (NULL,'patocka','8c5f3e888faf9c184a89f698f01bd6644368b6b2ced4e7e463b3606316832759'); 

INSERT INTO t_compte_cpt
	   VALUES (NULL,'jpierre','279e05dae0e78b75cf07da206c770491ca6f1e58297c0610beeb73744071e10e');

INSERT INTO t_compte_cpt
	   VALUES (NULL,'ekowalsk','690d40a03636fe670aee14dc6d543cddb6515893c7ee907e661c7c0f7b470950');



INSERT INTO t_profil_pfl
	   VALUES (NULL,'A','Kacper','LaValle','kacper.lavalle@gmail.com','A');

INSERT INTO t_profil_pfl
		VALUES(NULL,'A','Leszcz','Aniol','leszczu.aniol@gmail.com','A');

INSERT INTO t_profil_pfl
		VALUES(NULL,'F','Kocik','Tadek','tadekkocik@gmail.com','A');

INSERT INTO t_profil_pfl
		VALUES(NULL,'F','Patocka','Wiktoria','wiktoriapato@gmail.com','A');

INSERT INTO t_profil_pfl
		VALUES(NULL,'F','Jean','Pierre','jeanpierre@gmail.com','A');  

INSERT INTO t_profil_pfl
	   VALUES (NULL,'A','Kowalski','Emanuel','kowalski.emanuel@gmail.com','A');




INSERT INTO t_actu_act
		VALUES(NULL,"Entrainement pour futur test",CURRENT_DATE,"Un entrainement sur les moteurs 2 temps de chez ktm aura lieu le 20.11.2022",'O',3);


INSERT INTO t_actu_act
		VALUES(NULL,"Test le 20.11.2022",CURRENT_DATE,"Un test sur les moteurs 2 temps de chez ktm aura lieu le 20.11.2022",'O',3);

INSERT INTO `t_actu_act` (`act_id`, `act_int`, `act_date`, `act_txt`, `act_etat`, `cpt_id`)
	    VALUES (NULL, 'Le quiz d\'id : 1', '2022-11-07', 'Entrainement 2 temps a ouvert le 2022-10-25 12:10:00 et n a pas encore fermé','O', '2');

INSERT INTO `t_actu_act` (`act_id`, `act_int`, `act_date`, `act_txt`, `act_etat`,  `cpt_id`)
        VALUES (NULL, 'Le quiz d\'id : 2', '2022-11-08', 'Entrainement 4 temps a ouvert le 2022-10-23 17:40:00 et a fermé le 2022-11-08 08:08:19 Les joueurs qui ont participé sont: Marianne,Léo,Gabriel,Alice','O', '1');


INSERT INTO `t_actu_act` (`act_id`, `act_int`, `act_date`, `act_txt`, `act_etat`, `cpt_id`) 
		VALUES	 (NULL, 'Modification du quiz 2', '2022-11-07', ' QUIZ VIDE ! Liste des matchs concernées: 8edc2dd9,0af0391f,e4fc6e4e, Liste des formateurs concernées: patocka','O', '1');



INSERT INTO t_quiz_qui
		VALUES(NULL,"Les moteurs 2 temps","2stroke.png",'O',3);

INSERT INTO t_quiz_qui
		VALUES(NULL,"Les moteurs 4 temps","4stroke.png",'O',4);

INSERT INTO t_quiz_qui
		VALUES(NULL,"Les moteurs rotatifs","rotat.png",'O',6);

INSERT INTO t_quiz_qui
		VALUES(NULL,"L'évolution des moteurs KTM'","ktm.png",'O',2);



INSERT INTO t_question_qst
		VALUES(NULL,'A',1,"Quelles est le cycle de fonctionnement d'un moteur 2 temps",1);

INSERT INTO t_question_qst
		VALUES(NULL,'A',2,"Quelles sont les pièces principales d'un moteur 2 temps",1);

INSERT INTO t_question_qst
		VALUES(NULL,'A',3,"Que ce situe à la sortie d'échappement sur les moteurs 2 temps plus avancés",1);	

INSERT INTO t_question_qst
		VALUES(NULL,'A',4,"Combien de tour de vilebrequin faut il pour accomplir un cycle complet sur les moteurs 2 temps",1);	



INSERT INTO t_question_qst
		VALUES(NULL,'A',1,"Quelles est le cycle de fonctionnement d'un moteur 4 temps",2);

INSERT INTO t_question_qst
		VALUES(NULL,'A',2,"Quelles sont les pièces principales d'un moteur 4 temps",2);

INSERT INTO t_question_qst
		VALUES(NULL,'A',3,"Que ce situe dans les echappements de 4 temps modernes",2);	

INSERT INTO t_question_qst
		VALUES(NULL,'A',4,"Combien de tour de vilebrequin faut il pour accomplir un cycle complet sur les moteurs 4 temps",2);	



INSERT INTO t_question_qst
		VALUES(NULL,'A',1,"Quelles est la deuxieme appellation du moteur rotatif ?",3);

INSERT INTO t_question_qst
		VALUES(NULL,'A',2,"Quels est le nom du piston dans un moteur rotatif ?",3);

INSERT INTO t_question_qst
		VALUES(NULL,'A',3,"Combien y'a t-il de chambre dans le cylindre d'un moteur rotatif ?",3);	

INSERT INTO t_question_qst
		VALUES(NULL,'A',4,"Quels est le plus gros problème du moteur rotatif ?",3);	












INSERT INTO t_reponse_rep
		VALUES(NULL,"Admission et échappement puis compression puis detente",1,1,1);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Compression puis admission et échappement puis detente",2,0,1);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Compression puis detente puis admission et échappement ",3,0,1);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Detente puis compression puis admission et échappement ",4,0,1);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Bougie, cylindre,piston,soupape d'échappements et vilebrequin",1,0,2);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Bougie, cylindre,piston,valve à clapets et vilebrequin",2,1,2);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Bougie, cylindre,piston,arbre à cames et vilebrequin",3,0,2);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Les valves",1,1,3);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Les soupapes",2,0,3);

INSERT INTO t_reponse_rep
		VALUES(NULL,"La boite à clapets",3,0,3);

INSERT INTO t_reponse_rep
		VALUES(NULL,"1",1,1,4);

INSERT INTO t_reponse_rep
		VALUES(NULL,"2",2,0,4);

INSERT INTO t_reponse_rep
		VALUES(NULL,"3",3,0,4);

 





INSERT INTO t_reponse_rep
		VALUES(NULL,"Admission puis compression puis explosion et detente puis echappement",1,1,5);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Compression puis admission puis explosion et detente puis echappement",2,0,5);

INSERT INTO t_reponse_rep
		VALUES(NULL,"explosion et detente puis echappement puis compression puis admission",3,0,5);


INSERT INTO t_reponse_rep
		VALUES(NULL,"Arbres à cames,courroie accesoires et valves d'échappement",1,0,6);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Arbres à cames,piston et valves d'échappement",2,0,6);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Arbres à cames,piston et soupape d'admission",3,1,6);


INSERT INTO t_reponse_rep
		VALUES(NULL,"Un catalyseur",1,1,7);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Une bielle",2,0,7);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Un vilebrequin",3,0,7);

INSERT INTO t_reponse_rep
		VALUES(NULL,"1 tour",1,0,8);

INSERT INTO t_reponse_rep
		VALUES(NULL,"2 tours",2,1,8);

INSERT INTO t_reponse_rep
		VALUES(NULL,"3 tours",3,0,8);




INSERT INTO t_reponse_rep
		VALUES(NULL,"Wankil",1,0,9);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Wankel",2,1,9);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Wankeli ",3,0,9);


INSERT INTO t_reponse_rep
		VALUES(NULL,"Pistor",1,0,10);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Stator",2,0,10);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Rotor",3,1,10);

INSERT INTO t_reponse_rep
		VALUES(NULL,"1",1,0,11);

INSERT INTO t_reponse_rep
		VALUES(NULL,"2",2,0,11);

INSERT INTO t_reponse_rep
		VALUES(NULL,"3",3,1,11);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Le cout de production",1,0,12);

INSERT INTO t_reponse_rep
		VALUES(NULL,"La fiabilité et la consommation",2,1,12);

INSERT INTO t_reponse_rep
		VALUES(NULL,"Le bruit très désagréable",3,0,12);



INSERT INTO t_match_mtc
		VALUES(NULL,"Entrainement 2 temps",56.2,'2022-10-23 12:10:00','2022-11-08 08:08:19','O','O',SUBSTRING(MD5(RAND()) FROM 1+rand()*4 FOR 8),1,3);

INSERT INTO t_match_mtc
		VALUES(NULL,"Entrainement 4 temps",0,'2022-10-23 17:40:00',NULL,'O','O',SUBSTRING(MD5(RAND()) FROM 1+rand()*4 FOR 8),3,4);

INSERT INTO t_match_mtc
		VALUES(NULL,"Entrainement 2 temps",0,'2022-10-23 19:30:17',NULL,'O','O',SUBSTRING(MD5(RAND()) FROM 1+rand()*4 FOR 8),1,3);

INSERT INTO t_match_mtc
		VALUES(NULL,"Entrainement 4 temps",0,'2022-10-24 16:10:00',NULL,'O','O',SUBSTRING(MD5(RAND()) FROM 1+rand()*4 FOR 8),3,4);

INSERT INTO t_match_mtc
		VALUES(NULL,"Entrainement 2 temps",0,'2022-10-27 17:15:00',NULL,'O','O',SUBSTRING(MD5(RAND()) FROM 1+rand()*4 FOR 8),1,3);

INSERT INTO t_match_mtc
		VALUES(NULL,"Entrainement 4 temps",0,CURRENT_DATE,NULL,'O','O',SUBSTRING(MD5(RAND()) FROM 1+rand()*4 FOR 8),3,4);



INSERT INTO t_joueur_jou
		VALUES(NULL,"Corentin",64,'2022-11-08 08:08:19',1);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Jonathan",43,'2022-11-08 08:08:19',1);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Vincent",77,'2022-11-08 08:08:19',1);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Lucie",37,'2022-11-08 08:08:19',1);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Chloé",60,'2022-11-08 08:08:19',1);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Marianne",0,NULL,2);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Léo",0,NULL,2);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Gabriel",0,NULL,2);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Alice",0,NULL,2);



INSERT INTO t_joueur_jou
		VALUES(NULL,"Rosa",0,NULL,3);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Francesca",0,NULL,3);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Mauro",0,NULL,3);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Benny",0,NULL,3);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Simon",0,NULL,3);


INSERT INTO t_joueur_jou
		VALUES(NULL,"Mateo",0,NULL,4);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Virgile",0,NULL,4);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Leticia",0,NULL,4);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Pierre",0,NULL,4);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Louisette",0,NULL,4);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Angel",0,NULL,5);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Ronny",0,NULL,5);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Markus",0,NULL,5);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Katarina",0,NULL,5);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Matti",0,NULL,5);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Emilien",0,NULL,6);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Aaron",0,NULL,6);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Javier",0,NULL,6);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Gweltaz",0,NULL,6);

INSERT INTO t_joueur_jou
		VALUES(NULL,"Lorna",0,NULL,6);











