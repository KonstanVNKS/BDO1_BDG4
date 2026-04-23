-- ex1
-- Écrivez une fonction scalaire qui permet de trouver le nombre de traducteurs ou écrivains de la BD (tous).

create or replace function nb_p()
returns integer as
$$
    select count(*)
    from traducteur_ecrivain
    where idtrad_ecriv in (select numtrad from traduit_par)
    or idtrad_ecriv in (select numecriv from ecrit_par);
$$language sql;

select nb_p();

-- ex2
-- Écrivez une fonction table qui liste les nom, prénom, nationalité des différents traducteurs de la BD.

create or replace function traducteur()
returns table(nom varchar,prenom varchar, nat varchar) as
    $$
        select nom,prenom,nat
        from traducteur_ecrivain
        where idtrad_ecriv in (select numtrad from traduit_par);
    $$language sql;

select *
from traducteur();


-- ex3
-- Écrivez une fonction qui ressort le nombre de livres traduits par un traducteur X particulier dont les nom et prénom
-- (paire supposée unique (discriminante !)) sont fournis en paramètre.

create or replace function nbLivreParTrad(tnom varchar, tprenom varchar)
returns integer as
$$
    select count(*)
    from traducteur_ecrivain t
    where (t.prenom = tprenom and t.nom=tnom)
    and t.idtrad_ecriv in (select numtrad from traduit_par);
$$language sql;

select nom, prenom, nbLivreParTrad('Popineau', prenom)
from traducteur_ecrivain;

-- ex4
-- Écrivez une fonction qui ressort le nombre d’oeuvres d’un genre donné écrites par un auteur donné.

create or replace function nbOeuvreParGenreEtPersonne(ogenre varchar, ida int)
returns int as
    $$
        select count(*)
        from oeuvre o
        join ecrit_par ep on o.idoeuvre = ep.numoeuvre
        where lower(ogenre)= lower(o.genre) and ida = ep.numecriv;
    $$language sql;

drop function nboeuvrepargenreetpersonne(ogenre varchar, ida integer);

select nboeuvrepargenreetpersonne('Tragédie', 3);