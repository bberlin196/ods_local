SELECT TOP 1
       [ID]
      ,[SOURCE]
      ,[SENDER]
      ,[TYPE]
      ,[STATUS]
      ,[DEPENDENCY]
      ,[MESSAGE]
      ,[SUBJECT]
      ,[EVENT_TIME]
      ,[REC_TIME_STAMP]
  FROM [HostOps].[dbo].[DwEtlLog]
  where 
  SENDER = 'DoMasterPresentation'
  and convert(date,[REC_TIME_STAMP]) = convert(date,GETDATE())
  and STATUS = 'I'
  order by [REC_TIME_STAMP] desc

