ECHO ON
set datetime_stamp=%Date% %Time% 
set date_stamp=%Date:~4,2%.%Date:~7,2%.%Date:~10,4%
echo %datetime_stamp%
echo %datetime_stamp% > C:\HDFS_Stage\data\mt_hdfs_etl_end_ok.%date_stamp%.log