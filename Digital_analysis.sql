SELECT * FROM  BRAND LIMIT 5;
1. Which top 5 campaigns generated the highest Revenue-to-Cost ratio (ROAS), and what was their total reach?

SELECT 
    campagin_name, 
    SUM(revenue) AS total_revenue, 
    SUM(cost) AS total_cost,
    ROUND(SUM(revenue) / NULLIF(SUM(cost), 0), 2) AS ROAS,
    SUM(reach) AS total_reach
FROM marketing_data
GROUP BY campagin_name
ORDER BY ROAS DESC
LIMIT 5;

2.Do holidays significantly drive higher conversion rates compared to non-holidays, and how does this vary by season?

SELECT 
    season,
    `is_holiday (text)`,
    AVG(conversions / NULLIF(clicks, 0)) AS avg_conversion_rate,
    SUM(revenue) AS total_revenue
FROM marketing_data
GROUP BY season, `is_holiday (text)`
ORDER BY season, avg_conversion_rate DESC;

3.What is the average Cost Per Conversion (CPC) for each market tier, and which tier is the most expensive to acquire customers in?

SELECT 
    market_tier,
    SUM(cost) AS total_spend,
    SUM(conversions) AS total_conversions,
    ROUND(SUM(cost) / NULLIF(SUM(conversions), 0), 2) AS cost_per_conv
FROM marketing_data
GROUP BY market_tier
ORDER BY cost_per_conv DESC;

4.Is there a correlation between high frequency (how many times a person sees an ad) and the Click-Through Rate (CTR)?

SELECT 
    campagin_name,
    AVG(frequency) AS avg_frequency,
    (SUM(clicks) / SUM(impressions)) * 100 AS CTR_percentage
FROM marketing_data
GROUP BY campagin_name
HAVING avg_frequency > 1.0
ORDER BY avg_frequency DESC;

5.For campaigns that include video, what is the "Cost per Video View," and how does it compare across different countries?


SELECT 
    country,
    SUM(video_views) AS total_views,
    SUM(cost) AS total_cost,
    ROUND(SUM(cost) / NULLIF(SUM(video_views), 0), 4) AS cost_per_view
FROM marketing_data
WHERE video_views > 0
GROUP BY country
ORDER BY cost_per_view ASC;