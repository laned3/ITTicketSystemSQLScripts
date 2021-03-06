USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will get a ticket by ID
CREATE PROCEDURE [dbo].[ITTicketSystem_GetOneTicket]
	@Id int
AS
BEGIN
	
	SET NOCOUNT ON;
    
	select ticket_id[TicketID] 
		  ,title[Title]
		  ,category[Category]
		  ,t.description[Description]
		  ,s.name[TicketStatus]
		  ,requested_by[RequestedBy]
		  ,concat(a.first_name,' ',a.last_name)[AssignedTo]
		  ,isnull(ticket_notes,'')[TicketNotes]
		  ,t.inserted_date[CreatedDate]
		  ,t.updated_date[UpdatedDate]
	from ticket t 
	left join app_user a on t.assigned_app_user_id = a.app_user_id
	join ticket_status s on t.ticket_status_id = s.ticket_status_id
	where ticket_id = @Id
END