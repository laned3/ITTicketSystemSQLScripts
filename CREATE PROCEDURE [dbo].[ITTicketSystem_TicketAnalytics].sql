USE [ITTicketSystem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Proc will get the number of OpenTickets, CompletedTickets, and CancelledTickets by AppUser
CREATE PROCEDURE [dbo].[ITTicketSystem_TicketAnalytics]

AS
BEGIN
	
	SET NOCOUNT ON;
    
	if object_id('tempdb..#temp') is not null drop table #temp

	select  iif(s.active_status_id = 1, 1, 0)[OpenTickets]
		  , iif(s.completed_status_id = 1, 1, 0)[CompletedTickets]
		  , iif(s.cancelled_status_id = 1, 1, 0)[CancelledTickets]
		  , dd.date_key [RequestedDate]
		  , dd2.date_key [LastModifiedDate]
		  , concat(a.first_name,' ',a.last_name)[AppUser]		
	into #temp
	from ticket t 
	left join app_user a on t.assigned_app_user_id = a.app_user_id
	join ticket_status s on t.ticket_status_id = s.ticket_status_id	
	join date_dimension dd on cast(t.inserted_date as date)= dd.date_key
	left join date_dimension dd2 on isnull(cast(t.updated_date as date),cast(getdate()as date)) = dd2.date_key
	where t.active_flag = 1
	
	select sum(OpenTickets)[OpenTickets]
		 , sum(CompletedTickets)[CompletedTickets]
		 , sum(CancelledTickets) [CancelledTickets]
		 , RequestedDate
		 , LastModifiedDate
		 , AppUser
	from #temp
	group by RequestedDate, LastModifiedDate, AppUser
	
END