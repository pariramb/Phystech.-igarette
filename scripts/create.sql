create table locations (
  id serial primary key,
  sec_e smallint,
  sec_n smallint,
  name varchar(100) NOT NULL
);

create table people (
  id serial primary key,
  name varchar(255) not null
);

create table event (
  id serial primary key,
  name varchar(255) not null,
  time_begin timestamp,
  time_end timestamp check (time_end > time_begin)
);

create table location_x_event (
  place_id serial references locations(id),
  event_id serial references event(id),
  id serial primary key
);

create table people_on_event (
  people_id serial references people(id),
  location_x_event_id serial references location_x_event(id),
  data_with_time timestamp,
  condition boolean
);

create table statistics (
  people_id serial references people(id),
  place_id serial references locations(id),
  time time not null,
  date date not null
);

create table friends (
  id_person serial references people(id),
  id_friend serial references people(id) check(id_person != friends.id_friend),
  primary key (id_friend, id_person)
);

