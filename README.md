# Assessment Network Interactions API

[![Build Status](https://travis-ci.org/a15k/interactions-api.svg?branch=master)](https://travis-ci.org/a15k/interactions-api)

## Autogenerating bindings

`rake generate_model_bindings[X]` will create version X request and response model bindings in `app/bindings/api/vX`.

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
