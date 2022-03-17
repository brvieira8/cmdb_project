
create database cmdb;

create user if not exists "admin"@"%" identified BY "admin";
create user if not exists "admin"@"localhost" identified BY "admin";

grant all on cmdb.* to "admin"@"%";
grant all on cmdb.* to "admin"@"localhost";


use cmdb;


--Tabela resource units;
drop table if exists simple_information;
create table if not exists simple_information(
    hw_hostname varchar(50) DEFAULT NULL,
    origin_scope varchar(50) DEFAULT NULL,
    cross_image_service varchar(50) DEFAULT NULL,
    site_location varchar(50) DEFAULT NULL,
    hw_manufacturer varchar(50) DEFAULT NULL,
    hw_type varchar(50) DEFAULT NULL,
    hw_serialnumber varchar(50) DEFAULT NULL,
    image_type varchar(50) DEFAULT NULL,
    platform varchar(50) DEFAULT NULL,
    os_name varchar(100) DEFAULT NULL,
    os_type varchar(50) DEFAULT NULL,
    os_version varchar(50) DEFAULT NULL,
    environment varchar(50) DEFAULT NULL,
    primary key(hw_hostname)
);


--Tabela resource units;
drop table if exists resource_units;
create table if not exists resource_units(
    hw_hostname varchar(50) DEFAULT NULL,
    cpu_resources varchar(50) DEFAULT NULL,
    memory_resources varchar(50) DEFAULT NULL,
    provisioned_storage varchar(50) DEFAULT NULL,
    foreign key (hw_hostname) REFERENCES simple_information(hw_hostname) on delete cascade
);

--Tabela para guardar o total de cada coluna da tabela resource_units
drop table if exists total_resource_units;
create table if not exists total_resource_units(
    CPU_Total decimal(50),
    RAM_Total decimal(50),
    Storage_Total decimal(50)
);


--Valores default da tabela total_resource_units
INSERT INTO `total_resource_units` (`CPU_Total`, `RAM_Total`, `Storage_Total`) VALUES ('4264', '53398152', '10293154500');
