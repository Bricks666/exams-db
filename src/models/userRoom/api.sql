CREATE PROCEDURE `GET_USERS_IN_ROOM`(IN `ROOM_ID` INT
UNSIGNED) BEGIN
	SELECT
	    `USERS`.`ID`,
	    `USERS`.`LOGIN`,
	    `USERS`.`PHOTO`
	FROM `USER_ROOM`
	    JOIN `USERS` ON `USERS`.`ID` = `USER_ROOM`.`USER_ID`
	WHERE
	    `USER_ROOM`.`ROOM_ID` = `ROOM_ID`
	    AND `USER_ROOM`.`DELETED` = FALSE;
END;

CREATE PROCEDURE `ADD_USER_ROOM`(IN `USER_ID` INT UNSIGNED
, IN `ROOM_ID` INT UNSIGNED) BEGIN
	IF(
	    EXISTS(
	        SELECT
	            `USER_ROOM`.`USER_ID`
	        FROM `USER_ROOM`
	        WHERE
	            `USER_ROOM`.`USER_ID` = `USER_ID`
	            AND `USER_ROOM`.`ROOM_ID` = `ROOM_ID`
	            AND `USER_ROOM`.`DELETED` = TRUE
	    )
	) THEN
	UPDATE `USER_ROOM`
	SET
	    `USER_ROOM`.`DELETED` = FALSE
	WHERE
	    `USER_ROOM`.`USER_ID` = `USER_ID`
	    AND `USER_ROOM`.`ROOM_ID` = `ROOM_ID`;
	ELSE
	INSERT INTO
	    `USER_ROOM`(`ROOM_ID`, `USER_ID`)
	VALUES (`ROOM_ID`, `USER_ID`);
	END IF;
END;

CREATE PROCEDURE `REMOVE_USER_ROOM`(IN `USER_ID` INT
UNSIGNED, IN `ROOM_ID` INT UNSIGNED) BEGIN
	UPDATE `USER_ROOM`
	SET `DELETED` = TRUE
	WHERE
	    `USER_ROOM`.`USER_ID` = `USER_ID`
	    AND `USER_ROOM`.`ROOM_ID` = `ROOM_ID`;
END;
