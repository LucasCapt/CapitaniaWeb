alter table tadtv
drop constraint PK_TADTV;

alter table tadtv
drop column id;

alter table tadtv
add [ID] [bigint] NOT NULL;

alter table TFACTORHIST
drop constraint PK_TFACTORHIST;

alter table TFACTORHIST
drop column ID ;

alter table TFACTORHIST
add ID [bigint] NOT NULL;

alter table tpapel
drop constraint PK_tpapel;

alter table tpapel
drop column idpapel;

alter table tpapel
add [IDPapel] [bigint] NOT NULL;

alter table tposic
drop column id;

alter table tposic
add [ID] [bigint] NOT NULL;

alter table tposiclayout2
drop column id;

alter table tposiclayout2
add [ID] [bigint] NOT NULL;

alter table TPricing
drop constraint PK_TPricing;

alter table TPricing
drop column id;

alter table TPricing
add [ID] [bigint] NOT NULL;

alter table TProvFilter
drop column id;

alter table TProvFilter
add [ID] [bigint] NOT NULL;

alter table TResgates
drop constraint PK_TResgates;

alter table TResgates
drop column id;

alter table TResgates
add [ID] [bigint] NOT NULL;

alter table TTrades
drop constraint PK_TTrades;

alter table TTrades
drop column id;

alter table TTrades
add [ID] [bigint] NOT NULL;


