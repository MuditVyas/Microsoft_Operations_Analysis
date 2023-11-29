USE op_cs2;
# weekly user engagement
SELECT LEFT(created_at,10) as activate_d ,Count(LEFT(created_at,10)) as counts,yearweek(LEFT(created_at,10),3) as weeknum  from users
-- GROUP BY LEFT(created_at,10);
GROUP BY weeknum;

#user growth over period
SELECT LEFT(created_at,7) as user_join, Count(LEFT(created_at,7))as counts from users
GROUP BY LEFT(created_at,7);


#weekly retention analysis
SELECT event_name,occurred_at,week(LEFT(occurred_at,10))-16 as weeknu ,count(week(LEFT(occurred_at,10))) as counts FROM events
where event_name in('login','complete_signup')
group by weeknu;

#weekly engagement per device
SELECT tnow FROM (
SELECT COUNT(DISTINCT week(LEFT(occurred_at,10))) as tnow FROM events) as total_weeks;


SELECT user_id,
	   device, 
       COUNT(DISTINCT week(LEFT(occurred_at,10))) as activeness,
       CASE
       when  COUNT(DISTINCT week(LEFT(occurred_at,10))) >= 17 then 'Excellent'
       when  COUNT(DISTINCT week(LEFT(occurred_at,10))) between 12 and 17 then 'Very_good'
       when  COUNT(DISTINCT week(LEFT(occurred_at,10))) between 8 and 12 then 'good'
       ELSE 'poor'
       end as retention
   --    COUNT(DISTINCT week(LEFT(occurred_at,10)))/(SELECT COUNT(DISTINCT week(LEFT(occurred_at,10))) as tnow FROM events) as percent_redention 
FROM events
group by user_id
order by activeness desc,user_id;

SELECT COUNT(DISTINCT week(LEFT(occurred_at,10))) as tnow FROM events;

#email  engagement
SELECT * FROM email_events;
Select user_id , 
(SELEct count(action) from email_events where action ='sent_weekly_digest' group by user_id) as sent_weekly_digest,
(SELEct count(action) from email_events where action ='email_open'group by user_id) as email_open,
(SELEct count(action) from email_events where action ='email_clickthrough' group by user_id) as link_clicked
FROM email_events;

with email_open as (
SELEct user_id,count(action) as email_open from email_events where action ='email_open' group by user_id),

email_cl as (
SELEct user_id, count(action) as email_click from email_events where action ='email_clickthrough' group by user_id )

SELECT swd.user_id, count(action) as weekly_digest_count ,eo.email_open,ecl.email_click from email_events as swd
 left join email_open as eo ON swd.user_id=eo.user_id
 left join email_cl as ecl ON swd.user_id =ecl.user_id
where action='sent_weekly_digest'
group by swd.user_id
order by email_open desc;

#weekly retention analysis
















