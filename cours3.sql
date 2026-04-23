-- ex2
alter table oeuvre
drop constraint if exists cs_exo2;

alter table oeuvre
add constraint cs_exo2
unique (titre,annee);


-- ex3
alter table livre_paru
drop constraint if exists cs_exo3;

alter table livre_paru
add constraint cs_exo3
check (extract(year from date_parution)>=1434);

select * from livre_paru;

-- ex4
alter table oeuvre
drop constraint if exists cs_exo4;

alter table oeuvre
add constraint cs_exo4
check ( lower(genre) in ('roman', 'poésie', 'musique','tragédie') and genre is not null);


-- ex5


-- ex6
alter table oeuvre
drop constraint if exists cs_exo6;

alter table oeuvre
add constraint cs_exo6
check ( annee > 1600 or genre != 'tragédie');

-- ex7

alter table livre_paru
drop constraint if exists cs_exo7;

alter table livre_paru
add constraint cs_exo7
check ( lower(editeur) != 'gallimard' or nb_pages <= 300 );

insert into livre_paru
values (18,5555555,'test5', 'Gallimard','fr','FR', '2001-02-12', 250);

select *
from livre_paru;

delete
from livre_paru
where titre = 'test5';

-- ex8
alter table livre_paru
drop constraint if exists cs_exo8;

alter table livre_paru
add constraint cs_exo8
check(lower(editeur)!='Pearson'
          or extract(year from date_parution) < 2000
          or nb_pages >=1000);