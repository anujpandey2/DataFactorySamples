
DROP TABLE dbo.PipelineMetadata

DROP TABLE dbo.PipelineTracker

CREATE TABLE dbo.PipelineMetadata(
	SourceType varchar(50) NULL,
	SourceDB varchar(100) NULL,
	SourceTable varchar(100) NULL,
	Destination varchar(100) NULL,
	DestinationTable varchar(100) NULL,
	ExistingTable int NULL,
)
GO

CREATE TABLE dbo.PipelineTracker(
	PipelineName varchar(500) NULL,
	PipelineRuntime Datetime NULL,
	PipelineStatus varchar(100) NULL,
	PipelineMessage varchar(1000) NULL
)

INSERT INTO dbo.PipelineMetadata VALUES ('LH','PublicHolidaysSource', 'HolidaysTable', 'HolidaysDW','HolidaysTable',1)

INSERT INTO dbo.PipelineMetadata VALUES ('DW','HolidaysDW', 'HolidaysTable', 'HolidaysDW','HolidaysTableNew',0)

SELECT * FROM dbo.PipelineMetadata

SELECT * FROM dbo.PipelineTracker


