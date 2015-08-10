CREATE OR REPLACE VIEW "view_cohorts" AS
  SELECT
      date_trunc('week', "u"."created_at") AS "cohort_date"
    , count(*)                             AS "cohort_count"
  FROM "users" "u"
  GROUP BY "cohort_date"
