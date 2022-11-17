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
- Once on the app server, run `cd /var/app/current`, then `bin/rails db:seed`

## Steps to get your tsung log to local machine
- Assuming your tsung instance IP address is 34.222.195.237, from your local machine, run `rsync -auvL -e "ssh -i Hydra.pem" ec2-user@34.222.195.237:tsung_logs .` to get the logs. 
