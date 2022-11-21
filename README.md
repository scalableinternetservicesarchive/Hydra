# Hydra, a Social Network

## Introduction

Hydra is a twitter-like social network. 

## Designs

### MVC Figure

![image-20221030163639716](README.assets/image-20221030163639716.png)

### UI Mockups

## Steps to seed in app server
- Add `gem "web-console"` to your Gemfile and run `docker-compose run web bundle install` and `docker-compose run web yarn install` for the updated Gemfile.lock and yarn.lock.
- In config/environments/production.rb, add `config.web_console.development_only = false` to enable running web console on the app server.
- On AWS, find the IP address of the app server instance (go to EC2, then go inside your instance. Click "connect", go to "ssh client" tab, and find a line looking like `ssh -i "Hydra.pem" root@ec2-54-213-63-159.us-west-2.compute.amazonaws.com`. Change the "root" to "ec2-user", then run it.
- Once on the app server, run `cd /var/app/current`, then `RAILS_ENV=production bundle exec rake db:seed`

## Steps to get your tsung log to local machine
- Assuming your tsung instance IP address is 34.222.195.237, from your local machine, run `rsync -auvL -e "ssh -i Hydra.pem" ec2-user@34.222.195.237:tsung_logs .` to get the logs. 

## Steps to import data from local DB to AWS RDS

### Dump data in a sql file from local db

Since we are using docker as our local environment, first we need to get the docker container name in which the database is running. You can use ```docker ps``` command to get this. Then run the following commands:
```
docker exec -t your-db-container-name pg_dump your-db-name -U your-db-username > your-dump-filename.sql
```
```-a``` will dump the data only, not the schema. 
Example: 
```
docker exec -t hydra_db_1 pg_dump app_development -a  -U postgres  > dump_hydra.sql
```
### Upload data to AWS RDS

You need to have ```psql``` installed in your local machine. ```psql``` is a terminal-based front-end to PostgreSQL. For installation, you ca use this [link](https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/).

Then, run following command:
```
psql -f your-dump-filename.sql --host your-db-hostname-in-aws-rds --port post-used-in-your-dbhost --username your-aws-rds-dbusername  --dbname your-aws-rds-dbname
```
AWS RDS database details can be found inside the configuration file of your Elastic Benstalk environment.

Example:
```
psql -f dump_hydra.sql --host awseb-e-dxp3aesnek-stack-awsebrdsdatabase-slfaoe0pa7gq.cxsnhvva4y19.us-west-2.rds.amazonaws.com --port 5432 --username u  --dbname ebdb
```
It will ask to input the password you provided during the deployment. 

Done. Now you can able to see the data browsing your site.


