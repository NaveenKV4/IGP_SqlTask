Create database CursorExercise

Use CursorExercise


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


--------------------------------------------------------------------------------------------------------------------------------
--Forward Only Cursor

DECLARE character_cursor CURSOR FOR
SELECT CharacterID, Name, Role, Description
FROM WestworldCharacters;

-- Open the cursor
OPEN character_cursor;

-- Declare variables to hold data fetched from the cursor
DECLARE @CharacterID INT;
DECLARE @Name VARCHAR(100);
DECLARE @Role VARCHAR(100);
DECLARE @Description NVARCHAR(MAX); -- Changed data type to nvarchar(max)

-- Fetch the first row from the cursor into variables
FETCH NEXT FROM character_cursor INTO @CharacterID, @Name, @Role, @Description;

-- Loop through the result set while there are rows to fetch
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Process the fetched row (you can perform calculations, updates, etc. here)
    PRINT 'CharacterID: ' + CAST(@CharacterID AS VARCHAR(10)) + ', Name: ' + @Name + ', Role: ' + @Role + ', Description: ' + @Description;
    
    -- Fetch the next row from the cursor into variables
    FETCH NEXT FROM character_cursor INTO @CharacterID, @Name, @Role, @Description;
END

-- Close the cursor
CLOSE character_cursor;

-- Deallocate the cursor to release resources
DEALLOCATE character_cursor;
------------------------------------------------------------------------------------------
--Static Cursor

DECLARE character_cursor CURSOR STATIC
FOR
SELECT CharacterID, Name, Role, Description
FROM WestworldCharacters;

-- Open the cursor
OPEN character_cursor;

-- Declare variables to hold data fetched from the cursor
DECLARE @CharacterID INT;
DECLARE @Name VARCHAR(100);
DECLARE @Role VARCHAR(100);
DECLARE @Description NVARCHAR(MAX); -- Changed data type to nvarchar(max)

-- Fetch the first row from the cursor into variables
FETCH NEXT FROM character_cursor INTO @CharacterID, @Name, @Role, @Description;

-- Loop through the result set while there are rows to fetch
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Process the fetched row (you can perform calculations, updates, etc. here)
    PRINT 'CharacterID: ' + CAST(@CharacterID AS VARCHAR(10)) + ', Name: ' + @Name + ', Role: ' + @Role + ', Description: ' + @Description;
    
    -- Fetch the next row from the cursor into variables
    FETCH NEXT FROM character_cursor INTO @CharacterID, @Name, @Role, @Description;
END

-- Close the cursor
CLOSE character_cursor;

-- Deallocate the cursor to release resources
DEALLOCATE character_cursor;

-------------------------------------------------------------------
--DYNAMIC CURSOR

DECLARE character_cursor CURSOR DYNAMIC
FOR
SELECT CharacterID, Name, Role, Description
FROM WestworldCharacters;

-- Open the cursor
OPEN character_cursor;

-- Declare variables to hold data fetched from the cursor
DECLARE @CharacterID INT;
DECLARE @Name VARCHAR(100);
DECLARE @Role VARCHAR(100);
DECLARE @Description NVARCHAR(MAX); -- Changed data type to nvarchar(max)

-- Fetch the first row from the cursor into variables
FETCH NEXT FROM character_cursor INTO @CharacterID, @Name, @Role, @Description;

-- Loop through the result set while there are rows to fetch
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Process the fetched row (you can perform calculations, updates, etc. here)
    PRINT 'CharacterID: ' + CAST(@CharacterID AS VARCHAR(10)) + ', Name: ' + @Name + ', Role: ' + @Role + ', Description: ' + @Description;
    
    -- Fetch the next row from the cursor into variables
    FETCH NEXT FROM character_cursor INTO @CharacterID, @Name, @Role, @Description;
END

-- Close the cursor
CLOSE character_cursor;

-- Deallocate the cursor to release resources
DEALLOCATE character_cursor;

---------------------------------------------------------------
--KEY SET CURSOR


DECLARE character_cursor CURSOR KEYSET
FOR
SELECT CharacterID, Name, Role, Description
FROM WestworldCharacters;

-- Open the cursor
OPEN character_cursor;

-- Declare variables to hold data fetched from the cursor
DECLARE @CharacterID INT;
DECLARE @Name VARCHAR(100);
DECLARE @Role VARCHAR(100);
DECLARE @Description NVARCHAR(MAX); -- Changed data type to nvarchar(max)

-- Fetch the first row from the cursor into variables
FETCH NEXT FROM character_cursor INTO @CharacterID, @Name, @Role, @Description;

-- Loop through the result set while there are rows to fetch
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Process the fetched row (you can perform calculations, updates, etc. here)
    PRINT 'CharacterID: ' + CAST(@CharacterID AS VARCHAR(10)) + ', Name: ' + @Name + ', Role: ' + @Role + ', Description: ' + @Description;
    
    -- Fetch the next row from the cursor into variables
    FETCH NEXT FROM character_cursor INTO @CharacterID, @Name, @Role, @Description;
END

-- Close the cursor
CLOSE character_cursor;

-- Deallocate the cursor to release resources
DEALLOCATE character_cursor;

---------------------------------------------------------------