USE op_case_study_1;
CREATE TABLE job_study1(ds VARCHAR(15),job_id int,	actor_id int,event  VARCHAR(15), language  VARCHAR(15),time_spent int,org VARCHAR(1));
SELECT * from job_study1;


# percentage share of each language
SELECT 
    language,
    ROUND(COUNT(language) / (SELECT 
                    COUNT(*)
                FROM
                    job_study1) * 100,
            2) AS Share_of_each_language_perct
FROM
    job_study1
GROUP BY language;

#jobs reviewed over time
SELECT ds,time_spent, round(3600/time_spent) as Num_of_reviews_per_hr FROM job_study1
GROUP BY ds
order by ds;

#Throughput Analysis
ALTER TABLE job_study1 ADD COLUMN temp_date DATE;
UPDATE job_study1 SET temp_date =STR_TO_DATE(ds,'%d-%m-%Y');
ALTER TABLE job_study1 DROP COLUMN ds;
ALTER TABLE job_study1 CHANGE COLUMN temp_date ds DATE;

SELECT week(ds) as weeknum ,count(week(ds)) as event_count ,count(week(ds))/sum(time_spent) as throughput FROM job_study1
group by weeknum
order by weeknum,ds; 

#duplicates
WITH duplicates AS (
    SELECt *,ROW_NUMBER() OVER (PARTITION BY ds,job_id,actor_id,event,language,time_spent,org ) AS rownum
    FROM job_study1)
SELECT * FROM duplicates having rownum>1;





