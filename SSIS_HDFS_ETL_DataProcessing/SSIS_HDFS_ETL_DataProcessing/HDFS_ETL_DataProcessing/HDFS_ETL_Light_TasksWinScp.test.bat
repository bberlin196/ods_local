ECHO ON
set datetime_stamp=%Date% %Time% 
set date_stamp=%Date:~4,2%.%Date:~7,2%.%Date:~10,4%
echo %datetime_stamp%
echo Timestamp: %datetime_stamp% > C:\HDFS_Stage\log\HDFS_HDFS_ETL_Light_TasksWinScp.log
echo ===================================== >> C:\HDFS_Stage\log\HDFS_HDFS_ETL_Light_TasksWinScp.log
"C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\DTExec.exe" /file C:\mtbi\HDFS_ETL\SSIS_HDFS_ETL_DataProcessing\SSIS_HDFS_ETL_DataProcessing\HDFS_ETL_DataProcessing\Notification.dtsx >> C:\HDFS_Stage\log\HDFS_HDFS_ETL_Light_TasksWinScp.log