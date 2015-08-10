require 'bundler'
Bundler.require
Dotenv.load

require 'erubis'
require 'pg'
require 'active_record'
require 'sinatra'
require 'sinatra/activerecord'

Dir['./models/*.rb'].each { |f| require f }

rack_env = ENV['RACK_ENV'] || 'development' # for rake tasks
erb_yaml = Erubis::Eruby.new(File.read('./db/database.yml'))
db_params = YAML.load(erb_yaml.result(binding()))[rack_env]

set :database, db_params

get '/' do
  first_cohort = Cohort.order(:cohort_date).first.cohort_date
  last_cohort = Cohort.order(:cohort_date).last.cohort_date + 1.week
  @start, @end = [first_cohort, last_cohort].map {|c| c.strftime('%-m/%-d/%Y 0:00:00') }
  erb :new, layout: :layout
end

post '/cohort_report' do
  @start, @end = params[:startdate], params[:enddate]

  @cohorts = Cohort.
      where("cohort_date >= ? and cohort_date <= ?", @start, @end).
      order("cohort_date desc").all
  report_start = @cohorts.last.cohort_date
  @buckets = @cohorts.map {|c| (c.cohort_date.to_i - report_start.to_i) / 24 / 60 / 60 }.reverse
  @orderers = reduce_orders_by_cohort(@cohorts, Orderer.select("cohort_date, order_bucket, count(*) as order_count").
      where("cohort_date >= ? and cohort_date <= ?", @start, @end).
      group("cohort_date, order_bucket").
      order("cohort_date asc, order_bucket asc"))
  @first_time_orderers = reduce_orders_by_cohort(@cohorts, FirstTimeOrderer.select("cohort_date, order_bucket, count(*) as order_count").
      where("cohort_date >= ? and cohort_date <= ?", @start, @end).
      group("cohort_date, order_bucket").
      order("cohort_date asc, order_bucket asc"))

  erb :index, layout: :layout
end

def reduce_orders_by_cohort(cohorts, coll)
  init_hash = cohorts.reduce({}) {|m, c| m[c.cohort_date.to_s] = { total: 0 }; m}
  coll.reduce(init_hash) do |m, c|
    m[c.cohort_date.to_s][:total] += c.order_count
    m[c.cohort_date.to_s][c.order_bucket] = c.order_count
    m
  end
end

def format_percentage(orderers, cohort_count)
  ('%.1f' % (100.0 * orderers / cohort_count))
end
