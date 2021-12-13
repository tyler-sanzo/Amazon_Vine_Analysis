# Amazon_Vine_Analysis

---

## Analysis Overview

Using Pyspark and natural language processing packages, we created dataframes and connected PGadmin with an AWD relational database and performed transformations to display data regarding review ratings.


## Results

After creating the necessary dataframes using pyspark, we were able to answer the following questions with these SQL queries.

```
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
```

### How many Vine reviews and non-Vine reviews were there?
There are 1781706 non-Vine reviews and 4291 Vine Reviews.

### How many Vine reviews were 5 stars? How many non-Vine reviews were 5 stars?
We have 1025317 non-Vine 5 star reviews and 1607 Vine 5 star reviews.

### What percentage of Vine reviews were 5 stars? What percentage of non-Vine reviews were 5 stars?
Percentage of 5 star non-Vine reviews is 57.55% and 5 star Vine reviews is 37.45%.


---


## Summary

Vine reviews do not seem to contain a positivity bias based on this analysis. In fact, there are much less 5 star reviews coming from the vine program than there are from non-vine reviews. Non-vine reviews seem less critical of the products overall in comparison. 

One additional analysis that could be performed is comparing the averages between vine and non-vine reviews. This would give us an idea of whether or not the overall scores were heavily influenced by vine reviews.
