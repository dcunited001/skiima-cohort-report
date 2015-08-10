CREATE OR REPLACE FUNCTION "fn_get_bucket_from_order_date"(
  "user_created_at" "timestamp",
  "order_created_at" "timestamp")
  RETURNS INT AS $$
    DECLARE
      user_created_day timestamp := date_trunc('day', user_created_at);
      order_day timestamp := date_trunc('day', order_created_at);

BEGIN
-- returns the integer number of days, div 7,
-- representing the number of days after user creation that the user placed an order
  -- if 0-6 days, returns zero.  7-13 days, returns 7.
  -- if user was created on day 6 and placed an order on day 8 (+2 days), returns 0
  -- if user was created on day 6 and placed an order on day 13 (+7 days), returns 7
  RETURN (cast(extract(epoch from (order_day - user_created_day)) as integer) / 7 / 24 / 60 / 60) * 7;

END;
$$

LANGUAGE plpgsql
IMMUTABLE
RETURNS NULL ON NULL INPUT;
