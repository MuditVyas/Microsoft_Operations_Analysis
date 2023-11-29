CREATE DATABASE op_case_study_1;
USE op_case_study_1;
CREATE TABLE job_study1 (
    ds VARCHAR(15),
    job_id INT,
    actor_id INT,
    event VARCHAR(15),
    language VARCHAR(15),
    time_spent INT,
    org VARCHAR(1)
);
SELECT * from job_study1;


# percentage share of each language
SELECT 
    language,
    ROUND(COUNT(language) / (SELECT COUNT(*) FROM job_study1) * 100,2) 
    AS Share_of_each_language_perct
FROM
    job_study1
GROUP BY language;

#jobs reviewed over time
SELECT 
    ds,
    time_spent,
    ROUND(3600 / time_spent) AS Num_of_reviews_per_hr
FROM
    job_study1
GROUP BY ds
ORDER BY ds;

#Throughput Analysis-
# Change data type of date column(ds) from varchar to datetime
ALTER TABLE job_study1 ADD COLUMN temp_date DATE;
UPDATE job_study1 SET temp_date =STR_TO_DATE(ds,'%d-%m-%Y');
ALTER TABLE job_study1 DROP COLUMN ds;
ALTER TABLE job_study1 CHANGE COLUMN temp_date ds DATE;

#Average Throughput calculation
SELECT 
    WEEK(ds) AS weeknum,
    COUNT(WEEK(ds)) AS event_count,
    COUNT(WEEK(ds)) / SUM(time_spent) AS throughput
FROM
    job_study1
GROUP BY weeknum
ORDER BY weeknum , ds; 

#duplicates
WITH duplicates AS (
    SELECt *,ROW_NUMBER() OVER (PARTITION BY ds,job_id,actor_id,event,language,time_spent,org ) AS rownum
    FROM job_study1)
SELECT * FROM duplicates having rownum>1;





