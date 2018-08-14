DECLARE @RC int
EXECUTE @RC = [dbo].[RM_SendMail] 
@Recipients = 'bberlin@mediatemple.net;' ,
@wsubject = 'RM SSIS HDFS ETL [Failure] SSIS PROD Master Presentation ETL running Timeout',
@wmessage = 'SSIS PROD Master Presentation ETL is out of the running time range - RM SSIS HDFS ETL node is not done',
@importance_in = 'HIGH'