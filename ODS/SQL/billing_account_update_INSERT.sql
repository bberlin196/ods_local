/*select * from  `ods`.`billing_account_update`
truncate table `ods`.`billing_account_update`*/

INSERT INTO `ods`.`billing_account_update`
(`rec_num`,
`number`,
`state`,
`startdate`,
`enddate`,
`cancelreasons`,
`referredby`,
`cfname`,
`clname`,
`company`,
`cphone`,
`fphone`,
`email`,
`addr1`,
`addr2`,
`addr3`,
`addr4`,
`city`,
`statename`,
`zip`,
`country`,
`customerof`,
`update_state`,
`ods_update`,
`time_of_insert`)
VALUES
(NULL	,
10057   ,
1	,
CURDATE()	,
CURDATE()	,
0	,
'referredby',	
'cfname',	
'clname',	
'account_company57',	
'cphone',	
'fphone',	
'email',	
'addr1',	
'addr2',	
'addr3',	
'addr4',	
'city',	
'statename',	
'zip',	
'country',	
1	,
1,	
DEFAULT,	
CURDATE());
