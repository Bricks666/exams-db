CREATE TRIGGER `CREATE_TASKS_ACTIVITY` AFTER INSERT 
ON `TASKS` FOR EACH ROW BEGIN 
	DECLARE SPHERE_ID INT UNSIGNED;
	CALL GET_OR_CREATE_ACTIVITY_SPHERE('TASK', @SPHERE_ID);
	CALL
	    Create_Activity(
	        NEW.`ROOM_ID`,
	        NEW.`AUTHOR_ID`,
	        @SPHERE_ID,
	        'Create'
	    );
END; 

CREATE TRIGGER `UPDATE_TASKS_ACTIVITY` AFTER UPDATE 
ON `TASKS` FOR EACH ROW BEGIN 
	DECLARE SPHERE_ID INT UNSIGNED;
	CALL GET_OR_CREATE_ACTIVITY_SPHERE('TASK', @SPHERE_ID);
	CALL
	    Create_Activity(
	        NEW.`ROOM_ID`,
	        NEW.`AUTHOR_ID`,
	        @SPHERE_ID,
	        'Update'
	    );
END; 

CREATE TRIGGER `REMOVE_TASKS_ACTIVITY` AFTER DELETE 
ON `TASKS` FOR EACH ROW BEGIN 
	DECLARE SPHERE_ID INT UNSIGNED;
	CALL GET_OR_CREATE_ACTIVITY_SPHERE('TASK', @SPHERE_ID);
	CALL
	    Create_Activity(
	        OLD.`ROOM_ID`,
	        OLD.`AUTHOR_ID`,
	        @SPHERE_ID,
	        'Remove'
	    );
END; 

CREATE TRIGGER `CREATE_GROUPS_ACTIVITY` AFTER INSERT 
ON `GROUPS` FOR EACH ROW BEGIN 
	DECLARE SPHERE_ID INT UNSIGNED DEFAULT 0;
	CALL GET_OR_CREATE_ACTIVITY_SPHERE('GROUP', @SPHERE_ID);
	CALL
	    Create_Activity(
	        NEW.`ROOM_ID`,
	        NEW.`CREATOR_ID`,
	        @SPHERE_ID,
	        'Create'
	    );
END; 

CREATE TRIGGER `UPDATE_GROUPS_ACTIVITY` AFTER UPDATE 
ON `GROUPS` FOR EACH ROW BEGIN 
	DECLARE SPHERE_ID INT UNSIGNED;
	CALL GET_OR_CREATE_ACTIVITY_SPHERE('GROUP', @SPHERE_ID);
	CALL
	    Create_Activity(
	        NEW.`ROOM_ID`,
	        NEW.`CREATOR_ID`,
	        @SPHERE_ID,
	        'Update'
	    );
END; 

CREATE TRIGGER `REMOVE_GROUPS_ACTIVITY` AFTER DELETE 
ON `GROUPS` FOR EACH ROW BEGIN 
	DECLARE SPHERE_ID INT UNSIGNED;
	CALL GET_OR_CREATE_ACTIVITY_SPHERE('GROUP', @SPHERE_ID);
	CALL
	    Create_Activity(
	        OLD.`ROOM_ID`,
	        OLD.`CREATOR_ID`,
	        @SPHERE_ID,
	        'Remove'
	    );
END; 

CREATE TRIGGER `CREATE_COMMENTS_ACTIVITY` AFTER INSERT 
ON `COMMENTS` FOR EACH ROW BEGIN 
	DECLARE SPHERE_ID INT UNSIGNED;
	DECLARE ROOM_ID INT UNSIGNED;
	CALL GET_OR_CREATE_ACTIVITY_SPHERE('COMMENT', @SPHERE_ID);
	CALL GET_ROOM_ID_BY_TASK_ID(NEW.`TASK_ID`, @ROOM_ID);
	CALL
	    Create_Activity(
	        @ROOM_ID,
	        NEW.`AUTHOR_ID`,
	        @SPHERE_ID,
	        'Create'
	    );
END; 

CREATE TRIGGER `UPDATE_COMMENTS_ACTIVITY` AFTER UPDATE 
ON `COMMENTS` FOR EACH ROW BEGIN 
	DECLARE SPHERE_ID INT UNSIGNED;
	DECLARE ROOM_ID INT;
	CALL GET_OR_CREATE_ACTIVITY_SPHERE('COMMENT', @SPHERE_ID);
	CALL GET_ROOM_ID_BY_TASK_ID(NEW.`TASK_ID`, @ROOM_ID);
	CALL
	    Create_Activity(
	        @ROOM_ID,
	        NEW.`AUTHOR_ID`,
	        @SPHERE_ID,
	        'Update'
	    );
END; 

CREATE TRIGGER `REMOVE_COMMENTS_ACTIVITY` AFTER DELETE 
ON `COMMENTS` FOR EACH ROW BEGIN 
	DECLARE SPHERE_ID INT UNSIGNED;
	DECLARE ROOM_ID INT;
	CALL GET_OR_CREATE_ACTIVITY_SPHERE('COMMENT', @SPHERE_ID);
	CALL GET_ROOM_ID_BY_TASK_ID(OLD.TASK_ID, @ROOM_ID);
	CALL
	    Create_Activity(
	        @ROOM_ID,
	        OLD.`AUTHOR_ID`,
	        @SPHERE_ID,
	        'Remove'
	    );
END; 