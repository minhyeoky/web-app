/* Ex 6: Multi-table query */
-- search all roles played in the movie named Pi. (28 rows)
SELECT
    role
FROM
    `roles`
    JOIN `movies` ON roles.movie_id = id
    -- x, Cartesian Product, N x M, 
WHERE
    name = 'Pi';
-- search first/last names of all actors who appeared in Pi along with their roles (28 rows)
SELECT
    first_name, last_name
FROM
    -- sub query 활용
    (SELECT *
    FROM `roles`
    JOIN `movies` ON roles.movie_id = id
    WHERE name = 'Pi') rm -- rm = 동적으로 생성된 테이블의 이름
    JOIN `actors` ON rm.actor_id = actors.id;
-- search first/last names of all actors who appeared in both Kill Bill: Vol.1 and Kill Bill: Vol.2 (10 rows)
SELECT
    first_name,
    last_name
FROM
    (
        SELECT
            *
        FROM
            `roles`
            JOIN `movies` ON roles.movie_id = id
        WHERE
            name = 'Kill Bill: Vol. 1'
    ) k1
    JOIN `actors` ON k1.actor_id = actors.id
WHERE
    actor_id IN (
        SELECT
            actor_id
        FROM
            `roles`
            JOIN `movies` ON roles.movie_id = id
        WHERE
            name = 'Kill Bill: Vol. 2'
    );
-- search for top 7 actors who have appeared in the most films, in descending order
SELECT
    *
FROM
    (
        SELECT 
            first_name, last_name, COUNT(actors.id) As `number_of_appear` 
        FROM
            (
                SELECT
                    *
                FROM
                    `roles`
                    JOIN `movies` ON roles.movie_id = id
            ) p
            JOIN `actors` ON p.actor_id = actors.id
        GROUP BY
            actors.id
    ) t ORDER BY number_of_appear DESC
LIMIT 7; 
-- search for top 3 most popular genres of films, in descending order
SELECT
    *
FROM
    (
        SELECT
            COUNT(genre) As `count_of_genre`, genre
        FROM
            `movies`
            JOIN `movies_genres` ON movies.id = movies_genres.movie_id
        GROUP BY
            movies_genres.genre
    ) t ORDER BY count_of_genre DESC
LIMIT 3;
-- search the name of the director who has directed the most Thriller films
SELECT
    *
FROM
    (
        SELECT
            COUNT(director_id) As `n_thriller`,
            first_name,
            last_name
        FROM
            (
                SELECT
                    first_name,
                    last_name,
                    movies_directors.director_id
                FROM
                    `movies`
                    JOIN `movies_directors` ON movies.id = movies_directors.movie_id
                    JOIN `directors` ON movies_directors.director_id = directors.id
                    JOIN `directors_genres` ON directors.id = directors_genres.director_id
                WHERE
                    genre = 'Thriller'
            ) t
        GROUP BY
            director_id
    ) s
ORDER BY
    n_thriller DESC
LIMIT
    1;

