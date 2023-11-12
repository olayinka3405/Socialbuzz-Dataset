
--Socialbuzz Data set
USE SocialbuzzProjects;


--Retrieve data (all columns) from Socialbuzz database
SELECT * FROM Reactions
SELECT * FROM Content
SELECT * FROM Reaction_Types


-- Merge Columns from Tables (Content, Reactions and Reaction types) into new table 'Merged_Table'
SELECT Rxn.Content_ID, Rxn.Type AS Reaction_Type, Rxn.DateTime AS Reaction_Date_Time, 
		C.Type AS Content_Type, C.Category AS Content_Category,
			R.Sentiment AS Reaction_Sentiment, R.Score AS Reaction_Scores
INTO Merged_Table
FROM Reactions AS Rxn
LEFT JOIN Content AS C ON Rxn.Content_ID = C.Content_ID
LEFT JOIN Reaction_Types AS R ON Rxn.Type = R.Type
WHERE Rxn.Type IS NOT NULL
AND	R.Sentiment IS NOT NULL
AND	R.Score IS NOT NULL;


--Retrieve data (all columns) from Merged_Table
SELECT * FROM Merged_Table


--Select values with quotation mark in a column using wildcards
SELECT Content_Category FROM Merged_Table
WHERE Content_Category LIKE '%"'


--Replacing Quotations in Content_Category Column
UPDATE Merged_Table
SET Content_Category = REPLACE(Content_Category, '"science"', 'science')


--Sum of Scores for each Categories
SELECT Content_Category AS Categories, SUM(Reaction_Scores) AS Agg_Score
FROM Merged_Table
GROUP BY Content_Category
ORDER BY Agg_Score DESC


--Selecting top 5 Categories against Agg scores
SELECT TOP 5 Content_Category AS Categories, SUM(Reaction_Scores) AS Agg_Score
FROM Merged_Table
GROUP BY Content_Category
ORDER BY Agg_Score DESC

