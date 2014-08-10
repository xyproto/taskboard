-- tabela para a entidade - "Board[board]"
CREATE TABLE `BOARD` (
	ID BIGINT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY(ID),
	`NAME` VARCHAR(255),
	`DESCRIPTION` VARCHAR(255),
	VERSION INTEGER NOT NULL,
	CREATION TIMESTAMP,
	MODIFICATION TIMESTAMP
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;


-- tabela para a entidade - "Lane[lane]"
CREATE TABLE `LANE` (
	ID BIGINT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY(ID),
	`NAME` VARCHAR(255),
	`POSITION` BIGINT,
	`BOARD` BIGINT,
	VERSION INTEGER NOT NULL,
	CREATION TIMESTAMP,
	MODIFICATION TIMESTAMP
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;


-- tabela para a entidade - "Task[task]"
CREATE TABLE `TASK` (
	ID BIGINT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY(ID),
	`ISSUE` BIGINT,
	`RESPONSIBLE` VARCHAR(255),
	`TITLE` VARCHAR(255),
	`DETAIL` VARCHAR(255),
	`HEAD_COLOR` VARCHAR(255),
	`BODY_COLOR` VARCHAR(255),
	`POSITION` BIGINT,
	`LANE` BIGINT,
	VERSION INTEGER NOT NULL,
	CREATION TIMESTAMP,
	MODIFICATION TIMESTAMP
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;


-- tabela para a entidade - "Notification[notification]"
CREATE TABLE `NOTIFICATION` (
	ID BIGINT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY(ID),
	`EMAIL` VARCHAR(255),
	`TASK` BIGINT,
	`LANE` BIGINT,
	VERSION INTEGER NOT NULL,
	CREATION TIMESTAMP,
	MODIFICATION TIMESTAMP
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;


-- CREATING ENTITY CONSTRAINTS INDEXES "Lane"
CREATE INDEX I1_LANE ON LANE (BOARD);
-- CREATING ENTITY CONSTRAINTS INDEXES "Task"
CREATE INDEX I1_TASK ON TASK (LANE);
-- CREATING ENTITY CONSTRAINTS INDEXES "Notification"
CREATE INDEX I1_NOTIFICATION ON NOTIFICATION (TASK);
CREATE INDEX I2_NOTIFICATION ON NOTIFICATION (LANE);

-- CREATING ENTITY CONSTRAINTS "Board"
ALTER TABLE `BOARD` ADD CONSTRAINT UK_BOARD1 UNIQUE (`NAME`);
ALTER TABLE `BOARD` ADD CONSTRAINT UK_BOARD2 UNIQUE (`DESCRIPTION`);
-- CREATING ENTITY CONSTRAINTS "Lane"
ALTER TABLE `LANE` ADD CONSTRAINT UK_POS UNIQUE (`BOARD`, `POSITION`);
ALTER TABLE `LANE` ADD CONSTRAINT FK_LANE1 FOREIGN KEY (`BOARD`) REFERENCES `BOARD` (ID);
-- CREATING ENTITY CONSTRAINTS "Task"
ALTER TABLE `TASK` ADD CONSTRAINT UK_POS UNIQUE (`LANE`, `POSITION`);
ALTER TABLE `TASK` ADD CONSTRAINT FK_TASK1 FOREIGN KEY (`LANE`) REFERENCES `LANE` (ID);
-- CREATING ENTITY CONSTRAINTS "Notification"
ALTER TABLE `NOTIFICATION` ADD CONSTRAINT FK_NOTIFICATION1 FOREIGN KEY (`TASK`) REFERENCES `TASK` (ID);
ALTER TABLE `NOTIFICATION` ADD CONSTRAINT FK_NOTIFICATION2 FOREIGN KEY (`LANE`) REFERENCES `LANE` (ID);