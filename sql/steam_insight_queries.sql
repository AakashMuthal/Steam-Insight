-- STEAM INSIGHT | SQL Business Analysis
-- Table: steam_games

-- Query 1
SELECT *
FROM steam_games
LIMIT 10;

-- Query 2
SELECT name, price, genres
FROM steam_games
WHERE price > 20
ORDER BY price DESC;

-- Query 3
SELECT name, positive, negative,
       positive + negative AS total_reviews
FROM steam_games
WHERE positive IS NOT NULL AND negative IS NOT NULL
ORDER BY total_reviews DESC
LIMIT 10;

-- Query 4
SELECT COUNT(*) AS total_games
FROM steam_games;

-- Query 5
SELECT SUM(positive) AS total_positive_reviews,
       SUM(negative) AS total_negative_reviews
FROM steam_games;

-- Query 6
SELECT AVG(price) AS average_price,
       MIN(price) AS minimum_price,
       MAX(price) AS maximum_price
FROM steam_games;

-- Query 7
SELECT strftime('%Y', release_date) AS release_year,
       COUNT(*) AS game_count
FROM steam_games
WHERE release_date IS NOT NULL
GROUP BY release_year
ORDER BY release_year;

-- Query 8
SELECT
    CASE
        WHEN price = 0 THEN 'Free'
        WHEN price > 0 AND price <= 10 THEN 'Budget'
        WHEN price > 10 AND price <= 30 THEN 'Mid-range'
        WHEN price > 30 THEN 'Premium'
        ELSE 'Unknown'
    END AS price_category,
    AVG(100.0 * positive / NULLIF(positive + negative, 0)) AS average_positive_rate,
    COUNT(*) AS game_count
FROM steam_games
WHERE positive IS NOT NULL AND negative IS NOT NULL
GROUP BY price_category
ORDER BY average_positive_rate DESC;

-- Query 9
SELECT genres, COUNT(*) AS game_count,
       AVG(price) AS average_price
FROM steam_games
WHERE genres IS NOT NULL
GROUP BY genres
HAVING COUNT(*) >= 5
ORDER BY game_count DESC;

-- Query 10
SELECT name, positive
FROM steam_games
WHERE positive > (SELECT AVG(positive) FROM steam_games)
ORDER BY positive DESC;

-- Query 11
SELECT name, positive, negative,
       ROUND(100.0 * positive / NULLIF(positive + negative, 0), 2) AS positive_rate
FROM steam_games
WHERE positive + negative >= 20
  AND 100.0 * positive / NULLIF(positive + negative, 0) > 80
ORDER BY positive_rate DESC;

-- Query 12
SELECT name, average_playtime_forever, genres
FROM steam_games
WHERE average_playtime_forever IS NOT NULL
ORDER BY average_playtime_forever DESC
LIMIT 10;

-- Query 13
SELECT
    CASE
        WHEN price = 0 THEN 'Free'
        WHEN price > 0 THEN 'Paid'
        ELSE 'Unknown'
    END AS game_type,
    COUNT(*) AS game_count,
    AVG(positive) AS average_positive_reviews,
    AVG(negative) AS average_negative_reviews,
    AVG(price) AS average_price
FROM steam_games
GROUP BY game_type;

-- Query 14
SELECT name, positive, negative,
       positive + negative AS total_reviews
FROM steam_games
WHERE negative > positive
ORDER BY total_reviews DESC;

-- Query 15
SELECT name, price
FROM steam_games
WHERE price > (SELECT AVG(price) FROM steam_games)
ORDER BY price DESC;

-- Query 16
SELECT COUNT(*) AS total_games,
       SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS missing_price,
       SUM(CASE WHEN positive IS NULL THEN 1 ELSE 0 END) AS missing_positive,
       SUM(CASE WHEN negative IS NULL THEN 1 ELSE 0 END) AS missing_negative,
       SUM(CASE WHEN average_playtime_forever IS NULL THEN 1 ELSE 0 END) AS missing_playtime
FROM steam_games;

