--Look and review downloaded data sets
SELECT TOP 100* 
FROM dbo.CarshDataHalf

SELECT TOP 100* 
FROM dbo.CarshDataLocation

--Create a table to join data sets

DROP TABLE IF EXISTS [Final Table]
SELECT *INTO [Final Table] from
(
SELECT *
FROM dbo.CarshDataHalf CDH
JOIN dbo.CarshDataLocation CDL
ON CDH.OBJECTID = CDL.object_ID
) as [Final Table]

--Review data in check data in each column
SELECT DISTINCT vehicle, COUNT(vehicle) as [amount of cases]
FROM [Final Table]
GROUP BY vehicle
ORDER BY vehicle

-- Update table and existing columns

Update [Final Table]
SET speedLimit = (
		CASE 
			WHEN (speedLimit ='2') THEN '20'
			WHEN (speedLimit ='61') THEN '60'
			WHEN (speedLimit ='51') THEN '50'
			WHEN (speedLimit ='6') THEN '60'
			WHEN (speedLimit ='5') THEN '50'
			ELSE speedLimit
			END),				-- Used case statement to update ‘speedLimit’ column to get rid of speed limit errors
	region = SUBSTRING(region,0, LEN(region)-6), 	-- Used substring to update ‘region’ and drop the word 'region'
	strayAnimal = ISNULL(strayAnimal, '0'),		-- Updated column due to error when querying ‘strayAnimal’ column
	holiday = (
		CASE 
			WHEN (holiday is not NUll) THEN holiday
			ELSE 'No Holiday'
			END),				-- Updated column to show 'No Holiday' instead of NULL
	trafficControl = (
		CASE
			WHEN (trafficControl = 'Nil') THEN 'Unknown'
			ELSE trafficControl
			END)				

-- Alter table to add new columns before updating them

ALTER TABLE [Final Table]
DROP COLUMN [Temporary Speed], [Car], [Crash Location], [Buses], [Other Vehicle], [Van Or Utility] 

ALTER TABLE [Final Table]
ADD [Temporary Speed] nvarchar (20),
	[Car] float, 
	[Crash Location] nvarchar (100),
	[Buses] float,
	[Other Vehicle] float,
	[Van Or Utility] float


UPDATE [Final Table]
SET [Temporary Speed] = temporarySpeedLimit, -- making new column for speed
	[Crash Location] = CONCAT(crashLocation1 , ' ' , crashLocation2), -- Joining both locations together for one address
	[Car] = carStationWagon + ISNULL(vehicle, 0) + taxi + suv , -- Joining vehicle groups together to limit the amount of groups I have for visualization
	[Buses] = bus + schoolBus,
	[Other Vehicle] = ISNULL(train, 0) + unknownVehicleType,
	[Van Or Utility] = truck + vanOrUtility


UPDATE [Final Table] -- After reviewing data again [Temporary Speed] column needed updating as well
SET [Temporary Speed] =(
	CASE 
		WHEN ([Temporary Speed] is NUll) THEN 'No' 
		ELSE 'Yes'
		END
		)

-- Drop unnecessary columns (columns not needed for visualisation)

SELECT top 1000*
FROM [Final Table]

ALTER TABLE [Final Table]
DROP COLUMN advisorySpeed,
			X, 
			Y, 
			crashFinancialYear, 
			crashLocation2, 
			debris, 
			guardRail, 
			directionRoleDescription, 
			meshblockID,
			objectThrownOrDropped,
			otherObject

-- Renaming columns to have a consistent letter case (should have done this earlier)
EXEC sp_rename '[Final Table].cliffBank','Cliff Bank', 'COLUMN'
EXEC sp_rename '[Final Table].crashDirectionDescription','Crash Direction', 'COLUMN'

--Review data again
SELECT *
FROM [Final Table]

--Create view for visualisation

CREATE VIEW [Final Table] 

