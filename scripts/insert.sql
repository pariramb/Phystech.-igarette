insert into locations
values (default, 46, 15, 'нк'),
       (default, 39, 13, 'фабрика'),
       (default, 45, 17, 'кпм'),
       (default, 50, 15, 'формула шаурмы'),
       (default, 38, 20, 'дирижабль'),
       (default, 44, 28, 'бассейн'),
       (default, 51, 16, '1ка'),
       (default, 48, 18, '2ка'),
       (default, 45, 20, '3ка'),
       (default, 49, 24, '4ка'),
       (default, 46, 24, '6ка'),
       (default, 44, 23, '7ка'),
       (default, 41, 23, '8ка'),
       (default, 38, 25, '9ка'),
       (default, 48, 22, '10ка'),
       (default, 50, 21, '11ка'),
       (default, 54, 07, '12ка'),
       (default, 21, 56, '13ка'),
       (default, 26, 58, '14ка');
table locations;
-- drop table locations;

insert into people
values (default, 'Yana'),
       (default, 'Nikita'),
       (default, 'Vlad'),
       (default, 'Alina'),
       (default, 'Katya'),
       (default, 'Ilya'),
       (default, 'Platon'),
       (default, 'Max'),
       (default, 'Igor'),
       (default, 'Roma'),
       (default, 'Tamara'),
       (default, 'Sasha'),
       (default, 'Kolya'),
       (default, 'Kirill'),
       (default, 'Danya'),
       (default, 'Karina'),
       (default, 'Yana');
table people;
-- drop table people;

insert into event
values (default, 'Вечный покур', timestamp '2024-10-19 00:00:00', timestamp '2024-10-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2024-11-19 00:00:00', timestamp '2024-11-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2024-12-19 00:00:00', timestamp '2024-12-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2025-01-19 00:00:00', timestamp '2025-01-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2025-02-19 00:00:00', timestamp '2025-02-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2025-03-19 00:00:00', timestamp '2025-03-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2025-04-19 00:00:00', timestamp '2025-04-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2025-05-19 00:00:00', timestamp '2025-05-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2025-06-19 00:00:00', timestamp '2025-06-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2025-07-19 00:00:00', timestamp '2025-07-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2025-08-19 00:00:00', timestamp '2025-08-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2025-09-19 00:00:00', timestamp '2025-09-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2025-10-19 00:00:00', timestamp '2025-10-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2025-11-19 00:00:00', timestamp '2025-11-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2025-12-19 00:00:00', timestamp '2025-12-20 00:00:00'),
       (default, 'Вечный покур', timestamp '2026-01-19 00:00:00', timestamp '2026-01-20 00:00:00');
table event;
-- drop table event;

-- INSERT INTO event (id, name, time_begin, time_end)
-- SELECT generate_series(1, 12),
--        'Вечный покур',
--        f1.begin,
--        f2.end
-- FROM (SELECT (current_date + (random() * interval '1 day')) as begin FROM generate_series(1, 3)) f1,
--      (SELECT (current_date + (random() * interval '1 day')) as end FROM generate_series(1, 3)) f2
-- WHERE f1.begin < f2.end;
-- table event;
-- drop table event;

insert into location_x_event (place_id, event_id, id)
select (random() * 14 + 1)::int,
       (random() * 14 + 1)::int,
       generate_series(1, 30);
table location_x_event; -- 10 21 28
-- drop table location_x_event;

insert into people_on_event (people_id, location_x_event_id, data_with_time, condition)
select (random() * 14 + 1)::int,
       (random() * 29 + 1)::int,
       current_date + (random() * interval '1 day'),
       random() > 0.5
from generate_series(1, 30);
table people_on_event;
-- drop table people_on_event;

insert into statistics (people_id, place_id, time, date)
select (random() * 14 + 1)::int,
       (random() * 14 + 1)::int,
       time '00:00:00' + (random() * 86399)::int * interval '1 second',
       current_date - (random() * 3650)::int
from generate_series(1, 1000);
table statistics;
-- drop table statistics;

INSERT INTO friends (id_person, id_friend)
SELECT DISTINCT ON (f1.id_person, f2.id_person) f1.id_person,
                                                f2.id_person
FROM (SELECT (random() * 14 + 1)::INT AS id_person FROM generate_series(1, 10)) f1,
     (SELECT (random() * 14 + 1)::INT AS id_person FROM generate_series(1, 10)) f2
WHERE f1.id_person != f2.id_person;
table friends;
-- drop table friends;



