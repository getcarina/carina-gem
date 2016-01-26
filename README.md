# Carina

This gem will create and help maintain an average Rails-based application's infrastructure needs on Rackspace's Carina offering ([GetCarina.com](https://getcarina.com))

#### Install
Add this to your `Gemfile`:
`gem 'carina'`

#### Generate
`rails g carina install`

#### Create Carina cluster (FREE)
`brew install carina`
`carina create <ClusterName>`

#### Configure
`vim carina/config`

#### Quickstart
`./carina/deploy bootstrap`

#### Deploying changes
`./carina/deploy latest`

#### Backing up Postgresql
`./carina/backup postgresql`

#### All Commands
```
./carina/deploy help

Commands:
  deploy bootstrap       # Build everything (idempotent)
  deploy db_setup        # Rebuild, load, migrate and seed the database
  deploy elasticsearch   # Rebuild the ElasticSearch container
  deploy help [COMMAND]  # Describe available commands or one specific command
  deploy image           # Rebuild the Rails image with current code
  deploy info            # Show the IP and port(s) your application is available
  deploy interlock       # Rebuild the Interlock container
  deploy kibana          # Rebuild the Kibana container
  deploy latest          # Deploy the latest Rails code
  deploy logstash        # Rebuild the Logstash container
  deploy postgres        # Rebuild the Postgresql container


./carina/backup help

Commands:
  backup help [COMMAND]  # Describe available commands or one specific command
  backup postgresql      # Backup Postgresql to file
```  

#### URLs
* Main site: `http(s):\\<Domain>`
* Kibana: `http:\\<Domain>:5601`
* HAProxy: `http:\\<Domain>/haproxy?monitor`

#### Caveats
* This setup requires you access the cluster via domain name. If you're testing locally you can update your `/etc/hosts` file like so: `<ClusterIP> <DomainName>`
