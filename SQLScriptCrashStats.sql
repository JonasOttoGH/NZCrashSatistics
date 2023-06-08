--- Look and review data sets
SELECT TOP 100* 
FROM dbo.CarshDataHalf

SELECT TOP 100* 
FROM dbo.CarshDataLocation

--Create table to join data sets

DROP TABLE IF EXISTS [Final Table]
SELECT *INTO [Final Table] from
(
SELECT *
FROM dbo.CarshDataHalf CDH
JOIN dbo.CarshDataLocation CDL
ON CDH.OBJECTID = CDL.object_ID
) as [Final Table]

--Review data in check data in each coloumn
SELECT DISTINCT vehicle, COUNT(vehicle) as [amount of cases]
FROM [Final Table]
GROUP BY vehicle
ORDER BY vehicle

-- Update table and prexisting columns

Update [Final Table]
SET speedLimit = (
		CASE 
			WHEN (speedLimit ='2') THEN '20'
			WHEN (speedLimit ='61') THEN '60'
			WHEN (speedLimit ='51') THEN '50'
			WHEN (speedLimit ='6') THEN '60'
			WHEN (speedLimit ='5') THEN '50'
			WHEN (speedLimit ='15') THEN '20'
			ELSE speedLimit
			END),
	region = SUBSTRING(region,0, LEN(region)-6), -- Use substring to update and drop 'region' word in region column
	strayAnimal = ISNULL(strayAnimal, '0'),
	holiday = (
		CASE 
			WHEN (holiday is not NUll) THEN holiday
			ELSE 'No Holiday'
			END),
	trafficControl = (
		CASE
			WHEN (trafficControl = 'Nil') THEN 'Unknown'
			ELSE trafficControl
			END)

-- Alter table to add column and then Update columns

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
	[Crash Location] = CONCAT(crashLocation1 , ' ' , crashLocation2), -- Joining locations together for one address
	[Car] = carStationWagon + ISNULL(vehicle, 0) + taxi + suv , -- Joining vechile together to make less groups
	[Buses] = bus + schoolBus,
	[Other Vehicle] = ISNULL(train, 0) + unknownVehicleType,
	[Van Or Utility] = truck + vanOrUtility


UPDATE [Final Table] -- 
SET [Temporary Speed] =(
	CASE 
		WHEN ([Temporary Speed] is NUll) THEN 'No' 
		ELSE 'Yes'
		END
		)

-- Drop unneccarcery coloumns

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

-- Renaming columns (should have done this earlier)
EXEC sp_rename '[Final Table].cliffBank','Cliff Bank', 'COLUMN'
EXEC sp_rename '[Final Table].crashDirectionDescription','Crash Direction', 'COLUMN'

--Review data again
SELECT *
FROM [Final Table]

CREATE VIEW [Final Table] AS
SELECT *
FROM [Final Table]

