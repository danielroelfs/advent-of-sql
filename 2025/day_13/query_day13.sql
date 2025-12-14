WITH os AS (
    SELECT
        volunteer_name,
        role AS assigned_role,
        CASE
            WHEN shift_time LIKE '%10%' THEN '10:00'
            WHEN shift_time LIKE '%12%' THEN '12:00'
            WHEN shift_time LIKE '%2%' THEN '14:00'
        END AS shift_time
    FROM official_shifts
),

lms AS (
    SELECT
        volunteer_name,
        CASE
            WHEN LOWER(assigned_task) LIKE '%stage%' THEN 'stage_setup'
            WHEN LOWER(assigned_task) LIKE '%cocoa%' THEN 'cocoa_station'
            WHEN LOWER(assigned_task) LIKE '%parking%' THEN 'parking_support'
            WHEN LOWER(assigned_task) LIKE '%choir%' THEN 'choir_assistant'
            WHEN
                LOWER(assigned_task) LIKE '%handwarmer%'
                THEN 'handwarmer_handout'
            WHEN LOWER(assigned_task) LIKE '%snow%' THEN 'snow_shoveling'
            WHEN LOWER(assigned_task) LIKE '%shovel%' THEN 'snow_shoveling'
        END AS assigned_task_clean,
        CASE
            WHEN LOWER(time_slot) LIKE '%noon%' THEN '12:00'
            WHEN time_slot LIKE '%10%' THEN '10:00'
            WHEN time_slot LIKE '%2%' THEN '14:00'
        END AS time_slot_clean
    FROM last_minute_signups
),

merged_table AS (
    SELECT
        COALESCE(lms.volunteer_name, os.volunteer_name) AS volunteer_name,
        COALESCE(lms.assigned_task_clean, os.assigned_role) AS assigned_role,
        COALESCE(lms.time_slot_clean, os.shift_time) AS shift_time
    FROM lms
    FULL OUTER JOIN os ON lms.volunteer_name = os.volunteer_name
)

SELECT DISTINCT
    volunteer_name,
    assigned_role,
    shift_time
FROM merged_table
ORDER BY volunteer_name ASC
LIMIT 15;
