-- Dukuzemariya yvonne
-- 2301000382
show databases;
create database Personal_Health_assistant;
CREATE TABLE User_Profile (
    User_ID int PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Date_of_Birth DATE,
    Email VARCHAR(100) ,
    Phone_Number VARCHAR(15)
);

CREATE TABLE Health_Record (
    Record_ID int PRIMARY KEY,
    User_ID INT REFERENCES User_Profile(User_ID),
    Date DATE,
    Weight varchar(100),
    Height VARCHAR(50),
    Blood_Pressure VARCHAR(20),
    Notes TEXT
);

CREATE TABLE Medication_Management (
    Medication_ID INT PRIMARY KEY,
    User_ID INT REFERENCES User_Profile(User_ID),
    Medication_Name VARCHAR(100),
    Start_Date DATE,
    End_Date DATE
);
DROP TABLE Medication_Management;
-- CREATE
INSERT INTO User_Profile (First_Name, Last_Name, Date_of_Birth, Email, Phone_Number) 
VALUES ('John', 'Doe', '2000-01-01', 'john.doe@example.com', '0734567890');

-- READ
SELECT * FROM User_Profile;

-- UPDATE
UPDATE User_Profile SET Email = 'john.new@example.com' WHERE User_ID = 1;

-- DELETE
DELETE FROM User_Profile WHERE User_ID = 1;

-- COUNT
SELECT COUNT(*) FROM User_Profile;
-- CREATE
INSERT INTO Health_Record (User_ID, Date, Weight, Height, Blood_Pressure, Notes)
 VALUES (1, '2003-10-01', 70.5, 175, '120/80', 'Routine check-up');
 

-- READ
SELECT * FROM Health_Record;

-- UPDATE
UPDATE Health_Record SET Weight = 72 WHERE Record_ID = 1;

-- DELETE
DELETE FROM Health_Record WHERE Record_ID = 1;

-- AVERAGE Weight
SELECT AVG(Weight) FROM Health_Record WHERE User_ID = 1;

-- COUNT Records
SELECT COUNT(*) FROM Health_Record WHERE User_ID = 1;
-- CREATE
INSERT INTO Medication_Management (User_ID, Medication_Name,Start_Date, End_Date) 
VALUES (1, 'KAMALI KEZA','2025-01-05', '2025-01-25');

-- READ
SELECT * FROM Medication_Management;

-- UPDATE
UPDATE Medication_Management SET Medication_Name = 'KAMALI KEZA' WHERE Medication_ID = 1;

-- DELETE
DELETE FROM Medication_Management WHERE Medication_ID = 1;

-- COUNT Medications
SELECT COUNT(*) FROM Medication_Management WHERE User_ID = 1;

-- SUM of all Medication counts
SELECT SUM(COUNT(*)) FROM Medication_Management GROUP BY User_ID;
-- CREATE VIEW
CREATE VIEW UserHealthRecords AS
SELECT u.First_Name, u.Last_Name, hr.Date, hr.Weight, hr.Height
FROM User_Profile u
JOIN Health_Record hr ON u.User_ID = hr.User_ID;

CREATE VIEW UserMedications AS
SELECT u.First_Name, u.Last_Name, m.Medication_Name
FROM User_Profile u
JOIN Medication_Management m ON u.User_ID = m.User_ID;

-- 
CREATE PROCEDURE AddUser (
    p_First_Name VARCHAR(50),
    p_Last_Name VARCHAR(50),
    p_Date_of_Birth DATE,
    p_Email VARCHAR(50),
    p_Phone_Number VARCHAR(50)
) 
BEGIN
    INSERT INTO User_Profile (First_Name, Last_Name, Date_of_Birth, Email, Phone_Number) 
    VALUES (p_First_Name, p_Last_Name, p_Date_of_Birth, p_Email, p_Phone_Number)
END;

CREATE PROCEDURE UpdateUserEmail (
    p_User_ID INTEGER,
    p_New_Email VARCHAR
)
BEGIN
    UPDATE User_Profile SET Email = p_New_Email WHERE User_ID = p_User_ID;
END;

--  CREATE TRIGGERS
CREATE TRIGGER UserProfile_After_Insert
AFTER INSERT ON User_Profile
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Action, User_ID, Action_Date)
    VALUES ('Insert User',NEW.User_ID)
END;

CREATE TRIGGER HealthRecord_After_Insert
AFTER INSERT ON Health_Record
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Action, User_ID, Action_Date) 
    VALUES ('Insert Health Record',NEW.User_ID)
END;

CREATE TRIGGER MedicationManagement_After_Insert
AFTER INSERT ON Medication_Management
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Action, User_ID, Action_Date) 
    VALUES ('Insert Medication',NEW.User_ID)
END;

-- Create user
-- personal health assistant
CREATE USER health_user IDENTIFIED BY 'password123';
/* grant the permission to the user on the created database*/
grant all privileges on Personal_Health_assistant.*to 'health_user'@'123';
/* allow the permission
flush privileges;