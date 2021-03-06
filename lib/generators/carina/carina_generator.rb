class CarinaGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_install_file
    empty_directory "carina"
    empty_directory "carina/ssl"

    copy_file "lib", "carina/lib"
    copy_file "deploy", "carina/deploy"
    copy_file "config", "carina/config"
    copy_file "backup", "carina/backup"
    copy_file "logstash.conf", "carina/logstash.conf"
    copy_file "puma.rb", "config/puma.rb"
    copy_file "Dockerfile", "Dockerfile"

    chmod "carina/lib", 0777
    chmod "carina/deploy", 0777
    chmod "carina/config", 0777
    chmod "carina/backup", 0777

    prod_log = %q{
      require 'logstash-logger'
      config.log_level                    = :debug
      config.autoflush_log                = true
      config.logstash.formatter           = :json_lines
      config.logstash.buffer_max_items    = 50
      config.logstash.buffer_max_interval = 5
      config.logstash.host                = 'logstash'
      config.logstash.type                = :udp
      config.logstash.port                = 5228
    }

    gems = %q{
      gem 'logstash-logger'
      gem 'pg'
      gem 'puma'
    }

    db = %q{
      production:
        adapter: postgresql
        encoding: unicode
        database: <DatabaseName>
        pool: 5
        username: <%= ENV['POSTGRES_USER'] %>
        password: <%= ENV['POSTGRES_PASSWORD'] %>
        host: db
    }

    puts "\n"
    puts "Please add the following code into config/environments/production.rb:"
    puts prod_log

    puts "\n"
    puts "Please add the following gems to your Gemfile:"
    puts gems

    puts "\n"
    puts "Please update config/database.yml:"
    puts db
  end
end
