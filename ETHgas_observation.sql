SELECT
    EXTRACT(year FROM block_time) AS year,
    CASE 
        WHEN EXTRACT(month FROM block_time) = 1 THEN 'January'
        WHEN EXTRACT(month FROM block_time) = 2 THEN 'February'
        WHEN EXTRACT(month FROM block_time) = 3 THEN 'March'
        WHEN EXTRACT(month FROM block_time) = 4 THEN 'April'
        WHEN EXTRACT(month FROM block_time) = 5 THEN 'May'
        WHEN EXTRACT(month FROM block_time) = 6 THEN 'June'
        WHEN EXTRACT(month FROM block_time) = 7 THEN 'July'
        WHEN EXTRACT(month FROM block_time) = 8 THEN 'August'
        WHEN EXTRACT(month FROM block_time) = 9 THEN 'September'
        WHEN EXTRACT(month FROM block_time) = 10 THEN 'October'
        WHEN EXTRACT(month FROM block_time) = 11 THEN 'November'
        WHEN EXTRACT(month FROM block_time) = 12 THEN 'December'
    END AS month,
    SUM(gas_used) AS total_gas_cost,
    AVG(max_fee_per_gas) AS average_gas_max_fee,
    AVG(gas_price) AS avg_gas_price
FROM ethereum.transactions
WHERE gas_used > 0 AND block_time > NOW() - interval '1' year
GROUP BY EXTRACT(year FROM block_time), EXTRACT(month FROM block_time)
ORDER BY EXTRACT(year FROM block_time) ASC, EXTRACT(month FROM block_time) ASC;