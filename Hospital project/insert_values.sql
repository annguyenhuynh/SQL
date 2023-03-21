INSERT INTO hospital.affiliate_with (physician,department,primaryaffiliation)
VALUES 
(1,1,1),
(2,1,1),
(3,1,0),
(3,2,1),
(4,1,1),
(5,1,10),
(6,2,1),
(7,1,0),
(7,2,1),
(8,1,1),
(9,3,1);

INSERT INTO hospital.procedure (code,name,cost)
VALUES
(1,'Reverse Rhinopodoplasty',1500.0),
(2,'Obtuse Pyloric Recombobulation',3750.0),
(3,'Folded Demiophtalmectomy',4500.0),
(4,'Complete Walletectomy',10000.0),
(5,'Obfuscated Dermogastrotomy',4899.0),
(6,'Reversible Pancreomyoplasty',5600.0),
(7,'Follicular Demiectomy',25.0);

INSERT INTO hospital.patient(ssn,name,address,phone,insuranceid,pcp)
VALUES 
(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1),
(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2),
(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2),
(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);

INSERT INTO hospital.nurse (employeeid,name, position,registered,ssn)
VALUES 
(101,'Carla Espinosa','Head Nurse',true,111111110),
(102,'Laverne Roberts','Nurse',true,222222220),
(103,'Paul Flowers','Nurse',false,333333330);

INSERT INTO hospital.appointment(appointmentid,patient,prepnurse,physician,startdate,enddate,examinationroom)
VALUES
(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A'),
(26548913,100000002,101,2,'2008-04-24 10:00','2008-04-24 11:00','B'),
(36549879,100000001,102,1,'2008-04-25 10:00','2008-04-25 11:00','A'),
(46846589,100000004,103,4,'2008-04-25 10:00','2008-04-25 11:00','B'),
(59871321,100000004,NULL,4,'2008-04-26 10:00','2008-04-26 11:00','C'),
(69879231,100000003,103,2,'2008-04-26 11:00','2008-04-26 12:00','C'),
(76983231,100000001,NULL,3,'2008-04-26 12:00','2008-04-26 13:00','C'),
(86213939,100000004,102,9,'2008-04-27 10:00','2008-04-21 11:00','A'),
(93216548,100000002,101,2,'2008-04-27 10:00','2008-04-27 11:00','B');

INSERT INTO hospital.medication(code,name,brand,description)
VALUES 
(1,'Procrastin-X','X','N/A'),
(2,'Thesisin','Foo Labs','N/A'),
(3,'Awakin','Bar Laboratories','N/A'),
(4,'Crescavitin','Baz Industries','N/A'),
(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

INSERT INTO hospital.prescribes (physician,patient,medication,date,appointment,dose)
VALUES 
(1,100000001,1,'2008-04-24 10:47',13216584,'5'),
(9,100000004,2,'2008-04-27 10:53',86213939,'10'),
(9,100000004,2,'2008-04-30 16:53',NULL,'5');

INSERT INTO hospital.block(floor,code)
VALUES 
(1,1),
(1,2),
(1,3),
(2,1),
(2,2),
(2,3),
(3,1),
(3,2),
(3,3),
(4,1),
(4,2),
(4,3);

INSERT INTO hospital.room(number,type,blockfloor, blockcode,unavailable)
VALUES
(101,'Single',1,1,'no'),
(102,'Single',1,1,'no'),
(103,'Single',1,1,'no'),
(111,'Single',1,2,'no'),
(112,'Single',1,2,'yes'),
(113,'Single',1,2,'no'),
(121,'Single',1,3,'no'),
(122,'Single',1,3,'no'),
(123,'Single',1,3,'no'),
(201,'Single',2,1,'yes'),
(202,'Single',2,1,'no'),
(203,'Single',2,1,'no'),
(211,'Single',2,2,'no'),
(212,'Single',2,2,'no'),
(213,'Single',2,2,'yes'),
(221,'Single',2,3,'no'),
(222,'Single',2,3,'no'),
(223,'Single',2,3,'no'),
(301,'Single',3,1,'no'),
(302,'Single',3,1,'yes'),
(303,'Single',3,1,'no'),
(311,'Single',3,2,'no'),
(312,'Single',3,2,'no'),
(313,'Single',3,2,'no'),
(321,'Single',3,3,'yes'),
(322,'Single',3,3,'no'),
(323,'Single',3,3,'no'),
(401,'Single',4,1,'no'),
(402,'Single',4,1,'yes'),
(403,'Single',4,1,'no'),
(411,'Single',4,2,'no'),
(412,'Single',4,2,'no'),
(413,'Single',4,2,'no'),
(421,'Single',4,3,'yes'),
(422,'Single',4,3,'no'),
(423,'Single',4,3,'no');

INSERT INTO hospital.on_call(nurse,blockfloor,blockcode,startdate,enddate)
VALUES
(101,1,1,'2008-11-04 11:00','2008-11-04 19:00'),
(101,1,2,'2008-11-04 11:00','2008-11-04 19:00'),
(102,1,3,'2008-11-04 11:00','2008-11-04 19:00'),
(103,1,1,'2008-11-04 19:00','2008-11-05 03:00'),
(103,1,2,'2008-11-04 19:00','2008-11-05 03:00'),
(103,1,3,'2008-11-04 19:00','2008-11-05 03:00');

INSERT INTO hospital.stay(stayid,patient,room,startdate,enddate)
VALUES
(3215,100000001,111,'2008-05-01','2008-05-04'),
(3216,100000003,123,'2008-05-03','2008-05-14'),
(3217,100000004,112,'2008-05-02','2008-05-03');

INSERT INTO hospital.undergoes(patient,procedure,stay,date,physician,assistingnurse)
VALUES 
(100000001,6,3215,'2008-05-02',3,101),
(100000001,2,3215,'2008-05-03',7,101),
(100000004,1,3217,'2008-05-07',3,102),
(100000004,5,3217,'2008-05-09',6,NULL),
(100000001,7,3217,'2008-05-10',7,101),
(100000004,4,3217,'2008-05-13',3,103);

INSERT INTO hospital.trained_in(physician,treatment,certificationdate,certificationexpires)
VALUES
(3,1,'2008-01-01','2008-12-31'),
(3,2,'2008-01-01','2008-12-31'),
(3,5,'2008-01-01','2008-12-31'),
(3,6,'2008-01-01','2008-12-31'),
(3,7,'2008-01-01','2008-12-31'),
(6,2,'2008-01-01','2008-12-31'),
(6,5,'2007-01-01','2007-12-31'),
(6,6,'2008-01-01','2008-12-31'),
(7,1,'2008-01-01','2008-12-31'),
(7,2,'2008-01-01','2008-12-31'),
(7,3,'2008-01-01','2008-12-31'),
(7,4,'2008-01-01','2008-12-31'),
(7,5,'2008-01-01','2008-12-31'),
(7,6,'2008-01-01','2008-12-31'),
(7,7,'2008-01-01','2008-12-31');

						


