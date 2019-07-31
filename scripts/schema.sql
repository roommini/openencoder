-- auto-generated definition
create table jobs
(
  id           serial       not null,
  guid         varchar(128) not null
    constraint jobs_pk
    primary key,
  profile      varchar(128) not null,
  created_date timestamp default CURRENT_DATE,
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


