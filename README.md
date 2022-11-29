# Hydra, a Social Network

## Introduction

Hydra is a twitter-like social network. 

## Designs

### MVC Figure

![image-20221030163639716](README.assets/image-20221030163639716.png)

### UI Mockups

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

### Run seed file on AWS
- ssh into app server
- Run `sudo su`, then `/opt/elasticbeanstalk/bin/get-config environment | jq -r 'to_entries | .[] | "export \(.key)=\"\(.value)\""' > /etc/profile.d/sh.local`
- Run `chmod 777 /etc/profile.d/sh.local`
- disconnect from the app server
- ssh into app server again, then run `cd /var/app/current && bin/rails db:seed`. Ignore the errors and wait until the command is finished, and the app server should be seeded.

### Upload data to AWS RDS

You need to have ```psql``` installed on your local machine. ```psql``` is a terminal-based front-end to PostgreSQL. For installation, you can use this [link](https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/).

Then, run following command:
```
psql -f your-dump-filename.sql --host your-db-hostname-in-aws-rds --port port-used-in-your-aws-rds --username your-aws-rds-dbusername  --dbname your-aws-rds-dbname
```
AWS RDS database details can be found inside the configuration file of your Elastic Benstalk environment.

Example:
```
psql -f dump_hydra.sql --host awseb-e-dxp3aesnek-stack-awsebrdsdatabase-slfaoe0pa7gq.cxsnhvva4y19.us-west-2.rds.amazonaws.com --port 5432 --username u  --dbname ebdb
```
It will ask the password you provided during the deployment. 

Done! Now you can see the data browsing your site.

## Steps to run Tsung
### Create new AWS instance for Tsung
Login to ec2 machine:
```
ssh -i Hydra.pem Hydra@ec2.cs291.com
```
Launch Tsung
```
cd /usr/bin
launch_tsung.sh
```
This will output the ip address of the ec2 instance. ssh to that machine. Say the ip address is 35.86.238.45

```
ssh ec2-user@35.86.238.45
```
### Log into existing Tsung instance
If we have Tsung instances available, we don't need to create new ones. Go to the [AWS management website](https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#Home:) and go to EC2 page. Then click into the instance (named Tsung-Hydra) and click "Connect". You will find "SSH client" tab, which will have something like:
```
ssh -i "Hydra.pem" root@ec2-44-234-188-29.us-west-2.compute.amazonaws.com
```
Replace the `root` by `ec2-user`, and you can log into the instance directly.

### Run Tsung test
```
tsung -f tsung_example.xml -k start
```
 -k flag  in the above step : keep the server running even after the test is done, so that we can analyze the various metrics from the test.
 
 ### Copy tsung logs from ec2 to local:
 ```
 scp -i local-directory -r ec2-user@35.86.238.45: Log-directory ~/tsung-paginated-logs-view-users/
 ```
 Example:
 ```
 scp -i ~/Downloads/Hydra.pem -r ec2-user@35.86.238.45:/home/ec2-user/.tsung/log/20221122-0157 ~/tsung-paginated-logs-view-users/ ```
