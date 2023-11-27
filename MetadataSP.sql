CREATE PROCEDURE UpdatePipelineTracker
(
    @PipelineName varchar(500),
	@PipelineRuntime Datetime,
	@PipelineStatus varchar(100),
	@PipelineMessage varchar(500)
)
AS
BEGIN
    SET NOCOUNT ON
	INSERT INTO dbo.PipelineTracker VALUES (@PipelineName,@PipelineRuntime,@PipelineStatus,@PipelineMessage)
END
GO
