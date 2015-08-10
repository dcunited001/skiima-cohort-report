require 'bundler'
Bundler.require
Dotenv.load

rack_env = ENV['RACK_ENV'] || 'development' # for rake tasks
erb_yaml = Erubis::Eruby.new(File.read('./db/database.yml'))
db_params = YAML.load(erb_yaml.result(binding()))

def database_exists?(name, opts = {})
  q = <<-SQL
      SELECT COUNT(*)
          FROM pg_catalog.pg_database pdb
          WHERE pdb.datname = '&database'
  SQL
  ActiveRecord::Base.connection.query(q.gsub!('&database', name))[0][0].to_i > 0
end

require 'skiima'

namespace :db do
  desc 'load only the database connection for the application'
  task :connection do
    # sinatra-activerecord is really, really making this complicated
    ActiveRecord::Base.establish_connection db_params[rack_env].merge('database' => 'postgres')
  end

  desc 'create the databases without loading sinatra code'
  task :create => :connection do
    ['development', 'test', 'production'].each do |env|
      db = db_params[env]['database']
      puts db
      ActiveRecord::Base.connection.create_database(db) unless database_exists?(db)
    end
  end

  desc 'load the db backup into a pg database'
  task :load => :connection do
    puts("psql #{ActiveRecord::Base.connection} <")
  end
end

namespace :cohort do
  desc 'load the cohort application environment'
  task :env do
    require './app'
    require 'sinatra/activerecord/rake' # honestly this isn't going to work
  end
end


namespace :skiima do
  desc "setup skiima environment for rake tasks"
  task :setup do
    Skiima.setup do |s|
      s.config_path = 'db'
      s.scripts_path = 'db/skiima'
      s.locale = :en
    end
  end

  desc "load views into database"
  task :up => :setup do
    Skiima.up(rack_env.to_sym, :default)
  end

  desc "load views into database"
  task :down => :setup do
    Skiima.down(rack_env.to_sym, :drop_scripts)
  end
end


