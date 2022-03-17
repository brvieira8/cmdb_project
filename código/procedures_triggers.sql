
--**********************************************************************************************************************************--
--************STORED_PROCEDURE**************STORED_PROCEDURE****************STORED_PROCEDURE*************STORED_PROCEDURE***********--
--**********************************************************************************************************************************--


--********************************************************************************--
--Stored procedure para calcular o total de unit-resources por data center--

--Comando para chamar a procedure
call total_resource_data_center;

drop procedure total_resource_data_center;

DELIMITER //
  CREATE PROCEDURE total_resource_data_center ()
    begin
      SELECT Site_location, SUM(cpu_resources) as "CPU Total", SUM(memory_resources) as "RAM Total",SUM(provisioned_storage) as "Storage Total"
      FROM resource_units, simple_information
      WHERE resource_units.hw_hostname = simple_information.hw_hostname
      GROUP BY Site_location;
    end; //
DELIMITER ;

--********************************************************************************--
--    Stored procedure para calcular o total de unit-resources por environment     --

--Comando para chamar a procedure
call total_resource_environment;

drop procedure total_resource_environment;

DELIMITER //
  CREATE PROCEDURE total_resource_environment ()
    begin
      SELECT Environment, SUM(cpu_resources) as "CPU Total", SUM(memory_resources) as "RAM Total",SUM(provisioned_storage) as "Storage Total"
      FROM resource_units, simple_information
      WHERE resource_units.hw_hostname = simple_information.hw_hostname
      GROUP BY Environment;
    end; //
DELIMITER ;


--********************************************************************************--
--    Stored procedure para calcular o total de unit-resources por environment    --

--Comando para chamar a procedure
call total_resource_os;

drop procedure total_resource_os;

DELIMITER //
  CREATE PROCEDURE total_resource_os ()
    begin
      SELECT os_type, SUM(cpu_resources) as "CPU Total", SUM(memory_resources) as "RAM Total",SUM(provisioned_storage) as "Storage Total"
      FROM resource_units, simple_information
      WHERE resource_units.hw_hostname = simple_information.hw_hostname
      GROUP BY os_type;
    end; //
DELIMITER ;

--*********************************************
--    Stored procedure para limpar as logs   --

--Comando para chamar a procedure
call clear_logs;

DELIMITER //
  CREATE PROCEDURE clear_logs ()
    begin
      SET GLOBAL general_log=OFF;
      TRUNCATE table mysql.general_log;
      SET GLOBAL general_log=ON;
    end; //
DELIMITER ;

--**********************************************************************************************************************************--
--************TRIGGERS**************TRIGGERS******************TRIGGERS********************TRIGGERS***************TRIGGERS***********--
--**********************************************************************************************************************************--


--**********************************************************************************************************************************--
--Trigger para atualizar os valores da tabela total_resource_units quando é adicionada uma nova linha--

drop trigger increment_total;

DELIMITER //
CREATE TRIGGER increment_total
AFTER INSERT ON resource_units
FOR EACH ROW
BEGIN
    UPDATE total_resource_units SET total_resource_units.CPU_Total = (total_resource_units.CPU_Total + new.cpu_resources);
    UPDATE total_resource_units SET total_resource_units.RAM_Total = total_resource_units.RAM_Total + new.memory_resources;
    UPDATE total_resource_units SET total_resource_units.Storage_Total = total_resource_units.Storage_Total + new.provisioned_storage;
END; //
DELIMITER ;


--**********************************************************************************************************************************--
--Trigger para atualizar os valores da tabela total_resource_units quando é removida uma linha--

drop trigger delete_total;

DELIMITER //
CREATE TRIGGER delete_total
AFTER DELETE ON resource_units
FOR EACH ROW
BEGIN
    UPDATE total_resource_units SET total_resource_units.CPU_Total = total_resource_units.CPU_Total - old.cpu_resources;
    UPDATE total_resource_units SET total_resource_units.RAM_Total = total_resource_units.RAM_Total - old.memory_resources;
    UPDATE total_resource_units SET total_resource_units.Storage_Total = total_resource_units.Storage_Total - old.provisioned_storage;
DELIMITER ;

--**********************************************************************************************************************************--
--Trigger para atualizar os valores da tabela total_resource_units quando é atualizada uma linha--

drop trigger update_total;

DELIMITER //
CREATE TRIGGER update_total
AFTER UPDATE ON resource_units
FOR EACH ROW
BEGIN
    UPDATE total_resource_units SET total_resource_units.CPU_Total = (total_resource_units.CPU_Total - old.cpu_resources + new.cpu_resources);
    UPDATE total_resource_units SET total_resource_units.RAM_Total = (total_resource_units.RAM_Total - old.memory_resources + new.memory_resources);
    UPDATE total_resource_units SET total_resource_units.Storage_Total = (total_resource_units.Storage_Total - old.provisioned_storage + new.provisioned_storage);
END; //
DELIMITER ;

