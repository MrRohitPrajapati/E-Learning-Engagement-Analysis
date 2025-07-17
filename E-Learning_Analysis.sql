
/* Average Session Time per user */

SELECT 
    user_id,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE,
                login_time,
                logout_time)),
            2) AS avg_session_minutes
FROM
    sessions
GROUP BY user_id; 


/* Top 10 most Viewed Content*/
SELECT 
    c.title, COUNT(*) AS views
FROM
    content_views v
        JOIN
    content_catalog c ON v.content_id = c.content_id
GROUP BY c.title
ORDER BY views DESC
LIMIT 10;

/*Content Views Over Time*/

SELECT 
    DATE(timestamp) AS view_date, COUNT(*) AS total_views
FROM
    content_views
GROUP BY view_date
ORDER BY view_date;

/* Engagement by Grade */

SELECT 
    u.grade,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE,
                s.login_time,
                s.logout_time)),
            2) AS avg_session_minutes
FROM
    sessions s
        JOIN
    users u ON s.user_id = u.user_id
WHERE
    u.grade IS NOT NULL
GROUP BY u.grade
ORDER BY u.grade;

/* Content Views by Type */
SELECT 
    c.type, COUNT(*) AS total_views
FROM
    content_views v
        JOIN
    content_catalog c ON v.content_id = c.content_id
GROUP BY c.type;