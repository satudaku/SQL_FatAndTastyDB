/*
Name of script: Query
Author: Sato Daiki	
Date written: 31/08/2015
Purpose: Creates various queries
*/

--QUERY 1 - Store Shifts

SELECT	StoreName,
		(SELECT StaffFirstName + ' ' + StaffLastName
		 FROM	staff
		 WHERE	ManagerID = StaffID) AS 'Manager',
		ShiftDate,
		ShiftStartTime,
		ShiftEndTime,
		StaffFirstName + ' ' + StaffLastName AS 'Staff'
FROM	staff as s LEFT OUTER JOIN shift AS c
		ON s.StaffID = c.StaffID
		LEFT OUTER JOIN store AS z
		ON c.StoreID = z.StoreID
ORDER	BY 1, 3, 4
;


--QUERY 2 - Store Suppliers

SELECT	DISTINCT(StoreName),
		(SELECT StaffFirstName + ' ' + StaffLastName
		 FROM	staff
		 WHERE	ManagerID = StaffID) AS 'Manager',
		SupplierName,
		SupplierCPName,
		SupplierCPPhone
FROM	store AS z LEFT OUTER JOIN store_supplier AS y
		ON z.StoreID = y.StoreID
		INNER JOIN Supplier AS x
		ON y.SupplierID = x.SupplierID
;


--QUERY 3 - Non-mentoring staff

SELECT	UPPER(StaffLastName) + ', ' + StaffFirstName + ' does not mentor other staff' AS 'Staff without mentor'
FROM	staff
Where	Mentor IS NULL
ORDER	BY StaffLastName, StaffFirstName
;


--QUERY 4 - Shift Statistics

/*
SELECT	(SELECT StoreName
		 FROM	store),
		(SELECT	COUNT(ShiftID)
		 FROM	store AS z LEFT OUTER JOIN shift AS x
				ON z.StoreID = x.StoreID
		 WHERE	ShiftDate < GETDATE()
		 GROUP	BY StoreName) AS 'Shift Worked',
		(SELECT SUM(DATEDIFF(HH, ShiftStartTime, ShiftEndTime))
		 FROM	store AS z LEFT OUTER JOIN shift AS x
				ON z.StoreID = x.StoreID
		 WHERE	ShiftDate < GETDATE()
		 GROUP	BY StoreName) AS 'Hour Worked',
		(SELECT	COUNT(s.StaffID) 
		 FROM	staff AS s LEFT OUTER JOIN shift AS x
				ON s.StaffID = x.StaffID
				LEFT OUTER JOIN store AS z
				ON x.StoreID = z.StoreID
		 WHERE	ShiftDate BETWEEN '2015-08-01' AND '2015-08-31'
		 GROUP	BY StoreName) AS 'Employed in August'
FROM	store 
GROUP	BY StoreName
ORDER	BY 2;
*/

SELECT	StoreName, COUNT(ShiftID) AS 'Shift Worked',
		COUNT(s.StaffID) AS 'Employed in August'
FROM	store AS z FULL OUTER JOIN shift AS x
		ON z.StoreID = x.StoreID
		INNER JOIN staff AS s
		ON x.StaffID = s.StaffID
WHERE	ShiftDate BETWEEN '2015-08-01' AND '2015-08-31'
GROUP	BY StoreName
;



--QUERY 5 - Store Spend

SELECT	TOP 3 SUM(OrderPrice * OrderQuantity) AS 'Total',
		(SELECT StaffFirstName + ' ' + StaffLastName
		 FROM	staff
		 WHERE	ManagerID = StaffID) AS 'Manager',
		z.StoreName
FROM	store_supplier AS y INNER JOIN store AS z
		ON y.StoreID = z.StoreID
		INNER JOIN staff AS s
		ON z.ManagerID = s.StaffID
GROUP	BY z.StoreName, ManagerID
ORDER	BY 1
;