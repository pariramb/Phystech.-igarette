-- друзья i-го человека(например 5-го)

select id_friend
from friends
where id_person = 5
order by id_friend;

-- вывести людей, которые учавствуют в метоприятии и локации с id = 26 на данный момент

with people_id as (select distinct on (people_id) people_id, condition
                   from people_on_event
                   where location_x_event_id = 26
                   order by people_id, data_with_time desc)
select name
from people
where id in (select people_id
             from people_id
             where condition);

-- вывести локации для мероприятия с id = 5

select distinct name
from locations
         join (table location_x_event) as l_e on l_e.place_id = locations.id
where event_id = 5;

-- найти имена людей, которые учавствуют в мероприятии с id = 12

with people_id1 as (select *
                    from people_on_event
                    where location_x_event_id in (select id
                                                  from location_x_event
                                                  where event_id = 12)),
     people_id as (select distinct on (people_id, location_x_event_id) people_id, location_x_event_id, condition
                   from people_id1
                   order by location_x_event_id, people_id, data_with_time desc)
select distinct on (name) name
from people
where id in (select people_id from people_id where condition);

-- найти количество людей, которые учавствуют в мероприятии с id = 12

with people_id1 as (select *
                    from people_on_event
                    where location_x_event_id in (select id
                                                  from location_x_event
                                                  where event_id = 12)),
     people_id as (select distinct on (people_id, location_x_event_id) people_id, condition
                   from people_id1
                   order by location_x_event_id, people_id, data_with_time desc)
select count(distinct id)
from people
where id in (select people_id from people_id where condition);

-- для каждого мероприятия вывести число людей, записанных на него в данный момент

with id as (select event.id as event_id, a.id as id
            from event
                     left join (select event_id, id from location_x_event) as a on event.id = a.event_id),
     cur_people as (select distinct on (location_x_event_id, people_id) location_x_event_id, people_id, condition
                    from people_on_event
                    order by location_x_event_id, people_id, data_with_time desc)
select id.event_id, count(a.people_id)
from id
         left join (select location_x_event_id, people_id, condition from cur_people where condition) as a
                   on id.id = a.location_x_event_id
group by id.event_id
order by event_id;

-- для человека с id = 5 вывести статистику

select place_id, date, time
from statistics
where people_id = 5
order by date, time;

-- найти самого курящего с 01.04.2018 по 01.05.2018

select people_id, count(*) as count
from statistics
where date between '2018-04-01' and '2018-05-01'
group by people_id
order by count desc
limit 1;

--- самое люимое место людей с 01.04.2019 по 01.05.2019

select place.name as favorite_places
from statistics
         join (select id, name from locations) as place on place.id = statistics.place_id
where statistics.date between '2019-04-01' and '2019-05-01'
group by favorite_places
order by count(*) desc
    fetch first 1 rows
with ties;

-- люди, курившие в 2018 году менее 10 раз

select id, name
from people
         join (select people_id
              from statistics
              where extract(year from date) = 2018
              group by people_id
              having count(*) < 10) as id on id.people_id = people.id