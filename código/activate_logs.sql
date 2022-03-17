
--**********************************************************************************************************************************--
--********************LOGS**********************LOGS************************LOGS*************************LOGS***********************--
--**********************************************************************************************************************************--

--Comando para ativar as logs--
--ATENÇÃO:USAR EM CADA UTILIZADOR--

--Ativa o registo de logs no utilizador atual DEFAULT:0--
SET GLOBAL general_log=1;
--Muda a forma como são registadas as logs DEFAULT:FILE--
SET GLOBAL log_output='TABLE';

--Consultar as logs--


--Modo Compacto, RECOMENDADO--
SELECT * FROM mysql.general_log\G 

--Modo linha-a-linha--
SELECT * FROM mysql.general_log; 

--Comandos para limpar as log_files
SET GLOBAL general_log=OFF;
TRUNCATE table mysql.general_log;
SET GLOBAL general_log=ON;

--Stored procedure criada para limpar as logs de forma mais prática
call clear_logs;