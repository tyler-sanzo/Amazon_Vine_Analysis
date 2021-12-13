-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

-- Check table
SELECT * FROM vine_table;

-- Filter data where total_votes count is >= 20
SELECT *
FROM vine_table
WHERE total_votes >= 20;

-- Filter data where helpful votes is >= 50% 
WITH over_twenty as (
    SELECT *
    FROM vine_table
    WHERE total_votes >= 20
)
SELECT * FROM over_twenty
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >= 0.5;

-- Filter data where helpful votes are over 50% vine = Y

WITH over_twenty as (
    SELECT *
    FROM vine_table
    WHERE total_votes >= 20
)
SELECT * FROM over_twenty
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >= 0.5
AND vine = 'Y';

-- Filter data where helpful votes are over 50% vine = N

WITH over_twenty as (
    SELECT *
    FROM vine_table
    WHERE total_votes >= 20
)
SELECT * FROM over_twenty
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >= 0.5
AND vine = 'N';

-- Query data from table to show total reviews, number of 5-star reviews,
-- and percentage of 5-star reviews for the two types of reviews (paid vs unpaid)
WITH all_reviews as(
    SELECT
        vine, 
        count(review_id) AS total_reviews
    FROM vine_table
	GROUP BY vine
),
five_star_reviews as(
	SELECT
        vine, 
        count(star_rating) AS five_stars
    FROM vine_table
	WHERE star_rating = '5'
	GROUP BY vine
)
SELECT
	all_reviews.vine,
    total_reviews,
    five_stars,
    CAST(five_stars AS FLOAT)/CAST(total_reviews AS FLOAT)*100 AS percentage_five_star
FROM all_reviews
JOIN five_star_reviews ON all_reviews.vine = five_star_reviews.vine;