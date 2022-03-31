# README

##Project Description 
Treasure hunt is a simple game where players need to make requests to find treasure and players which are within 5 meters of radius should get an email with the treasure location and those players will be the winners

## Specifications  

* Ruby version: 2.7.1

* Rails version: 6.0.3

* Bundler version: 2.1.4

* Database: postgres

* Sidekiq: 6.1.3

* Sendgrid for production emails

* Redis: 5.0.0
## Project Prequisites
 * clone the project
 * install ruby 2.7.1 using rbenv or rvm
 * install postgresql
 * install and run redis
 * go inside project folder and run gem install bundler
 * run bundle install
 ##### Set environment variables
 * export DB_USER =
 * export DB_PASSWORD = 
 * export REDIS_URL =
 ######Production related envs
 * SENDGRID_API_KEY
 * APP_HOST
 * APP_DOMAIN
 ######Optional environment vars
 * TREASURE_LAT
 * TREASURE_LNG 
 * RADIUS_IN_METERS
 ## Running project locally
 * run rails db:create && rails db:migrate
 
## Test Project
 * run ```rspec``` inside project folder, it will execute all the test cases i.e. requests and models
 * you can also directly hit our apis using postman
 #### Apis details
 **URL** :base_url/api/v1/treasure_hunt.json POST
 
 **Example Request**
 ```
  {
      "email": "test@test.com",
      "current_location": [50.051225, 19.945702]
  }
 ```

 **Example Response**
  ```
    {
        "status": "ok",
        "distance": 0.2642881957215862
    }
  ```

  **URL** :base_url/api/v1/analytics.json GET
 
  **Example Request**
   ```
     {
       "from_time": "2022-03-31 10:00:00",
       "to_time": "2022-03-31 12:00:00",
       "radius": 5
     }
   ```

 **Example Response**
  ```
    {
        "requests": [{"email": "test@test.com", "current_location": ["50.051227", "19.945704"]]
    }
  ```
 
## Production Deployment Instructions
* I've added capistrano for production deployment on aws or digital ocean
* so basically 3 files Capfile, config/deploy.rb and config/deploy/production.rb is needed
* I've pushed all these 3 files, ideally we don't need to have them on repo and these should be in just local
* so in config/deploy.rb, we need to set our repo_url, application_name, branch and deploy_to etc
* In production.rb we need to add server details i.e. server ip with either main or deploy user
* In Capfile we need to add dependencies like rbenv, passenger which we've configured on production server
* This is the command for code deployment ```cap production deploy```, for staging ```cap staging deploy```
#####Note:
I've pushed capistrano files but normally we don't push these files, these 3 files should need to be in local environment