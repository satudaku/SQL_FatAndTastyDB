-- A script to list all constraints for a given table
-- Comment out the last WHERE clause to list all constraints for the whole database
SELECT        tbc.CONSTRAINT_NAME, tbc.CONSTRAINT_TYPE, tbc.TABLE_NAME, CASE WHEN ck.CHECK_CLAUSE IS NULL 
                         THEN '' ELSE ck.CHECK_CLAUSE END AS 'SEARCH_CONDITION', CASE WHEN rc.UPDATE_RULE IS NULL 
                         THEN '' ELSE rc.UPDATE_RULE END AS 'UPDATE_RULE', CASE WHEN rc.DELETE_RULE IS NULL THEN '' ELSE rc.DELETE_RULE END AS 'DELETE_RULE', 
                         CASE WHEN OBJECTPROPERTY(sso.id, 'CNSTISDISABLED') = '0' THEN 'ENABLED' ELSE 'DISABLED' END AS STATUS
FROM            INFORMATION_SCHEMA.CHECK_CONSTRAINTS AS ck RIGHT OUTER JOIN
                         INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS rc RIGHT OUTER JOIN
                         sys.sysobjects AS sso INNER JOIN
                         INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tbc ON sso.name = tbc.CONSTRAINT_NAME ON rc.CONSTRAINT_NAME = tbc.CONSTRAINT_NAME ON 
                         ck.CONSTRAINT_NAME = tbc.CONSTRAINT_NAME
--WHERE        (tbc.TABLE_NAME = @tablename)
ORDER BY tbc.CONSTRAINT_NAME