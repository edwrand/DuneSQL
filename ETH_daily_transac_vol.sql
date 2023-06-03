WITH send AS (
    SELECT 
        call_block_time,
        _dstChainId,
        101 as _srcChainId -- Set _srcChainId to the Ethereum chain ID
    FROM layerzero_ethereum.Endpoint_call_send
    WHERE call_success = true
),
send2 AS (
    SELECT 
        call_block_time,
        CAST(CASE 
            WHEN _dstChainId = 101 THEN 'ethereum'
            -- Remove mappings for other chains
            ELSE CAST(_dstChainId AS VARCHAR(8))
        END AS VARCHAR(8)) AS dstChain,
        CAST(CASE 
            WHEN _srcChainId = 101 THEN 'ethereum'
            -- Remove mappings for other chains
            ELSE CAST(_srcChainId AS VARCHAR(8))
        END AS VARCHAR(8)) AS srcChain
    FROM send
)
SELECT 
    *,
    SUM(num_daily_tx) OVER (ORDER BY day) as num_cumul_tx
FROM (
    SELECT 
        date_trunc('day', call_block_time) as day,
        COUNT(*) AS num_daily_tx
    FROM send2
    GROUP BY 1
) AS daily_tx;
