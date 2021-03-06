USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will get all app_users that have an active_flag = 1
CREATE PROCEDURE [dbo].[ITTicketSystem_GetAppUsers]

AS
BEGIN
	
	SET NOCOUNT ON;
    
	SELECT app_user_id[AppUserId]
		  ,first_name[FirstName]
		  ,last_name[LastName]
		  ,email_address[EmailAddress]
		  ,s.name [Status]	  
	FROM app_user a
	JOIN app_user_status s on a.app_user_status_id = s.app_user_status_id 	
	where a.active_flag = 1
	ORDER BY s.name desc, last_name asc

END