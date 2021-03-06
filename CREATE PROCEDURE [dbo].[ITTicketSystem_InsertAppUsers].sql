USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will insert an app_user
CREATE PROCEDURE [dbo].[ITTicketSystem_InsertAppUsers]
	@FirstName varchar(150),
	@LastName varchar(150),	
	@EmailAddress varchar(500),
	@Status varchar(50)

AS
BEGIN
	
	SET NOCOUNT ON;
    
	INSERT INTO app_user (first_name, last_name, app_user_status_id, email_address, active_flag)
	select @FirstName, @LastName, 1, @EmailAddress, 1
	from app_user_status
	where name = @Status
	
END
