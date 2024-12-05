USE JAMB_Scores_Assign;
GO

INSERT INTO dim.ITknowledgeID(IT_KnowledgeID,IT_Knowledge)
	SELECT IT_KnowledgeID
			,IT_Knowledge
	FROM stg.Dim_ITKnowledgeID
	WHERE IT_KnowledgeID not in (SELECT IT_KnowledgeID FROM dim.ITknowledgeID)
;
GO

INSERT INTO dim.ParentInvolvement(ParentinvolvementID,Parent_involvement)
	SELECT ParentinvolvementID
			,Parent_Involvement
	FROM stg.Dim_ParentInvolvement
	WHERE ParentinvolvementID not in (SELECT ParentinvolvementID FROM dim.ParentInvolvement)
;
GO

INSERT INTO dim.SchoolLocation(SchoolLocationID,School_Location)
	SELECT [SchoolLocation ID]
			,School_Location
	FROM stg.Dim_SchoolLocation
	WHERE [SchoolLocation ID] not in (SELECT SchoolLocationID FROM dim.SchoolLocation)
;
GO

INSERT INTO dim.SchoolType(SchoolTypeID,School_Type)
	SELECT SchoolTypeID
			,School_Type
	FROM stg.Dim_SchoolType
	WHERE [SchoolTypeID] not in (SELECT SchoolTypeID FROM Dim.SchoolType)
;
Go

INSERT INTO fact.jamb_exam_results(JAMB_Score, Study_Hours_Per_Week,Attendance_Rate,Teacher_Quality,Distance_To_School,fkSchoolTypeID,School_Type,fkDim_SchoolLocation,School_Location,Extra_Tutorials,Access_To_Learning_Materials,fkDim_ParentInvolvement,Parent_Involvement,fkIT_KnowledgeID,IT_Knowledge,Student_ID,Age,Gender,Socioeconomic_Status,Parent_Education_Level,Assignments_Completed)
	SELECT [JAMB_Score]
      ,[Study_Hours_Per_Week]
      ,[Attendance_Rate]
      ,[Teacher_Quality]
      ,[Distance_To_School]
      ,[SchoolTypeID]
      ,[School_Type]
      ,[Dim_SchoolLocation]
      ,[School_Location]
      ,[Extra_Tutorials]
      ,[Access_To_Learning_Materials]
      ,[Dim_ParentInvolvement]
      ,[Parent_Involvement]
      ,[IT_KnowledgeID]
      ,[IT_Knowledge]
      ,[Student_ID]
      ,[Age]
      ,[Gender]
      ,[Socioeconomic_Status]
      ,[Parent_Education_Level]
      ,[Assignments_Completed]
  FROM stg.jamb_exam_results
	--WHERE [SchoolTypeID] not in (SELECT SchoolTypeID FROM Dim.SchoolType)
;