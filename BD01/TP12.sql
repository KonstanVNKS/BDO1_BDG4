-- ex1
SELECT personne.Nom,personne.Poids
FROM personne
where personne.Age <=32 
and personne.ID in (SELECT mange.ID_P
                      from mange
                      WHERE id_h in (SELECT hamburger.ID
                                     from hamburger
                                     where calories>1000 
                                     and genre="Boeuf"));
-- ex2
SELECT personne.Nom, personne.Age
from personne 
where personne.Poids > 60
and personne.ID in (SELECT mange.ID_P
                    FROM mange
                    where note < 7 
                    and id_h in (SELECT hamburger.ID
                                   from hamburger
                                   where genre = "Poulet"));
                                   
                                   
-- ex3
SELECT hamburger.Nom, avg(note)
from hamburger join mange on hamburger.ID = mange.ID_H
group by hamburger.Nom
having count(DISTINCT mange.id_p)>=3;

-- ex4
SELECT hamburger.Nom, count(DISTINCT id_p)
from hamburger join mange on hamburger.ID = mange.ID_H
group by hamburger.Nom
having avg(note)>=6;
-- ex5
SELECT personne.nom, personne.Sexe
from personne 
where id IN (SELECT id_p
             from mange 
             where personne.ID = mange.ID_P
             group by id_h,id_p
             having count(*)>=3);
-- ex6
SELECT mange.Date_Consommation
from mange 
group by mange.Date_Consommation, id_h
having count(id_h) >=2;

-- ex7 
SELECT hamburger.Nom
from hamburger
where hamburger.ID in (SELECT mange.ID_H
                       	   from mange 
                           where id_p IN(SELECT id
                                        FROM personne
                                        where (sexe = 'M' and poids > 100)
                                        )) 
and hamburger.ID not in(SELECT mange.ID_H
                    from mange 
                    where id_p IN(SELECT id
                                      FROM personne
                                      where (sexe = 'F' and age>30)));

-- ex8
SELECT nom
from personne
where id in (SELECT id_p
             from mange
             where id_h in (SELECT id
                            from hamburger
                            where genre = "Poulet"))
and id not in (SELECT id_p
               from mange
               WHERE id_h in (SELECT id
                              from hamburger
                              where genre="Boeuf" and calories<1000));

             
-- ex10
SELECT nom 
from hamburger
where genre = "Boeuf" 
and id in (SELECT id_h
            from mange
            where EXISTS (SELECT id
                          from personne
                          where poids>80
                          and mange.ID_P=personne.ID));
-- ex11 
SELECT * 
from hamburger
where calories < (SELECT max(calories)
                  from hamburger);
                  
-- ex12
SELECT id
from personne
where poids = (SELECT max(poids) from personne)
and id in (SELECT id_p
           from mange 
           where id_h in (SELECT id
                          FROM hamburger
                          WHERE genre="Poulet"));

-- ex13
SELECT id 
FROM hamburger
WHERE id in (SELECT id_h
             FROM mange
             WHERE id_p in (SELECT id 
                            FROM personne
                            where personne.Sexe ="M"))
and id in (SELECT id_h
             FROM mange
             WHERE id_p in (SELECT id 
                            FROM personne
                            where personne.Sexe ="F"))


-- ex14 
SELECT id 
FROM personne join mange on personne.ID =mange.ID_P
group by personne.ID
HAVING count(*) <= ALL(SELECT count(*)
                      from mange
                      GROUP by id_p);