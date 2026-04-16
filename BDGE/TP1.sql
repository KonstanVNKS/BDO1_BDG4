set search_path = bdge,facebook_plus;
-- ex1
select count(*)
from personne;
-- ex2
select count(*)
from personne
where mail is null;
-- ex3
select count(*)
from personne
where mail is not null;
-- ex4
select nom , coalesce(reputation, 0)
from personne;
-- ex5
select nom, coalesce(mail, 'blabla@rtbf.be')
from personne;
-- ex6
select reputation, count(*)
from personne
group by reputation;
-- ex7
select reputation, count(*)
from personne
where reputation is not null
group by reputation;

-- ex8
select nom, numero
from personne left outer join telephone t on personne.ssn = t.ssn;

select nom, numero
from personne join telephone t on personne.ssn = t.ssn
union
select nom, 'NULL'
from personne
where ssn not in (select ssn from telephone);


-- ex9
select nom, string_agg(numero,',')
from personne left outer join telephone on personne.ssn = telephone.ssn
group by nom;


-- ex10
select nom, nb
from (select count(expediteur) as nb, nom
      from message right outer join personne on message.expediteur = personne.ssn
      group by  personne.ssn
      order by count(*) desc ) as count;

select nom, (select count(*) from message where message.expediteur = personne.ssn) as nb
from  personne;


-- ex11
select nom, (select count(*) from estami where estami.ssn1 = personne.ssn) as nb_a
from personne;

-- ex12
select max(nb)
from (select count(*) as nb from message group by expediteur) as compte;

-- ex13
select nom
from destinataires right outer join personne p on destinataires.destinataire = p.ssn
group by destinataire,nom
having count(destinataire)=(select max(nb)
from (select count(expediteur) as nb from message group by expediteur) as compte);

-- ex14
select avg(nb)
from (select count(destinataire) as nb from destinataires group by id_message) as compte;



