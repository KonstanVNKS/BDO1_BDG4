/*
-- noinspection SqlInsertValuesForFile

Permet d'éviter le warning "Following columns have no computed/default value and must be listed explicitly"
quand on fait un insert dans une vue sans donner de valeur pour la clé. DataGrip donne un warning, mais les requêtes
sont totalement valides pour PGSQL.
*/

set search_path to bdge, bdlivre;

create or replace view vue1(titre, prénom, nom) as
select o.titre, ecr.prenom, ecr.nom
from oeuvre o
         join ecrit_par ep on o.idoeuvre = ep.numoeuvre
         join traducteur_ecrivain ecr on ecr.idtrad_ecriv = ep.numecriv;

select *
from vue1
where titre ilike 'a%';

create or replace view auteur_français as
select *
from traducteur_ecrivain
where lower(nat) = 'fr'
with check option;

select *
from auteur_français;

-- refusé car nat = 'en'
insert into auteur_français (nom, prenom, ddn, ddd, nat, sexe)
values ('Potter', 'Harry', null, null, 'en', 'M');

-- accepté car nat = 'fr'
insert into auteur_français (nom, prenom, ddn, ddd, nat, sexe)
values ('Potter', 'Harry', null, null, 'fr', 'M');


/*
1. Créez une vue nommée livre_eponyme avec le idLivre, le titre, l'année de parution du livre,
l'année d'écriture de l'oeuvre originale ne reprenant que les livres ayant le même titre que cette oeuvre.
*/

create or replace view livre_eponyme as
select idlivre, livre_paru.titre, extract(year from date_parution) as annee_parution, annee as annee_oeuvre
from livre_paru
         join oeuvre on numoeuvre = idoeuvre
where lower(livre_paru.titre) = lower(oeuvre.titre);

-- Remarquez que la spécification des noms des colonnes de la vue est optionnelle.
-- Si vous l'omettez, ce sont les noms des colonnes des tables ou leur alias qui sont utilisés.

select *
from livre_eponyme;


/*
2. Créez une vue Auteurs_Editeur dont l'affichage listerait les noms, prénoms des différents écrivains de la BD
avec en regard les titres des oeuvres qu'ils ont écrites, les éditeurs chez qui elles ont été publiées,
et leur date de parution. Nous ne voulons pas voir apparaître de renseignements liés à des éditeurs inconnus (editeur à Null)
*/

create or replace view auteurs_editeur as
select distinct nom, prenom, oeuvre.titre, editeur, date_parution
from traducteur_ecrivain
         join ecrit_par on idtrad_ecriv = numecriv
         join oeuvre on numoeuvre = idoeuvre
         join livre_paru on livre_paru.numoeuvre = idoeuvre
where editeur is not null;

select *
from auteurs_editeur;

-- Les inserts ci-dessous ne marchent pas car 'auteurs_editeur' n'est pas updatable
-- car elle contient une jointure.
-- Voir https://www.postgresql.org/docs/current/sql-createview.html#SQL-CREATEVIEW-UPDATABLE-VIEWS pour les
-- conditions pour avoir une vue updatable.

insert into auteurs_editeur (nom, prenom, titre, editeur, date_parution)
values ('aaa', 'aaa', 'aaa', 'aaa', '2002-01-01');

insert into auteurs_editeur (nom, prenom)
values ('aaa', 'aaa');


/*
3. Créez une vue livre_français avec tous les renseignements des livres français. Remarquez que
vous pouvez modifier les données des livres en question à partir de cette vue.
*/

create or replace view livre_français as
select *
from livre_paru
where lower(langue) = 'fr';

select *
from livre_français;

-- Les deux insert vont marcher, mais le second ne sera pas visible dans la vue
insert into livre_français (isbn, titre, editeur, langue, pays, date_parution, nb_pages, numoeuvre)
values ('654321', 'yyyy', 'yyyyy', 'Fr', 'Fr', '2006-01-01', 560, 5);
insert into livre_français (isbn, titre, editeur, langue, pays, date_parution, nb_pages, numoeuvre)
values ('123456', 'xxxx', 'xxxx', 'It', 'It', '2006-01-01', 560, 5);

select *
from livre_français;

delete
from livre_paru
where titre in ('xxxx', 'yyyy');


/*
4. Modifiez la vue précédente afin de faire en sorte que l’on puisse modifier
toutes données de ces livres excepté le fait qu’ils soient écrits en français.
*/
create or replace view livre_français as
select *
from livre_paru
where lower(langue) = 'fr'
with check option;

select *
from livre_français;

-- Le premier insert ne va pas marcher car le livre donné est italien, mais le second bien
insert into livre_français (isbn, titre, editeur, langue, pays, date_parution, nb_pages, numoeuvre)
values ('123456', 'xxxx', 'xxxx', 'It', 'It', '2006-01-01', 560, 5);
insert into livre_français (isbn, titre, editeur, langue, pays, date_parution, nb_pages, numoeuvre)
values ('654321', 'yyyy', 'yyyyy', 'Fr', 'Fr', '2006-01-01', 560, 5);

select *
from livre_français;

delete
from livre_paru
where titre in ('xxxx', 'yyyy');