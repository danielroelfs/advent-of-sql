SELECT
    songs.song_title,
    COUNT(songs.song_title) AS total_plays,
    SUM(
        CASE WHEN up.duration < songs.song_duration THEN 1 ELSE 0 END
    ) AS skipped
FROM songs
INNER JOIN user_plays AS up ON songs.song_id = up.song_id
GROUP BY songs.song_title
ORDER BY total_plays DESC, skipped ASC
LIMIT 10;
