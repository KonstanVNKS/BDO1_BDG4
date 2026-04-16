set search_path = bdge,bdlivre;

-- ex1
select nom, prenom
from traducteur_ecrivain
where lower(nat) = 'fr'
and idtrad_ecriv in (select numtrad
                       from traduit_par
                       where numlivre in (select livre_paru.idlivre
                                          from livre_paru
                                          where titre ilike '%intelligence artificielle%'
                                          and lower(langue) = 'fr'
                                          and lower(pays) = 'fr'));


-- ex2
select nom,prenom
from traducteur_ecrivain
where idtrad_ecriv in (select numEcriv
                       from ecrit_par
                       where numoeuvre in (select idoeuvre
                                           from oeuvre
                                           where idoeuvre in (select numoeuvre
                                                              from livre_paru
                                                              where lower(editeur) = 'gallimard'
                                                              and extract(year from date_parution) < 2000)));

-- ex3
select oeuvre.*
from livre_paru join oeuvre on livre_paru.numoeuvre = oeuvre.idoeuvre
group by oeuvre.idoeuvre
having count(numoeuvre) = 1;


select *
from oeuvre
where idoeuvre in (select numoeuvre
                   from livre_paru
                   group by numoeuvre
                   having count(*) = 1);

-- ex4
select titre
from livre_paru
where idlivre in (select numlivre
                  from traduit_par
                  group by numlivre
                  having count(numtrad)>1);

-- ex5
select nom, prenom
from traducteur_ecrivain
where idtrad_ecriv in (select numecriv from ecrit_par)
and idtrad_ecriv in (select numtrad from traduit_par);

-- ex6
select livres.titre,count(numecriv)+count(numtrad) nb
from (select idlivre , idoeuvre, oeuvre.titre as titre
    from livre_paru right join oeuvre on livre_paru.numoeuvre = oeuvre.idoeuvre) as livres
    left join traduit_par on livres.idlivre = traduit_par.numlivre
group by livres.titre;

