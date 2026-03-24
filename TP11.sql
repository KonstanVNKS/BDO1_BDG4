-- ex1
SELECT sname
from s
where EXISTS(SELECT id_s from spj where s.ID_S = spj.ID_S
             and spj.QTY > 500 
             and s.CITY = "London")
;
-- ex2
SELECT id_j
from j
where EXISTS(SELECT spj.id_j
             from spj
             where j.ID_J = spj.ID_J
             GROUP by spj.ID_J
             having sum(qty)>1000);

-- ex3
SELECT DISTINCT city 
from s
where EXISTS(SELECT* FROM p WHERE EXISTS(SELECT*from j WHERE s.CITY =p.CITY and p.CITY =j.CITY));

-- ex4 
SELECT sname
from s 
where Not EXISTS (SELECT id_s 
                  from spj 
                  where s.ID_S =spj.ID_S
                  and EXISTS(SELECT id_p
                             from p 
                             where spj.id_p = p.ID_P
                             and p.COLOR = 'Blue'));

-- ex5
SELECT id_s, count(*)
from spj
where NOT EXISTS(SELECT id_j 
                     from j
                     where city = 'Paris'
                     and spj.ID_J = j.ID_J)
and qty>350
GROUP by id_s;


-- ex6
SELECT id_s
from s
where not EXISTS(SELECT 1
                 from spj 
                 where s.ID_S = spj.ID_S
                 GROUP by id_p,spj.ID_S
                 having sum(QTY) >= 650);

-- ex 7 
SELECT id_s
from s 
where EXISTS(SELECT 1
             from spj, spj l2
             where s.ID_S = spj.ID_S
             GROUP by spj.id_s
             having count(spj.ID_S) >=4 and count(DISTINCT spj.ID_P) >=3);

-- ex 8


