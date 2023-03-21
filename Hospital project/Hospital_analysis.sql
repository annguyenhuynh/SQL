--1: Query to find nurses who haven't been registered
SELECT * 
FROM hospital.nurse
WHERE registered = 'false';

--2.From the following table, write a SQL query to identify the nurses in charge of each department. 
--Return nursename as “name”, Position as “Position”
SELECT 	
	name as "Name",
	position as "Position"
FROM hospital.nurse
WHERE position LIKE 'Head%';

--3.From the following tables, write a SQL query to identify the physicians who are the department heads. 
--Return Department name as “Department” and Physician name as “Physician”
SELECT 
	p.name as "Physician",
	d.name as "Department"
FROM hospital.physician as p
JOIN hospital.department as d
ON p.employeeid = d.head
ORDER BY 1,2;

--4. From the following table, write a SQL query to count the number of patients who scheduled an appointment with at least one physician. 
--Return count as "Number of patients taken at least one appointment"
SELECT 
	count(distinct patient) as "Number of patients taken at least one appointment"
FROM hospital.appointment;

--5. From the following table, write a SQL query to locate the floor and block where room number 212 is located. 
-- Return block floor as "Floor" and block code as "Block".
SELECT 
	blockfloor as "Floor",
	blockcode as "Block"
FROM hospital.room
WHERE number =212;

--6. From the following table, write a SQL query to count the number available rooms. 
-- Return count as "Number of available rooms"
SELECT 
	count(*) as "Number of available rooms"
FROM hospital.room
WHERE unavailable = 'false';

--7. From the following table, write a SQL query to count the number of unavailable rooms. 
--Return count as "Number of unavailable rooms"
SELECT 
	count(*) as "Number of unavailable rooms"
FROM hospital.room
WHERE unavailable = 'true';

--8. From the following tables, write a SQL query to identify the physician and the department with which he or she is affiliated. 
-- Return Physician name as "Physician", and department name as "Department".
SELECT 
	p.name as "Physician",
	d.name as "Department"
FROM hospital.affiliate_with as a
LEFT JOIN hospital.physician as p ON a.physician = p.employeeid
LEFT JOIN hospital.department as d ON a.department = d.departmentid
GROUP BY 1,2
ORDER BY 1;

--9. From the following tables, write a SQL query to find those physicians who have received special training. 
--Return Physician name as “Physician”, treatment procedure name as "Treatment".
SELECT
	p.name as "Physcian",
	pr.name as "Treatment" 
FROM hospital.trained_in as ti
JOIN hospital.physician as p ON ti.physician = p.employeeid
JOIN hospital.procedure as pr ON ti.treatment = pr.code
ORDER BY 1,2;

--10. From the following tables, write a SQL query to find those physicians who are yet to be affiliated.
--Return Physician name as "Physician", Position, and department as "Department"
SELECT 
	p.name as "Physician",
	p.position as "Position",
	d.name as "Department"
FROM hospital.affiliate_with as a
JOIN hospital.physician as p ON a.physician = p.employeeid
JOIN hospital.department as d ON a.department = d.departmentid
WHERE a.primaryaffiliation = 0
ORDER BY 1,2;

--11. From the following tables, write a SQL query to identify physicians who are not specialists. 
--Return Physician name as "Physician", position as "Designation". 
SELECT
	p.name as "Physician",
	p.position as "Designation"
FROM hospital.physician p 
LEFT JOIN hospital.trained_in tr 
ON p.employeeid = tr.physician 
WHERE tr.treatment IS NULL;

--12. From the following tables, write a SQL query to find the patients with their physicians by whom they received preliminary treatment. 
--Return Patient name as "Patient", address as "Address" and Physician name as "Physician". 
SELECT 
	pa.name as "Patient",
	pa.address as "Address",
	p.name as "Physician" 
FROM hospital.physician p 
JOIN hospital.patient pa 
ON p.employeeid = pa.pcp;

--13.From the following tables, write a SQL query to identify the patients and the number of physicians with whom they have scheduled appointments. 
--Return Patient name as "Patient", number of Physicians as "Appointment for No. of Physicians".
SELECT 
	pa.name as "Patient",
	count(ap.physician) as "Appointment for No. of Physicians"
FROM hospital.patient pa 
JOIN hospital.appointment as ap 
ON ap.patient = pa.ssn
GROUP BY 1;

--14. From the following tables, write a SQL query to count the number of unique patients who have been scheduled for examination room 'C'. 
--Return unique patients as "No. of patients got appointment for room C".
SELECT 
	count(DISTINCT patient) as "No. of patients got appointment for room C"
FROM hospital.appointment
WHERE examinationroom = 'C';

--15. From the following tables, write a SQL query to find the names of the patients and the room number where they need to be treated. 
--Return patient name as "Patient", examination room as "Room No.", and starting date time as Date "Date and Time of appointment".
SELECT 
	pa.name as "Patient"
	,ap.examinationroom as "Room.No"
	,ap.startdate as "Date of appointment"
FROM hospital.patient as pa 
JOIN hospital.appointment as ap 
ON ap.patient = pa.ssn
GROUP BY 1,2,3
ORDER BY 1;

--16. From the following tables, write a SQL query to identify the nurses and the room in which they will assist the physicians. 
--Return Nurse Name as "Name of the Nurse" and examination room as "Room No."
SELECT 
	n.name as "Nurse",
	ap.examinationroom as "Room.No"
FROM hospital.nurse n
JOIN hospital.appointment ap
ON n.employeeid = ap.prepnurse
GROUP BY 1,2
ORDER BY 1;

--17. From the following tables, write a SQL query to locate the patients who attended the appointment on the 25th of April.
--Return Name of the patient, Name of the Nurse assisting the physician, Physician Name as "Name of the physician",
--examination room as "Room No.", schedule date and approximate time to meet the physician. 
SELECT 
	pa.name as "Patient",
	n.name as "Nurse",
	p.name as "Physician",
	ap.examinationroom as "Room.No"
FROM 
	hospital.appointment as ap
JOIN
	hospital.nurse as n ON ap.prepnurse = n.employeeid
JOIN 
	hospital.physician as p ON ap.physician = p.employeeid
JOIN 
	hospital.patient as pa ON ap.patient = pa.ssn 
WHERE ap.startdate = '2008-04-25';

--18.From the following tables, write a SQL query to identify those patients and their physicians who do not require any nursing assistance. 
--Return Name of the patient as "Name of the patient", Name of the Physician as "Name of the physician" and examination room as "Room No.". 
SELECT 
	pa.name as "Patient",
	p.name as "Physician",
	ap.examinationroom as "Room.No"
FROM 
	hospital.appointment as ap
JOIN 
	hospital.physician as p ON ap.physician = p.employeeid
JOIN 
	hospital.patient as pa ON ap.patient = pa.ssn 
WHERE ap.prepnurse IS NULL;

--19. From the following tables, write a SQL query to locate the patients' treating physicians and medications. 
--Return Patient name as "Patient", Physician name as "Physician", Medication name as "Medication".
SELECT 
	pa.name as "Patient",
	p.name as "Physician",
	m.name as "Medication"
FROM 
	hospital.prescribes pr
JOIN 
	hospital.patient pa ON pr.patient = pa.ssn
JOIN 
	hospital.physician p ON pr.physician = p.employeeid
JOIN 
	hospital.medication as m ON pr.medication = m.code
GROUP BY 1,2,3;

--20. From the following table, write a SQL query to count the number of available rooms in each block. Sort the result-set on ID of the block. 
--Return ID of the block as "Block", count number of available rooms as "Number of available rooms".
SELECT 
	blockcode as "Block",
	count(*) as "Number of available rooms"
FROM hospital.room
WHERE unavailable = 'false'
GROUP BY 1
ORDER BY 1;

--21. From the following table, write a SQL query to count the number of available rooms in each floor. Sort the result-set on block floor. 
--Return floor ID as "Floor" and count the number of available rooms as "Number of available rooms".
SELECT 
	blockfloor as "Floor",
	count(*) as "Number of available rooms"
FROM hospital.room 
WHERE unavailable = 'false'
GROUP BY 1
ORDER BY 1;

--22.From the following table, write a SQL query to count the number of available rooms for each floor in each block. 
--Sort the result-set on floor ID, ID of the block. 
--Return the floor ID as "Floor", ID of the block as "Block", and number of available rooms as "Number of available rooms".
SELECT 
	blockcode as "Block",
	blockfloor as "Floor",
	count(*) as "Number of available rooms"
FROM hospital.room
WHERE unavailable = 'false'
GROUP BY 1,2
ORDER BY 1;

--23. From the following tables, write a SQL query to find the floor where the maximum number of rooms are available.
--Return floor ID as "Floor", count "Number of available rooms".
SELECT 
	blockfloor as "Floor",
	count(*) as "Number of available rooms"
FROM hospital.room
WHERE unavailable = 'false'
GROUP BY 1
ORDER BY count(*) DESC
LIMIT 1;

--24. From the following tables, write a SQL query to locate the floor with the minimum number of available rooms. 
--Return floor ID as "Floor", Number of available rooms.
SELECT 
	blockfloor as "Floor"
	,count(*) as "Number of available rooms"
FROM hospital.room
WHERE unavailable = 'false'
GROUP BY 1
HAVING count(*) = (SELECT MIN(rooms) as "highest_total"
				   FROM (
				   SELECT 
					   blockfloor,
					   count(*) as rooms 
					   from hospital.room
				   WHERE unavailable = 'false'
				   GROUP BY blockfloor)as t);

--25. Find the name of the patients, their block, floor, and room number where they admitted.
SELECT
	pa.name as "Patient",
	s.room as "Room",
	r.blockcode as "Block",
	r.blockfloor as "Floor"
FROM 
	hospital.patient as pa 
JOIN hospital.stay as s ON pa.ssn = s.patient
JOIN hospital.room as r ON s.room = r.number
GROUP BY 1,2,3,4
ORDER BY 1;

--26. From the following tables, write a SQL query to locate the nurses and the block where they are scheduled to attend the on-call patients.
--Return Nurse Name as "Nurse", Block code as "Block".
SELECT 
	n.name as "Nurse",
	oc.blockcode as "Block"
FROM 
	hospital.nurse n
JOIN 
	hospital.on_call oc ON n.employeeid = oc.nurse 
GROUP BY 1,2
ORDER BY 1;

-- 27. From the following tables, write a SQL query to get
--a) name of the patient,
--b) name of the physician who is treating him or her,
--c) name of the nurse who is attending him or her,
--d) which treatement is going on to the patient,
--e) the date of release,
--f) in which room the patient has admitted and which floor and block the room belongs to respectively.

SELECT 
	pa.name as "Patient",
	p.name as "Physician",
	n.name as "Nurse",
	pr.name as "Treatment",
	s.enddate as "Released Date",
	r.number as "Room",
	r.blockfloor as "Floor",
	r.blockcode as "Block"
FROM 
	hospital.patient as pa 
JOIN 
	hospital.undergoes u ON pa.ssn = u.patient 
JOIN 
	hospital.physician p ON u.physician = p.employeeid 
JOIN 
	hospital.nurse n ON u.assistingnurse = n.employeeid 
JOIN 
	hospital.procedure pr ON u.procedure = pr.code
JOIN 
	hospital.stay s ON pa.ssn = s.patient
JOIN 
	hospital.room r ON s.room = r.number
ORDER BY 1;

-- 28. From the following tables, write a SQL query to find all physicians who have performed a medical procedure but are NOT certified to do so. 
-- Return Physician name as "Physician"
SELECT 
	name as "Physician"
FROM
	hospital.physician 
WHERE employeeid IN (
	SELECT u.physician
	FROM hospital.undergoes u 
	LEFT JOIN hospital.trained_in ti ON u.procedure = ti.treatment
				AND u.physician = ti.physician
	WHERE ti.treatment is NULL)
	
-- 29. From the following tables, write a SQL query to find all physicians, their procedures, 
--the date when the procedure was performed, and the name of the patient on whom the procedure was performed, 
--but the physicians are not certified to perform that procedure. 
--Return Physician Name as "Physician", Procedure Name as "Procedure", date, and Patient. Name as "Patient". 
SELECT 
	p.name as "Physician",
	pr.name as "Procedure",
	u.date as "Date",
	pa.name as "Patient"
FROM 
	hospital.undergoes as u, 
	hospital.physician as p,
	hospital.patient as pa,
	hospital.procedure as pr 
WHERE 
	u.patient = pa.ssn
AND u.procedure = pr.code
AND u.physician = p.employeeid
AND NOT EXISTS (
	SELECT 
		ti.physician
	FROM hospital.trained_in ti
	WHERE ti.treatment = u.procedure 
	AND ti.physician = u.physician)
	
--30. From the following table, write a SQL query to find all physicians who completed a medical procedure with certification after the expiration date of their license. 
--Return Physician Name as "Physician", Position as "Position".
SELECT 
	p.name as "Physician",
	p.position as "Position"
FROM 
	hospital.physician p,
	hospital.undergoes u,
	hospital.trained_in ti
WHERE 
	u.physician = p.employeeid
AND ti.physician = p.employeeid
AND u.procedure = ti.treatment 
AND u.date > ti.certificationexpires
	
--31. From the following table, write a SQL query to find out, which nurses have been on call for room 122 in the past.
--Return name of the nurses. 
SELECT 
	n.name as "Nurse"
FROM 
	hospital.nurse n 
JOIN 
	hospital.on_call oc ON n.employeeid = oc.nurse 
JOIN 
	hospital.room r ON oc.blockcode = r.blockcode AND oc.blockfloor = r.blockfloor
WHERE r.number = 122;

--32. From the following table, write a SQL query to find all physicians who have completed medical procedures with certification after their certificates expired.
--Return Physician Name as "Physician", Position as" Position", Procedure Name as "Procedure",
--Date of Procedure as "Date of Procedure", Patient Name as "Patient", and expiry date of certification as "Expiry Date of Certificate
SELECT 
	p.name as "Physician",
	p.position as "Position",
	u.procedure as "Procedure",
	u.date as "Date of Procedure",
	pa.name as "Patient",
	ti.certificationexpires as "Expiry Date of Certificate"
	FROM 
	hospital.physician p,
	hospital.undergoes u,
	hospital.trained_in ti,
	hospital.patient pa
WHERE 
	u.physician = p.employeeid
AND ti.physician = p.employeeid
AND u.procedure = ti.treatment 
AND u.patient = pa.ssn
AND u.date > ti.certificationexpires

--33. From the following table, write a SQL query to determine which patients have been prescribed medication by their primary care physician. 
--Return Patient name as "Patient", and Physician Name as "Physician"
SELECT 
	pa.name as "Patient",
	p.name as "Physician"
FROM 
	hospital.patient pa 
JOIN 
	hospital.physician p ON pa.pcp = p.employeeid
JOIN 
	hospital.prescribes pb ON pa.pcp = pb.physician
GROUP BY 1,2
ORDER BY 1;

--34. From the following table, write a SQL query to find those patients who have undergone a procedure costing more than $5,000, 
--as well as the name of the physician who has provided primary care, should be identified.
--Return name of the patient as "Patient", name of the physician as "Primary Physician", 
--and cost for the procedure as "Procedure Cost"
SELECT 
	 pa.name as "Patient",
	 p.name as "Primary Physician",
	 pr.cost as "Procedure Cost" 
FROM 
	hospital.patient as pa 
JOIN 
	hospital.undergoes as u ON pa.ssn = u.patient 
JOIN 
	hospital.physician as p ON p.employeeid = u.physician 
JOIN 
	hospital.procedure as pr ON pr.code = u.procEdure 
WHERE pr.cost > 5000
GROUP BY 1,2,3
ORDER BY 1;

--35. Find those patients with at least two appointments in which the nurse who prepared the appointment was a registered nurse 
--and the physician who provided primary care should be identified.
--Return Patient name as "Patient", Physician name as "Primary Physician", and Nurse Name as "Nurse"
SELECT 
	pa.name as "Patient",
	p.name as "Physician",
	n.name as "Nurse"
FROM 
	hospital.patient pa 
JOIN 
	hospital.appointment ap ON pa.ssn = ap.patient 
JOIN 
	hospital.physician p ON p.employeeid = ap.physician 
JOIN 
	hospital.nurse n ON n.employeeid = ap.prepnurse 
WHERE ap.patient IN (SELECT
				   		ap.patient 
				   	FROM hospital.appointment ap
				   	GROUP BY ap.patient
				   	HAVING COUNT(*)>=2)
AND n.registered = 'true';

--36. Identify those patients whose primary care is provided by a physician who is not the head of any department. 
-- Return patient name as "Patient" and physician name as "Primary Care Physician"
SELECT 
	pa.name as "Patient",
	p.name as "Primary Care Physician"
FROM 
	hospital.patient pa, 
	hospital.physician p
WHERE 
	pa.pcp = p.employeeid
AND p.employeeid NOT IN (SELECT head
						FROM hospital.department)
