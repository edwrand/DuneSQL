SELECT SUM(gas_used * base_fee_per_gas) / 1e18 AS eth_burned
FROM ethereum."blocks"