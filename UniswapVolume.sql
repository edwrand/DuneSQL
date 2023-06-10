SELECT
    DATE_TRUNC('month', block_time) AS month,
    SUM(value)/1e18 AS total_volume_in_eth
FROM ethereum.transactions
WHERE ("from" = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D OR "to" = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D)
-- the address above can be changed to view any smart contract deployed
    AND success = true  -- considering only successful transactions
GROUP BY DATE_TRUNC('month', block_time)
ORDER BY DATE_TRUNC('month', block_time) ASC;