ECHO ON
set datetime_stamp=%Date% %Time% 
set date_stamp=%Date:~4,2%.%Date:~7,2%.%Date:~10,4%
echo START: %datetime_stamp% 

del /Q c:\HDFS_Stage\data\*.*
echo ==================================================

del /Q c:\HDFS_Stage\archive\*.*
echo ==================================================

del /Q c:\HDFS_Stage\log\*.*
echo ==================================================

set datetime_stamp=%Date% %Time% 
set date_stamp=%Date:~4,2%.%Date:~7,2%.%Date:~10,4%
echo END: %datetime_stamp% 

