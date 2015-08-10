CREATE OR REPLACE VIEW "view_orderers" AS
  SELECT
      date_trunc('week', "u"."created_at")                              AS "cohort_date"
    , fn_get_bucket_from_order_date("u"."created_at", "o"."created_at") AS "order_bucket"
    , count(*)                                                          AS "order_count"
    , "user_id"
  FROM "orders" "o"
    INNER JOIN "users" "u"
      ON "u"."id" = "o"."user_id"
  GROUP BY "cohort_date", "order_bucket", "user_id"
