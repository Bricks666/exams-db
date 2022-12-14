CREATE DATABASE IF NOT EXISTS `TASKS_MANAGER`;

USE `TASKS_MANAGER`;

CREATE TABLE
    IF NOT EXISTS `GROUPS`(
        `ID` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `ROOM_ID` INT UNSIGNED NOT NULL,
        `CREATOR_ID` INT UNSIGNED NOT NULL,
        `NAME` VARCHAR(32) NOT NULL CHECK(LENGTH(`NAME`) >= 2),
        `MAIN_COLOR` VARCHAR(7) NOT NULL CHECK(
            `MAIN_COLOR` REGEXP "^#[0-9a-fA-F]{6}$"
        ),
        `SECONDARY_COLOR` VARCHAR(7) NOT NULL CHECK(
            `SECONDARY_COLOR` REGEXP "^#[0-9a-fA-F]{6}$"
        ),
        INDEX (`ROOM_ID`),
        FOREIGN KEY (`ROOM_ID`, `CREATOR_ID`) REFERENCES `USER_ROOM`(`ROOM_ID`, `USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
    );
