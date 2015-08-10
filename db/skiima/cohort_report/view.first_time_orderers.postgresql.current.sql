CREATE OR REPLACE VIEW "view_first_time_orderers" AS
  SELECT
      date_trunc('week', "u"."created_at")                                      AS "cohort_date"
    , fn_get_bucket_from_order_date("u"."created_at", "fto"."first_order_date") AS "order_bucket"
    , count(*)                                                                  AS "order_count"
    , "fto"."user_id"
  FROM "view_first_time_orders" "fto"
    INNER JOIN "users" "u"
      ON "u"."id" = "fto"."user_id"
  GROUP BY "cohort_date", "order_bucket", "fto"."user_id"
