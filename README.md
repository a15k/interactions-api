# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# TODOs

1. Allow CORS for whitelisted origins (based on app users)
2. Rest of Flags controller
2. Presentations controller
3. Ratings controller
4. Getting accept header to display in swagger-ui
5. Set known apps and settings from interactions-site via an API
6. rack-attack to throttle requests (e.g. flags X/min)
7. Require SSL
8. Clean out un-needed dependencies

# Notes

* `swagger-codegen generate -i http://localhost:3000/api/docs/v1 -l ruby -Dmodels -o /tmp/codegen` to generate models
