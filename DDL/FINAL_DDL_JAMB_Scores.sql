USE JAMB_Scores_Assign;
GO

--CREATE SCHEMA stg;

--CREATE SCHEMA dim;

--CREATE SCHEMA fact;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'ITknowledgeID')
BEGIN
create table dim.ITknowledgeID (
            IT_KnowledgeID int not null
			,IT_Knowledge NVARCHAR(50) NOT NULL
);

ALTER TABLE dim.ITknowledgeID
ADD CONSTRAINT PK_IT_KnowledgeID PRIMARY KEY(IT_KnowledgeID);
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'ParentInvolvement')
BEGIN
create table dim.ParentInvolvement(
             ParentinvolvementID int not null
			 ,Parent_involvement NVARCHAR(50) not null
);

	ALTER TABLE dim.ParentInvolvement
	ADD CONSTRAINT PK_ParentinvolvementID PRIMARY KEY(ParentinvolvementID);

END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'SchoolLocation')
BEGIN
create table dim.SchoolLocation(
            SchoolLocationID int not null
			,School_Location NVARCHAR(50) not null
);
ALTER TABLE dim.SchoolLocation
ADD CONSTRAINT PK_School_Location PRIMARY KEY(School_Location);
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'SchoolType')
BEGIN
create table dim.SchoolType(
            SchoolTypeID int not null
			,School_Type NVARCHAR (50) not null
);
ALTER TABLE dim.SchoolType
ADD CONSTRAINT PK_SchoolTypeID PRIMARY KEY(SchoolTypeID);
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'fact' AND TABLE_NAME = 'jamb_exam_results')
BEGIN
CREATE TABLE fact.jamb_exam_results(
	JAMB_Score int NULL,
	Study_Hours_Per_Week int NULL,
	Attendance_Rate int NULL,
	Teacher_Quality int NULL,
	Distance_To_School float NULL,
	fkSchoolTypeID nvarchar(50) not NULL,
	School_Type nvarchar(50) NULL,
	fkDim_SchoolLocation nvarchar(50) not NULL,
	School_Location nvarchar(50) NULL,
	Extra_Tutorials nvarchar(50) NULL,
	Access_To_Learning_Materials nvarchar(50) NULL,
	fkDim_ParentInvolvement nvarchar(50) not NULL,
	Parent_Involvement nvarchar(50) NULL,
	fkIT_KnowledgeID nvarchar(50) not NULL,
	IT_Knowledge nvarchar(50) NULL,
	Student_ID int NULL,
	Age int NULL,
	Gender nvarchar(50) NULL,
	Socioeconomic_Status nvarchar(50) NULL,
	Parent_Education_Level nvarchar(50) NULL,
	Assignments_Completed int NULL
);


ALTER TABLE fact.jamb_exam_results
ADD CONSTRAINT FK_fkDim_SchoolLocation Foreign KEY(fkDim_SchoolLocation)
										REFERENCES dim.SchoolLocation(School_Location)
;

ALTER TABLE fact.jamb_exam_results
ADD CONSTRAINT FK_fkSchoolTypeID Foreign KEY(fkSchoolTypeID)
										REFERENCES dim.SchoolType(SchoolTypeID);

ALTER TABLE fact.jamb_exam_results
ADD CONSTRAINT FK_fkDim_ParentInvolvement Foreign KEY(fkDim_ParentInvolvement)
										REFERENCES dim.ParentInvolvement(ParentinvolvementID);

ALTER TABLE fact.jamb_exam_results
ADD CONSTRAINT FK_fkIT_KnowledgeID Foreign KEY(fkIT_KnowledgeID)
									REFERENCES dim.ITknowledgeID(IT_KnowledgeID);
END

