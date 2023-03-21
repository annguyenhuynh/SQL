DROP TABLE IF EXISTS hospital.Physician;

CREATE TABLE hospital.Physician (
  EmployeeID INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Position TEXT NOT NULL,
  SSN INTEGER NOT NULL);
  
CREATE TABLE hospital.Department (
  DepartmentID INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Head INTEGER NOT NULL)
;

DROP TABLE hospital.Affiliate_With;

CREATE TABLE hospital.Affiliate_With(
  Physician INTEGER NOT NULL,
  Department INTEGER NOT NULL,
  PrimaryAffiliation INTEGER NOT NULL);
  
CREATE TABLE hospital.Procedure(
  Code INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Cost REAL NOT NULL);
  
CREATE TABLE hospital.Trained_In(
 Physician INTEGER NOT NULL,
  Treatment INTEGER NOT NULL,
  CertificationDate DATE NOT NULL,
  CertificationExpires DATE NOT NULL
);

CREATE TABLE hospital.Patient(
SSN INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Address TEXT NOT NULL,
  Phone TEXT NOT NULL,
  InsuranceID INTEGER NOT NULL,
  PCP INTEGER NOT NULL
);
	
CREATE TABLE hospital.Nurse (
  EmployeeID INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Position TEXT NOT NULL,
  Registered BOOLEAN NOT NULL,
  SSN INTEGER NOT NULL);
  
CREATE TABLE hospital.Appointment(
  AppointmentID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL,
  PrepNurse INTEGER,
  Physician INTEGER NOT NULL,
  Startdate DATE NOT NULL,
  Enddate DATE NOT NULL,
  ExaminationRoom TEXT NOT NULL);

CREATE TABLE hospital.Medication(
Code INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Brand TEXT NOT NULL,
  Description TEXT NOT NULL);
  
CREATE TABLE hospital.Prescribes (
  Physician INTEGER NOT NULL,
  Patient INTEGER NOT NULL,
  Medication INTEGER NOT NULL,
  Date DATE NOT NULL,
  Appointment INTEGER,
  Dose TEXT NOT NULL
);

CREATE TABLE hospital.Block(
 Floor INTEGER NOT NULL,
  Code INTEGER NOT NULL,
  PRIMARY KEY(Floor, Code));
  
CREATE TABLE hospital.Room(
  Number INTEGER PRIMARY KEY NOT NULL,
  Type TEXT NOT NULL,
  BlockFloor INTEGER NOT NULL,
  BlockCode INTEGER NOT NULL,
  Unavailable BOOLEAN NOT NULL
 );
  
CREATE TABLE hospital.On_Call(
  Nurse INTEGER NOT NULL,
  BlockFloor INTEGER NOT NULL,
  BlockCode INTEGER NOT NULL,
  Startdate TIMESTAMP NOT NULL,
  Enddate TIMESTAMP NOT NULL
 );
  
CREATE TABLE hospital.Stay(
  StayID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL,

  Room INTEGER NOT NULL,
    
  Startdate TIMESTAMP NOT NULL,
  Enddate TIMESTAMP NOT NULL);
  
CREATE TABLE hospital.Undergoes(
  Patient INTEGER NOT NULL,

  Procedure INTEGER NOT NULL,

  Stay INTEGER NOT NULL,
  
  Date TIMESTAMP NOT NULL,
  Physician INTEGER NOT NULL,
   
  AssistingNurse INTEGER
 );