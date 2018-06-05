# Assessment Network Interactions API

[![Build Status](https://travis-ci.org/a15k/interactions-api.svg?branch=master)](https://travis-ci.org/a15k/interactions-api)
[![codecov](https://codecov.io/gh/a15k/interactions-api/branch/master/graph/badge.svg)](https://codecov.io/gh/a15k/interactions-api)

## Autogenerating bindings

`rake generate_model_bindings[X]` will create version X request and response model bindings in `app/bindings/api/vX`.  These are for
use inside the interactions API code.

## Autogenerating clients

Swagger-codegen generated clients live inside this baseline.  There is a rake task to generate the client code.  Call
`rake generate_client[X,lang]` to generate the major version X client for the given language, e.g. `rake generate_client[0,ruby]`
will generate the Ruby client for the latest version 0 API.

# TODOs

1. Allow CORS for whitelisted origins (based on app users)
1. Redis namespaces (interactions-api-test) and make sure database cleaning is compatible
2. Rest of Flags controller
2. Presentations controller
3. Generate JS client lib and test from rspec (?) - can we autogenerate the client in Travis in a separate repo or travis build and test when this baseline changes?
3. Should we allow API token in lieu of api ID and domain if provided?  If so change authenticate method names?
3. Ratings controller
4. Getting accept header to display in swagger-ui
5. Set known apps and settings from interactions-site via an API
6. rack-attack to throttle requests (e.g. flags X/min)
7. Require SSL
8. Clean out un-needed dependencies

# Notes
