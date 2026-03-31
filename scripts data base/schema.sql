drop database if exists agence_voyage;
create database agence_voyage;
use agence_voyage;

create table client
(
    id     integer primary key,
    nom    varchar(50)  not null,
    prenom varchar(50)  not null,
    email  varchar(100) not null unique,
    ville  varchar(50)  not null,
    ddn    date         not null
);

create table destination
(
    id        integer primary key,
    pays      varchar(50) not null,
    ville     varchar(50) not null,
    continent varchar(30) not null,
    prix      integer     not null
);

create table voyage
(
    id          integer primary key,
    titre       varchar(100) not null,
    depart      date         not null,
    retour      date         not null,
    nb_places   integer      not null,
    destination integer      not null,
    foreign key (destination) references destination (id)
);

create table reservation
(
    id           integer primary key,
    date         date        not null,
    nb_personnes integer     not null,
    statut       varchar(20) not null,
    client       integer     not null,
    voyage       integer     not null,
    foreign key (client) references client (id),
    foreign key (voyage) references voyage (id)
);

create table paiement
(
    id          integer primary key,
    date        date        not null,
    montant     integer     not null,
    mode        varchar(20) not null,
    reservation integer     not null,
    foreign key (reservation) references reservation (id)
);

insert into client (id, nom, prenom, email, ville, ddn)
values (1, 'Martin', 'Alice', 'alice.martin@example.com', 'Paris', '1990-05-12'),
       (2, 'Durand', 'Bruno', 'bruno.durand@example.com', 'Namur', '1985-09-01'),
       (3, 'Bernard', 'Chloe', 'chloe.bernard@example.com', 'Bruxelles', '1998-11-23'),
       (4, 'Nguyen', 'David', 'david.nguyen@example.com', 'Anvers', '2000-01-20'),
       (5, 'Lambert', 'Emma', 'emma.lambert@example.com', 'Liege', '1995-03-01');

insert into destination (id, pays, ville, continent, prix)
values (1, 'France', 'Paris', 'Europe', 1200),
       (2, 'Japon', 'Tokyo', 'Asie', 1800),
       (3, 'Maroc', 'Marrakech', 'Afrique', 900),
       (4, 'Italie', 'Rome', 'Europe', 1500),
       (5, 'Italie', 'Venise', 'Europe', 1500);

insert into voyage (id, titre, depart, retour, nb_places, destination)
values (1, 'Escapade Paris', '2025-04-20', '2025-04-25', 22, 1),
       (2, 'Tokyo Express', '2025-05-20', '2025-05-28', 17, 2),
       (3, 'Week-end Paris', '2026-05-10', '2026-05-14', 30, 1),
       (4, 'Sejour Tokyo', '2026-06-01', '2026-06-10', 20, 2),
       (5, 'Circuit Maroc', '2026-07-05', '2026-07-12', 25, 3),
       (6, 'Paris & Musees', '2026-08-15', '2026-08-19', 15, 1),
       (7, 'Tokyo Express', '2026-09-01', '2026-09-08', 12, 2),
       (8, 'Escapade Lyon', '2026-10-05', '2026-10-10', 18, 1),
       (9, 'Grand Tour Venise', '2027-04-01', '2027-04-10', 40, 5);

insert into reservation (id, date, nb_personnes, statut, client, voyage)
values (1, '2026-03-01', 2, 'CONFIRMEE', 1, 3),
       (2, '2026-03-02', 1, 'EN_ATTENTE', 2, 4),
       (3, '2026-03-03', 3, 'CONFIRMEE', 3, 5),
       (4, '2026-03-04', 2, 'ANNULEE', 4, 6),
       (5, '2026-03-05', 4, 'CONFIRMEE', 1, 7),
       (6, '2026-03-06', 2, 'EN_ATTENTE', 2, 3),
       (7, '2026-03-07', 10, 'CONFIRMEE', 1, 8),
       (8, '2026-03-07', 8, 'CONFIRMEE', 2, 8),
       (9, '2025-03-11', 22, 'CONFIRMEE', 1, 1),
       (10, '2025-03-12', 4, 'EN_ATTENTE', 2, 1),
       (11, '2025-03-15', 2, 'EN_ATTENTE', 2, 2);

insert into paiement (id, date, montant, mode, reservation)
values (1, '2025-03-12', 26400, 'CARTE', 9),
       (2, '2025-03-13', 1200, 'VIREMENT', 10),
       (3, '2025-03-16', 1600, 'CASH', 11),
       (4, '2025-03-17', 400, 'CASH', 11),
       (5, '2026-03-02', 1400, 'CARTE', 1),
       (6, '2026-03-04', 2700, 'VIREMENT', 3),
       (7, '2026-03-06', 7200, 'CARTE', 5),
       (8, '2026-03-08', 2400, 'CASH', 6),
       (9, '2026-03-08', 12000, 'CARTE', 7),
       (10, '2026-03-08', 9600, 'CARTE', 8),
       (11, '2026-03-18', 1000, 'CARTE', 1);
