class CarinaGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_install_file
    empty_directory "carina"
    empty_directory "carina/ssl_certs"

    copy_file "build", "carina/build"
    copy_file "deploy", "carina/deploy"
    copy_file "logstash.conf", "carina/logstash.conf"
    copy_file "puma.rb", "config/puma.rb"
    copy_file "Dockerfile", "Dockerfile"
    copy_file "vars", "vars"

    chmod "carina/build", 0777
    chmod "carina/deploy", 0777

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

    puts "\n"
    puts "Please add the following code into config/environments/production.rb:"
    puts prod_log

    puts "\n"
    puts "Please add the following gems to your Gemfile:"
    puts gems

    puts "\n"
    puts "Now create a Carina cluster at getcarina.com."
  end
end
