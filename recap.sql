set search_path to bdge, avions;

-- ex1
-- Écrivez une contrainte de check vérifiant qu'un avion ayant plus de 200 places possède une taille supérieure à 60 m et au moins 2 réacteurs.
alter table avion
drop constraint if exists bigger;

alter table avion
add constraint bigger
check ( nb_places <= 200 or taille > 60 and nb_reacteurs >=2);

-- ex2
-- Écrivez une vue compagnie_gros_avions qui présentera les données suivantes : nom, fonds dont la signification est la suivante
-- : nom est l'attribut nomc, fonds est l'attribut fonds_propres de la table compagnie.
-- Cette vue sélectionnera les compagnies affrétant uniquement des avions d'au moins 300 places.

create view compagnie_gros_avions(nom, fonds) as
    select nomc , fonds_propres
    from compagnie c
    join affrete a on c.idc = a.numc
    join avion a2 on a.numa = a2.ida
    where nb_places >=300;

select * from compagnie_gros_avions;

-- ex3
-- Écrivez une fonction table recevant un paramètre fonds de type int et
-- qui retourne une relation dont chaque ligne est constituée de deux colonnes: nomc et plus_cher_pilote.
-- Chaque ligne associe le nom d’une compagnie et un prix qui est celui du pilote qui peut travailler pour elle et qui a le plus haut prix_par_vol.
-- On se restreint aux compagnies ayant plus de fonds_propres que le paramètre fonds reçu par la fonction.

create or replace function ex3(fonds int)
returns table(nomc varchar, plus_cher_pilote int) as
$$
select nomc, max(prix_par_vol)
from compagnie c join peut_travailler t on c.idc = t.numc
    join pilote p on t.nump = p.idp
where c.fonds_propres >= fonds
group by nomc


$$language sql;


select * from ex3(10000);