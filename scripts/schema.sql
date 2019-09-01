-- auto-generated definition
create table jobs
(
  id           serial       not null,
  guid         varchar(128) not null
    constraint jobs_pk
    primary key,
  profile      varchar(128) not null,
  created_date timestamp default CURRENT_TIMESTAMP,
  status       varchar(64)
);

alter table jobs
  owner to postgres;

create unique index jobs_id_uindex
  on jobs (id);

create unique index jobs_guid_uindex
  on jobs (guid);

create index jobs_status_index
  on jobs (status);

-- auto-generated definition
create table encode
(
  id       serial not null
    constraint encode_pkey
    primary key,
  data     json,
  progress double precision default 0,
  job_id   integer
    constraint encode_jobs_id_fk
    references jobs (id)
);

alter table encode
  owner to postgres;

create unique index encode_id_uindex
  on encode (id);

-- auto-generated definition
create table users
(
  id       serial       not null,
  username varchar(128) not null
    constraint user_pkey
    primary key,
  password varchar(128) not null,
  role     varchar(64)
);

alter table users
  owner to postgres;

create unique index user_id_uindex
  on users (id);

create unique index user_username_uindex
  on users (username);


-- auto-generated definition
create table settings
(
    settings_option_id integer not null
        constraint settings_settings_option_id_fk
            references settings_option (id),
    value              varchar(256),
    id                 serial  not null
        constraint settings_pk
            primary key,
    user_id            integer
        constraint settings_users_id_fk
            references users (id)
);

alter table settings
    owner to postgres;

create unique index settings_id_uindex
    on settings (id);


-- auto-generated definition
create table settings_option
(
    id          serial not null,
    name        varchar(64),
    description varchar(1024)
);

alter table settings_option
    owner to postgres;

create unique index settings_option_id_uindex
    on settings_option (id);

