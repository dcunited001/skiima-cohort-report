CREATE OR REPLACE VIEW "view_first_time_orders" AS
  SELECT
      "u"."id"              AS "user_id"
    , min("o"."created_at") AS "first_order_date"
  FROM "users" "u"
    INNER JOIN "orders" "o"
      ON "o"."user_id" = "u"."id"
  GROUP BY "u"."id"
