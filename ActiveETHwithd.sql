SELECT COUNT(DISTINCT address) AS active_wallets
FROM ethereum.withdrawals
WHERE amount > 0 AND block_time > NOW() - interval '1' year
/*
Attempting to group by months over all the data
*/
GROUP BY DATE_TRUNC('month', block_time)
ORDER BY DATE_TRUNC('month', block_time) ASC;