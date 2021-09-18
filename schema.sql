-- A script to create a table schema
-- Comment out the WHERE clause to show the schema for the whole database
SELECT        C.TABLE_NAME AS 'Table Name', C.COLUMN_NAME AS 'Column Name', 
                         CASE WHEN C.CHARACTER_MAXIMUM_LENGTH IS NULL 
                         THEN C.DATA_TYPE ELSE C.DATA_TYPE + ' (' + CAST(C.CHARACTER_MAXIMUM_LENGTH AS varchar) + ')' END AS 'Data Type', 
                         CASE WHEN C.IS_NULLABLE = 'NO' THEN 'NOT NULL' ELSE '' END AS 'Null?', 
                         CASE WHEN T .CONSTRAINT_TYPE = 'PRIMARY KEY' THEN 'PK' ELSE '' END AS PK, 
                         CASE WHEN T .CONSTRAINT_TYPE = 'FOREIGN KEY' THEN 'FK' ELSE '' END AS FK, 
                         CASE WHEN T .CONSTRAINT_TYPE = 'FOREIGN KEY' THEN Ref.REF_TABLE_NAME + '.' + Ref.REF_COLUMN_NAME ELSE '' END AS 'PK Reference'
FROM            INFORMATION_SCHEMA.COLUMNS AS C LEFT OUTER JOIN
                             (SELECT        SObject3.name AS FK_NAME, SObject2.name AS REF_TABLE_NAME, SColumns2.name AS REF_COLUMN_NAME
                               FROM            sysforeignkeys AS SYSFK INNER JOIN
                                                             (SELECT        uid, id, name
                                                               FROM            sysobjects
                                                               WHERE        (xtype = 'U')) AS SObject ON SYSFK.fkeyid = SObject.id INNER JOIN
                                                             (SELECT        uid, id, name
                                                               FROM            sysobjects AS sysobjects_2
                                                               WHERE        (xtype = 'U')) AS SObject2 ON SYSFK.rkeyid = SObject2.id INNER JOIN
                                                             (SELECT        id, colid, name
                                                               FROM            syscolumns) AS SColumns ON SYSFK.fkeyid = SColumns.id AND SYSFK.fkey = SColumns.colid INNER JOIN
                                                             (SELECT        id, colid, name
                                                               FROM            syscolumns AS syscolumns_1) AS SColumns2 ON SYSFK.rkeyid = SColumns2.id AND 
                                                         SYSFK.rkey = SColumns2.colid INNER JOIN
                                                             (SELECT        id, name
                                                               FROM            sysobjects AS sysobjects_1) AS SObject3 ON SYSFK.constid = SObject3.id INNER JOIN
                                                         sysusers AS SUser ON SObject.uid = SUser.uid INNER JOIN
                                                         sysusers AS SUser2 ON SObject2.uid = SUser2.uid) AS Ref RIGHT OUTER JOIN
                         INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS T INNER JOIN
                         INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS K ON T.CONSTRAINT_NAME = K.CONSTRAINT_NAME ON Ref.FK_NAME = K.CONSTRAINT_NAME ON 
                         C.TABLE_NAME = K.TABLE_NAME AND C.COLUMN_NAME = K.COLUMN_NAME
--WHERE        (C.TABLE_NAME <> 'sysdiagrams')
ORDER BY 'Table Name'