USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will get all tickets where the active_flag = 1
CREATE PROCEDURE [dbo].[ITTicketSystem_GetTickets]

AS
BEGIN
	
	SET NOCOUNT ON;
    
	select ticket_id[TicketID]
		  ,title[Title]
		  ,category[Category]
		  ,t.description[Description]
		  ,s.name[TicketStatus]
		  ,requested_by[RequestedBy]
		  ,isnull(concat(a.first_name,' ',a.last_name),'Unassigned')[AssignedTo]
		  ,ticket_notes[TicketNotes]
		  ,t.inserted_date[CreatedDate]
		  ,t.updated_date[UpdatedDate]
	from ticket t 
	left join app_user a on t.assigned_app_user_id = a.app_user_id
	join ticket_status s on t.ticket_status_id = s.ticket_status_id
	where t.active_flag = 1
	and s.active_status_id = 1

END