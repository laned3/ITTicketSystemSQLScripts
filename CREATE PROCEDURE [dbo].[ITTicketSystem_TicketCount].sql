USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will get a count of all active tickets
CREATE PROCEDURE [dbo].[ITTicketSystem_TicketCount]

AS
BEGIN
	
	SET NOCOUNT ON;
    
	select count(distinct ticket_id)[TicketCount]
		  , s.name [Status]
		  , concat(a.first_name,' ',a.last_name)[AppUser]		
	from ticket t 
	left join app_user a on t.assigned_app_user_id = a.app_user_id
	join ticket_status s on t.ticket_status_id = s.ticket_status_id	
	where t.active_flag = 1
	group by s.name, concat(a.first_name,' ',a.last_name)

END