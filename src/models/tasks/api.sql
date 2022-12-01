CREATE PROCEDURE `INSERT_TASK`(IN `ROOM_ID` INT UNSIGNED
, IN `GROUP_ID`INT UNSIGNED, IN `AUTHOR_ID` INT UNSIGNED
, IN `CONTENT` VARCHAR(128), IN `STATUS` ENUM('READY'
, 'IN PROGRESS', 'NEED REVIEW', 'DONE')) BEGIN 
	INSERT INTO
	    `TASKS`(
	        `ROOM_ID`,
	        `GROUP_ID`,
	        `AUTHOR_ID`,
	        `CONTENT`,
	        `STATUS`
	    )
	VALUES (
	        `ROOM_ID`,
	        `GROUP_ID`,
	        `AUTHOR_ID`,
	        `CONTENT`,
	        `STATUS`
	    );
END; 