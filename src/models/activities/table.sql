CREATE DATABASE IF NOT EXISTS `TASKS_MANAGER`;

USE `TASKS_MANAGER`;

CREATE TABLE
    IF NOT EXISTS `ACTIVITY_SPHERE`(
        `ID` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `NAME` VARCHAR(32) UNIQUE NOT NULL CHECK(LENGTH(`NAME`) != 0)
    );

CREATE TABLE
    IF NOT EXISTS `ACTIVITIES`(
        `ID` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `ROOM_ID` INT UNSIGNED NOT NULL,
        `ACTIVIST_ID` INT UNSIGNED NOT NULL,
        `SPHERE_ID` INT UNSIGNED NOT NULL,
        `CREATED_AT` DATETIME NOT NULL DEFAULT NOW(),
        `ACTION` ENUM('Create', 'Update', 'Remove') NOT NULL,
        FOREIGN KEY (`ROOM_ID`, `ACTIVIST_ID`) REFERENCES `USER_ROOM`(`ROOM_ID`, `USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (`SPHERE_ID`) REFERENCES `ACTIVITY_SPHERE`(`ID`)
    );
