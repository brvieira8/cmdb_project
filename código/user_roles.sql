
--**********************************************************************************************************************************--
--*****************USER_ROLES********************USER_ROLES********************USER_ROLES*****************USER_ROLES****************--
--**********************************************************************************************************************************--

--User admin--
--Este user tem todas as permissões para todas as bases de dados--

create user if not exists "admin"@"%" identified BY "admin";
create user if not exists "admin"@"localhost" identified BY "admin";

grant all on cmdb.* to "admin"@"%";
grant all on cmdb.* to "admin"@"localhost";

show grants for admin;

create user if not exists "user1"@"%" identified BY "123";
create user if not exists "user1"@"localhost" identified BY "123";

--**********************************************************************--
--Role admin--
--Esta role pode executar todos os comandos dentro da base de dados cmdb--


create role admin;
grant all on cmdb.* to admin;

--Dar role admin ao utilizador admin
grant admin to admin;

show grants;

drop role if exists admin


--***************************************************************--
--Role normal_user--
--Esta role apenas pode fazer selects e show´s para as procedures;--


create role normal_user;
grant select on cmdb.* to normal_user;
grant execute on cmdb.* to normal_user;

--Dar role normal_user ao utilizador user1
grant normal_user to user1;

show grants;

drop role if exists normal_user




--Teste--
create table teste(
    name2 varchar(10) not null
);