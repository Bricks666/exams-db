CREATE PROCEDURE `GET_ROOMS`(IN `USER_ID` INT UNSIGNED
) BEGIN
	SELECT
	    `ROOMS`.`ID`,
	    `ROOMS`.`NAME`,
	    `ROOMS`.`DESCRIPTION`, (
	        SELECT
	            COUNT(`GROUPS`.`ID`)
	        FROM `GROUPS`
	        WHERE
	            `GROUPS`.`ROOM_ID` = `ROOMS`.`ID`
	    ) as `GROUPS_COUNT`, (
	        SELECT
	            COUNT(
	                IF(
	                    `USER_ROOM`.`DELETED` = 1,
	                    NULL,
	                    `USER_ROOM`.`USER_ID`
	                )
	            )
	        FROM `USER_ROOM`
	        WHERE
	            `USER_ROOM`.`ROOM_ID` = `ROOMS`.`ID`
	    ) as `USERS_COUNT`, (
	        SELECT
	            COUNT(
	                IF(
	                    `TASKS`.`STATUS` != 'DONE',
	                    NULL,
	                    `TASKS`.`ID`
	                )
	            )
	        FROM `TASKS`
	        WHERE
	            `TASKS`.`ROOM_ID` = `ROOMS`.`ID`
	    ) as `DONE_TASKS_COUT`, (
	        SELECT
	            COUNT(`TASKS`.`ID`)
	        FROM `TASKS`
	        WHERE
	            `TASKS`.`ROOM_ID` = `ROOMS`.`ID`
	    ) as `TASKS_COUT`
	FROM `ROOMS`
	    JOIN `USER_ROOM` ON `USER_ROOM`.`ROOM_ID` = `ROOMS`.`ID` AND `USER_ROOM`.`USER_ID` = `USER_ID` AND `USER_ROOM`.`DELETED` = 0
	GROUP BY `ROOMS`.`ID`;
END;

CREATE PROCEDURE `GET_ROOM`(IN `ROOM_ID` INT UNSIGNED
) BEGIN
	SELECT
	    `ROOMS`.`ID`,
	    `ROOMS`.`NAME`,
	    `ROOMS`.`DESCRIPTION`, (
	        SELECT
	            COUNT(`GROUPS`.`ID`)
	        FROM `GROUPS`
	        WHERE
	            `GROUPS`.`ROOM_ID` = `ROOMS`.`ID`
	    ) as `GROUPS_COUNT`, (
	        SELECT
	            COUNT(
	                IF(
	                    `USER_ROOM`.`DELETED` = 1,
	                    NULL,
	                    `USER_ROOM`.`USER_ID`
	                )
	            )
	        FROM `USER_ROOM`
	        WHERE
	            `USER_ROOM`.`ROOM_ID` = `ROOMS`.`ID`
	    ) as `USERS_COUNT`, (
	        SELECT
	            COUNT(
	                IF(
	                    `TASKS`.`STATUS` != 'DONE',
	                    NULL,
	                    `TASKS`.`ID`
	                )
	            )
	        FROM `TASKS`
	        WHERE
	            `TASKS`.`ROOM_ID` = `ROOMS`.`ID`
	    ) as `DONE_TASKS_COUT`, (
	        SELECT
	            COUNT(`TASKS`.`ID`)
	        FROM `TASKS`
	        WHERE
	            `TASKS`.`ROOM_ID` = `ROOMS`.`ID`
	    ) as `TASKS_COUT`
	FROM `ROOMS`
	WHERE `ID` = `ROOM_ID`
	GROUP BY `ROOMS`.`ID`;
END;

CREATE PROCEDURE `ADD_ROOM`(IN `NAME` VARCHAR(32),
IN `DESCRIPTION` VARCHAR(255)) BEGIN
	INSERT INTO
	    `ROOMS`(`NAME`, `DESCRIPTION`)
	VALUES (`NAME`, `DESCRIPTION`);
END;

CREATE PROCEDURE `UPDATE_ROOM_NAME`(IN `ROOM_ID` INT
UNSIGNED, IN `NAME` VARCHAR(32)) BEGIN
	UPDATE `ROOMS` SET `NAME` = `NAME` WHERE `ROOM_ID` = `ROOM_ID`;
END;

CREATE PROCEDURE `UPDATE_ROOM_DESCRIPTION`(IN `ROOM_ID`
INT UNSIGNED, IN `DESCRIPTION` VARCHAR(32)) BEGIN
	UPDATE `ROOMS`
	SET
	    `DESCRIPTION` = `DESCRIPTION`
	WHERE `ROOM_ID` = `ROOM_ID`;
END;

CREATE PROCEDURE `REMOVE_ROOM`(IN `ROOM_ID` INT UNSIGNED
) BEGIN
	DELETE FROM `ROOMS` WHERE `ROOM_ID` = `ROOM_ID`;
END;
