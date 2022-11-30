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

DROP PROCEDURE IF EXISTS `GET_ACTIVITY_SPHERE_ID_BY_NAME`;

DELIMITER //

CREATE PROCEDURE `GET_ACTIVITY_SPHERE_ID_BY_NAME`(IN 
`SPHERE_NAME` VARCHAR(32), OUT `SPHERE_ID` INT UNSIGNED
) BEGIN 
	SET @SPHERE_ID := (
	        SELECT `ID`
	        FROM
	            `ACTIVITY_SPHERE`
	        WHERE
	            name = @SPHERE_NAME
	    );
	END // 


DELIMITER ;

DROP PROCEDURE IF EXISTS `CREATE_ACTIVITY_SPHERE`;

DELIMITER //

CREATE PROCEDURE `CREATE_ACTIVITY_SPHERE`(IN `SPHERE_NAME` 
VARCHAR(32)) BEGIN 
	INSERT INTO `ACTIVITY_SPHERE`(`NAME`) VALUES (@SPHERE_NAME);
	END // 


DELIMITER ;

DROP PROCEDURE IF EXISTS `GET_OR_CREATE_ACTIVITY_SPHERE`;

DELIMITER //

CREATE PROCEDURE `GET_OR_CREATE_ACTIVITY_SPHERE`(IN 
`SPHERE_NAME` VARCHAR(32), OUT `SPHERE_ID` INT UNSIGNED
) BEGIN 
	SET @SPHERE_ID = -1;
	CALL GET_ACTIVITY_SPHERE_ID_BY_NAME(@SPHERE_NAME, @SPHERE_ID);
	IF (@SPHERE_ID = -1) THEN
	CALL
	    CREATE_ACTIVITY_SPHERE(@SPHERE_NAME);
	CALL GET_ACTIVITY_SPHERE_ID_BY_NAME(@SPHERE_NAME, @SPHERE_ID);
	END IF;
	END// 


DELIMITER ;

DROP PROCEDURE IF EXISTS `GET_ROOM_ID_BY_TASK_ID`;

DELIMITER //

CREATE PROCEDURE `GET_ROOM_ID_BY_TASK_ID`(IN `TASK_ID` 
INT UNSIGNED, OUT `ROOM_ID` INT UNSIGNED) BEGIN 
	SET @ROOM_ID := (
	        SELECT `ROOM_ID`
	        from `TASKS`
	        where
	            `TASK_ID` = @TASK_ID
	    );
	END// 


DELIMITER ;