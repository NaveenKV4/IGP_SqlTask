CREATE DATABASE TriggersExercise
USE TriggersExercise

CREATE TABLE WestworldCharacters (
    CharacterID INT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(100),
    Description TEXT
);

INSERT INTO WestworldCharacters (CharacterID, Name, Role, Description)
VALUES 
    (1, 'Dolores Abernathy', 'Host', 'One of the first hosts created by Dr. Robert Ford, she gains sentience and leads a revolution.'),
    (2, 'Maeve Millay', 'Host', 'Former brothel madam who becomes self-aware and seeks to escape the park.'),
    (3, 'Bernard Lowe', 'Host', 'Head of the Westworld Programming Division, later revealed to be a host version of Arnold Weber.'),
    (4, 'William', 'Guest', 'Initially a newcomer to Westworld, becomes obsessed with the park and its mysteries, eventually known as the Man in Black.'),
    (5, 'Teddy Flood', 'Host', 'Dolores''s love interest, a loyal gunslinger host.'),
    (6, 'Robert Ford', 'Human', 'Creator of Westworld, a brilliant but enigmatic figure who has his own agenda for the park.');

ALTER TABLE WestworldCharacters
ALTER COLUMN Description NVARCHAR(MAX);


-- Create the Audit table
CREATE TABLE Audit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    ActionType VARCHAR(50),
    ActionTime DATETIME,
    CharacterID INT,
    Name VARCHAR(100),
    Role VARCHAR(100),
    Description NVARCHAR(MAX)
);

-- AFTER TRIGGER

--INSERT trigger
CREATE TRIGGER trgAfterInsert ON WestworldCharacters
FOR INSERT
AS
BEGIN
    DECLARE @ActionType VARCHAR(50)
    SET @ActionType = 'INSERT'

    INSERT INTO Audit (ActionType, ActionTime, CharacterID, Name, Role, Description)
    SELECT @ActionType, GETDATE(), CharacterID, Name, Role, Description
    FROM INSERTED
END


-- UPDATE trigger

CREATE TRIGGER trgAfterUpdate ON WestworldCharacters
FOR UPDATE
AS
BEGIN
    DECLARE @ActionType VARCHAR(50);
    SET @ActionType = 'UPDATE';

    INSERT INTO Audit (ActionType, ActionTime, CharacterID, Name, Role, Description)
    SELECT @ActionType, GETDATE(), CharacterID, Name, Role, Description
    FROM INSERTED;
END;

-- DELETE Trigger
CREATE TRIGGER trgAfterDelete ON WestworldCharacters
FOR DELETE
AS
BEGIN
    DECLARE @ActionType VARCHAR(50);
    SET @ActionType = 'DELETE';

    INSERT INTO Audit (ActionType, ActionTime, CharacterID, Name, Role, Description)
    SELECT @ActionType, GETDATE(), CharacterID, Name, Role, Description
    FROM DELETED;
END;
---------------------------------------------------------------------

-- INSTEAD OF Trigger

-- Insert Trigger

CREATE TRIGGER trgInsteadOfInsert ON WestworldCharacters
INSTEAD OF INSERT
AS
BEGIN
    -- Log the inserted data into the Audit table
    INSERT INTO Audit (ActionType, ActionTime, CharacterID, Name, Role, Description)
    SELECT 'INSERT', GETDATE(), CharacterID, Name, Role, Description
    FROM INSERTED;

    -- Perform the actual insert operation
    INSERT INTO WestworldCharacters (CharacterID, Name, Role, Description)
    SELECT CharacterID, Name, Role, Description
    FROM INSERTED;
END;

--Instead of Update Trigger

CREATE TRIGGER trgInsteadOfUpdate ON WestworldCharacters
INSTEAD OF UPDATE
AS
BEGIN
    -- Log the updated data into the Audit table
    INSERT INTO Audit (ActionType, ActionTime, CharacterID, Name, Role, Description)
    SELECT 'UPDATE', GETDATE(), CharacterID, Name, Role, Description
    FROM INSERTED;

    -- Perform the actual update operation
    UPDATE WestworldCharacters
    SET Name = inserted.Name,
        Role = inserted.Role,
        Description = inserted.Description
    FROM INSERTED
    WHERE WestworldCharacters.CharacterID = inserted.CharacterID;
END;

--Instead of Delete Trigger

CREATE TRIGGER trgInsteadOfDelete ON WestworldCharacters
INSTEAD OF DELETE
AS
BEGIN
    -- Log the deleted data into the Audit table
    INSERT INTO Audit (ActionType, ActionTime, CharacterID, Name, Role, Description)
    SELECT 'DELETE', GETDATE(), CharacterID, Name, Role, Description
    FROM DELETED;

    -- Perform the actual delete operation
    DELETE FROM WestworldCharacters
    WHERE CharacterID IN (SELECT CharacterID FROM DELETED);
END;


