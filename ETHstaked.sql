WITH
  cte AS (
    SELECT
      DATE_TRUNC('{{Granularity}}', block_time) AS time,
      SUM(value) / CAST(1e18 AS DOUBLE) AS granular_total
    FROM
      ethereum.traces
    WHERE
      to = 0x00000000219ab540356cBB839Cbe05303d7705Fa
      AND success
    GROUP BY
      1
  )
SELECT
  time,
  granular_total,
  SUM(granular_total) OVER (
    ORDER BY
      time NULLS FIRST RANGE BETWEEN UNBOUNDED PRECEDING
      AND CURRENT ROW
  ) AS cum_total
FROM
  cte
ORDER BY
  1 NULLS FIRST