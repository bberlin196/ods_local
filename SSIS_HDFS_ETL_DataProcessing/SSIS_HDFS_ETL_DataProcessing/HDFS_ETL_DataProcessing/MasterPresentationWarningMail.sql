DECLARE @RC int
EXECUTE @RC = [dbo].[RM_SendMail] 
@Recipients = 'bberlin@mediatemple.net;' ,
@wsubject = 'RM SSIS HDFS ETL [Warning] SSIS PROD Master Presentation ETL seems to be delayed',
@wmessage = 'SSIS PROD Master Presentation ETL is delaying RM SSIS HDFS ETL node',
@importance_in = 'NORMAL'