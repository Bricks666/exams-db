CREATE DATABASE IF NOT EXISTS `TASKS_MANAGER`;

USE `TASKS_MANAGER`;

CREATE TABLE
    IF NOT EXISTS `TASKS`(
        `ID` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `ROOM_ID` INT UNSIGNED NOT NULL,
        `GROUP_ID` INT UNSIGNED NOT NULL,
        `AUTHOR_ID` INT UNSIGNED NOT NULL,
        `CONTENT` VARCHAR(255) NOT NULL,
        `STATUS` ENUM(
            'READY',
            'IN PROGRESS',
            'NEED REVIEW',
            'DONE'
        ) NOT NULL DEFAULT 'READY',
        `CREATED_AT` DATETIME NOT NULL DEFAULT NOW(),
        FOREIGN KEY (`ROOM_ID`, `GROUP_ID`) REFERENCES `GROUPS`(`ROOM_ID`, `ID`) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (`ROOM_ID`, `AUTHOR_ID`) REFERENCES `USER_ROOM`(`ROOM_ID`, `USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
    );
