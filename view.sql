/*
Name of script: View
Author: Sato Daiki	
Date written: 31/08/2015
Purpose: Creates view for availability and pay details
*/

CREATE	VIEW availability_details_view AS
SELECT	s.StaffLastName, s.StaffFirstName, m.StaffFirstName + ' ' + m.StaffLastName AS 'MentorName', 
		PayHourly, AvailableDay, StartTime
FROM	Pay AS p FULL OUTER JOIN staff AS s
		ON p.PayID = s.PayID
		LEFT OUTER JOIN staff AS m
		ON s.StaffID = m.Mentor
		LEFT OUTER JOIN availability AS a
		ON s.StaffID = a.StaffID
ORDER	BY 1, 2
;

CREATE	VIEW pay_details_view AS
SELECT	StaffLastName + ', ' + StaffFirstName AS 'FullName', 
		PayName, ShiftID, 
		ShiftDate,
		ShiftStartTime, 
		ShiftEndTime, 
		StoreName, 
		(DATEDIFF(HH, ShiftStartTime, ShiftEndTime)*Payhourly) AS 'Pay',
		((DATEDIFF(HH, ShiftStartTime, ShiftEndTime)*Payhourly)*PaySuper*0.01) AS 'Super'
FROM	Pay AS p FULL OUTER JOIN Staff AS s
		ON p.PayID = s.PayID
		LEFT OUTER JOIN shift AS c
		ON s.StaffID = c.StaffID
		LEFT OUTER JOIN store AS z
		ON c.StoreID = z.StoreID
;