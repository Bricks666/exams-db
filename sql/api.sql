-- Active: 1669709918752@@127.0.0.1@3306@tasks_manager

USE `TASKS_MANAGER`;

DROP PROCEDURE IF EXISTS `INSERT_USER`;

CREATE PROCEDURE `INSERT_USER`(IN `LOGIN` VARCHAR(32
), IN `PASSWORD` VARCHAR(255), IN `PHOTO` VARCHAR(
255)) BEGIN 
	INSERT INTO
	    `USERS`(`LOGIN`, `PASSWORD`, `PHOTO`)
	VALUES (`LOGIN`, `PASSWORD`, `PHOTO`);
END; 

DROP PROCEDURE IF EXISTS `INSERT_ROOM`;

CREATE PROCEDURE `INSERT_ROOM`(IN `NAME` VARCHAR(32
), IN `DESCRIPTION` VARCHAR(255)) BEGIN 
	INSERT INTO
	    `ROOMS`(`NAME`, `DESCRIPTION`)
	VALUES (`NAME`, `DESCRIPTION`);
END; 

DROP PROCEDURE IF EXISTS `INSERT_USER_ROOM` ;

CREATE PROCEDURE `INSERT_USER_ROOM`(IN `USER_ID` INT 
UNSIGNED, IN `ROOM_ID` INT UNSIGNED) BEGIN 
	INSERT INTO
	    `USER_ROOM`(`ROOM_ID`, `USER_ID`)
	VALUES (`ROOM_ID`, `USER_ID`);
END; 

DROP PROCEDURE IF EXISTS `INSERT_GROUP` ;

CREATE PROCEDURE `INSERT_GROUP`(IN `ROOM_ID` INT UNSIGNED
, IN `CREATOR_ID` INT UNSIGNED, IN `NAME` VARCHAR(
32), IN `MAIN_COLOR` VARCHAR(7), IN `SECONDARY_COLOR` 
VARCHAR(7)) BEGIN 
	SELECT `NAME`, `MAIN_COLOR`;
	INSERT INTO
	    `GROUPS`(
	        `ROOM_ID`,
	        `CREATOR_ID`,
	        `NAME`,
	        `MAIN_COLOR`,
	        `SECONDARY_COLOR`
	    )
	VALUES (
	        `ROOM_ID`,
	        `CREATOR_ID`,
	        `NAME`,
	        `MAIN_COLOR`,
	        `SECONDARY_COLOR`
	    );
END; 

DROP PROCEDURE IF EXISTS `INSERT_TASK` ;

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

DROP PROCEDURE IF EXISTS `INSERT_COMMENT` ;

CREATE PROCEDURE `INSERT_COMMENT`(IN `TASK_ID` INT 
UNSIGNED, IN `AUTHOR_ID` INT UNSIGNED, IN `CONTENT` 
VARCHAR(128)) BEGIN 
	INSERT INTO
	    `COMMENTS`(
	        `TASK_ID`,
	        `AUTHOR_ID`,
	        `CONTENT`
	    )
	VALUES (
	        `TASK_ID`,
	        `AUTHOR_ID`,
	        `CONTENT`
	    );
END; 