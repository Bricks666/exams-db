-- Active: 1669709918752@@127.0.0.1@3306@tasks_manager

USE `TASKS_MANAGER`;

DROP PROCEDURE If EXISTS `CREATE_ACTIVITY`;

DELIMITER //

CREATE PROCEDURE `CREATE_ACTIVITY`(IN `ROOM_ID` INT 
UNSIGNED, IN `ACTIVIST_ID` INT UNSIGNED, IN `SPHERE_ID` 
INT UNSIGNED, IN `ACTION` ENUM('CREATE', 'UPDATE', 
'REMOVE')) BEGIN 
	INSERT INTO
	    `ACTIVITIES`(
	        `ROOM_ID`,
	        `ACTIVIST_ID`,
	        `SPHERE_ID`,
	        `ACTION`
	    )
	VALUES (
	        `ROOM_ID`,
	        `ACTIVIST_ID`,
	        `SPHERE_ID`,
	        `ACTION`
	    );
	END // 


DELIMITER ;

DROP PROCEDURE IF EXISTS `GET_OR_CREATE_ACTIVITY_SPHERE`;

DELIMITER //

CREATE PROCEDURE `GET_OR_CREATE_ACTIVITY_SPHERE`(IN 
`SPHERE_NAME` VARCHAR(32), OUT `SPHERE_ID` INT UNSIGNED
) BEGIN 
	IF (
	    not exists(
	        SELECT `ID`
	        FROM
	            `ACTIVITY_SPHERE`
	        WHERE
	            `NAME` = `SPHERE_NAME`
	    )
	) THEN
	INSERT INTO
	    `ACTIVITY_SPHERE`(`NAME`)
	VALUES (`SPHERE_NAME`);
	END IF;
	SELECT `ID` INTO `SPHERE_ID`
	FROM `ACTIVITY_SPHERE`
	WHERE `NAME` = `SPHERE_NAME`;
	END // 


DELIMITER ;

DROP PROCEDURE IF EXISTS `GET_ROOM_ID_BY_TASK_ID`;

DELIMITER //

CREATE PROCEDURE `GET_ROOM_ID_BY_TASK_ID`(IN `TASK_ID` 
INT UNSIGNED, OUT `ROOM_ID_OUT` INT UNSIGNED) BEGIN 
	SELECT
	    `ROOM_ID` INTO `ROOM_ID_OUT`
	FROM `TASKS`
	WHERE `ID` = `TASK_ID`;
	END// 


DELIMITER ;