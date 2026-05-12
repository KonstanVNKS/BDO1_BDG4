set search_path to bdge, bdlivre;
-- ex1
-- Modifier les procédures présentées dans la section Programmation modulaire afin que :
--
-- a. La procédure englobante reçoive le nom et le prénom de l'auteur au lieu de son id.
-- Pour l'exercice, vous pouvez considérer que la pair (nom, prenom) est unique dans la table traducteur_ecrivain.
--
-- b. Si l'écrivain n'existe pas dans la base de données, il faut le créer sinon il faut utiliser
-- son id existant pour le lier à la nouvelle oeuvre.
--
-- c. Faites-en sorte que le titre de l'oeuvre soit toujours stocké en majuscule.


CREATE OR REPLACE PROCEDURE creer_oeuvre(titre ttitre, annee tannee, genre tgenre, langue tlangue, OUT newId int)
LANGUAGE plpgsql
AS
$$
    BEGIN
        INSERT INTO oeuvre (titre, annee, genre, langue) VALUES (upper(titre), annee, genre, langue) RETURNING idOeuvre INTO newId;
    END
$$;


CREATE OR REPLACE PROCEDURE lier_oeuvre_ecriv(idOeuvre int, idEcriv int)
LANGUAGE plpgsql
As
$$
    BEGIN
        INSERT INTO ecrit_par (numOeuvre, numEcriv) VALUES (idOeuvre, idEcriv);
    END
$$;

create or replace procedure get_or_create_id_ecriv(nomEcriv tnom, prenomEcriv tprenom, out idecriv int)
language plpgsql
as
    $$
        BEGIN
           select idtrad_ecriv
            into idecriv
           from traducteur_ecrivain te
           where te.nom=nomEcriv and te.prenom = prenomEcriv;

           if idecriv is null then
               insert into traducteur_ecrivain (nom, prenom) values (nomEcriv, prenomEcriv) returning idtrad_ecriv into idecriv;
           end if;
        end
    $$;


CREATE OR REPLACE PROCEDURE creer_oeuvre_et_lier_a_ecriv(titre ttitre, annee tannee, genre tgenre, langue tlangue, nomEcriv tnom, prenomEcriv tnom )
LANGUAGE plpgsql
AS
$$
    DECLARE idOeuvre int;idEcriv int;
    BEGIN
        call creer_oeuvre(titre, annee, genre, langue, idOeuvre);
        call get_or_create_id_ecriv(nomEcriv,prenomEcriv,idEcriv);
        call lier_oeuvre_ecriv(idOeuvre, idEcriv);
    END
$$;


DO $$
DECLARE
    test_titre ttitre := 'Vingt mille lieues sous les mers';
    test_annee tannee := 1870;
    test_genre tgenre := 'Aventure';
    test_langue tlangue := 'Fr';
    test_nom tnom := 'Verne';
    test_prenom tprenom := 'Jules';
BEGIN

    CALL creer_oeuvre_et_lier_a_ecriv(
        test_titre, test_annee, test_genre, test_langue,
        test_nom, test_prenom
    );


END $$;

select* from oeuvre;