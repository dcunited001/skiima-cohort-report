## Cohort Report

### Running the app

1. `bundle install`
1. `cp .env.sample .env` and configure db user/pass
1. `foreman start` to start postgres
1. Create `cohort` postgres database user.
1. `rake db:create` and/or restore the pg database
1. `psql -U $COHORT_DB_USER -d cohort_development < ./db/cohort_schema.sql` to create Users and Orders tables.
1. `rake db:seed` to seed or reseed tables with user data
1. `rake skiima:up` to load the views
1. `rackup` and view [localhost:9292](http://localhost:9292)

### Dropping/Reloading the views

If column names have changed, you'll need to drop and reload the views.  Run `rake skiima:down && rake skiima:up`